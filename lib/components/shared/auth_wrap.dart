import 'package:template/components/shared/snapshot_info.dart';
import 'package:template/functions/fetch_and_set_user_from_database.dart';
import 'package:template/pages/login_page.dart';
import 'package:template/services/authentication.dart';
import 'package:template/services/crashlytics.dart';
import 'package:template/utils/custom_widgets/custom_widgets_index.dart';
import 'package:firebase_auth/firebase_auth.dart';

bool hasSetUser = false;

class AuthWrap extends StatelessWidget {
  const AuthWrap({super.key, required this.page});

  final Widget page;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: Authentication.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingInfo();
        }

        if (snapshot.hasError) {
          Crashlytics.report(snapshot.error, reason: 'on_auth_state_changed_error');
          return errorInfo();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {}

        if (snapshot.hasData) {
          return FutureBuilder(
            future: initUser(snapshot.data!.uid),
            builder: (_, AsyncSnapshot<void> snapshot) {
              if (snapshot.hasError) {
                Crashlytics.report(snapshot.error, reason: 'init_user_error');
                return noInternetInfo();
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return loadingInfo();
              }
              return page;
            },
          );
        }

        return const LoginPage();
      },
    );
  }

  Future<void> initUser(String id) async {
    if (hasSetUser) return;
    await fetchAndSetUserFromDatabase(id);
    hasSetUser = true;
  }
}
