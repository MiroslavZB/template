import 'package:firebase_auth/firebase_auth.dart';
import 'package:template/components/snapshot_helpers.dart';
import 'package:template/index.dart';
import 'package:template/modules/authentication/authentication.dart';
import 'package:template/modules/authentication/init_user.dart';
import 'package:template/modules/authentication/pages/login_page.dart';

bool hasSetUser = false;

class AuthWrap extends StatelessWidget {
  final Widget child;
  final Widget? fallback;

  const AuthWrap({super.key, required this.child, this.fallback});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: Authentication.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: pad(tp: 10),
            child: const LoadingInfo(),
          );
        }

        if (snapshot.hasError) {
          Crashlytics.report(snapshot.error, reason: 'on_auth_state_changed_error');
          return const ErrorInfo();
        }

        if (snapshot.hasData) {
          return FutureBuilder(
            future: initUser(),
            builder: (_, AsyncSnapshot<void> snapshot) {
              if (snapshot.hasError) {
                Crashlytics.report(snapshot.error, reason: 'init_user_error');
                return const NoInternetInfo();
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingInfo();
              }
              return child;
            },
          );
        }

        return fallback ?? const LoginPage();
      },
    );
  }
}
