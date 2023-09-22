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
          return snapshotInfo(child: const CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return snapshotInfo(child: const Text('Something went wrong'));
        } else if (snapshot.hasData) {
          return FutureBuilder(
            future: initUser(snapshot.data!.uid),
            builder: (_, AsyncSnapshot<void> snapshot) {
              if (snapshot.hasError) {
                Crashlytics.report(snapshot.error, reason: 'on_auth_state_changed_error');
                return snapshotInfo(child: txts('Error: No internet connection!'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return snapshotInfo(
                  children: [
                    const CircularProgressIndicator(),
                    Padding(
                      padding: pad(rp: 10),
                      child: txts('Loading...'),
                    ),
                  ],
                );
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
