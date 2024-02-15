import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:template/functions/go_to_home.dart';
import 'package:template/functions/unfocus.dart';
import 'package:template/index.dart';
import 'package:template/modules/authentication/functions/error_handling.dart';
import 'package:template/modules/user/user_controller.dart';
import 'package:template/services/database.dart';
import 'package:template/utils/dialogs/confirmation_dialog.dart';
import 'package:template/utils/dialogs/get_dialog.dart';
import 'package:template/utils/dialogs/unexpected_error_dialog.dart';

enum ThirdPartySignIn {
  google,
  apple,
  facebook;
}

class Authentication {
  static String? _lastEmail;

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Getters
  static FirebaseAuth get auth => _auth;
  static Stream<User?> get onAuthStateChanged => _auth.authStateChanges();

  // User Getters
  static User? get user => _auth.currentUser;
  static bool get hasUser => user != null;
  static String? get id => user?.uid;

  static dynamic get provider {
    final String? providerId = Authentication.user?.providerData.firstOrNull?.providerId;
    if (providerId == null) return 'none';
    if (providerId.contains('google')) return ThirdPartySignIn.google;
    if (providerId.contains('apple')) return ThirdPartySignIn.apple;
    if (providerId.contains('facebook')) return ThirdPartySignIn.facebook;
    if (providerId.contains('password')) return 'email';
    return 'none';
  }

  static const notFirebaseAuthException = 'NOT FirebaseAuthException';

  static Future<void> thirdPartySignIn(ThirdPartySignIn type) async {
    AuthCredential? credential;

    switch (type) {
      case ThirdPartySignIn.google:
        credential = await _tryGetGoogleCredential();
        break;
      case ThirdPartySignIn.apple:
        credential = await _tryGetAppleCredential();
        break;
      default:
        return getDialog(
          short: get.authError,
          middle: 'The provider ${type.name} is not supported yet!',
        );
    }

    if (credential == null) return unexpectedErrorDialog();

    try {
      await _auth.signInWithCredential(credential);

      goToHome();
    } on FirebaseAuthException catch (e, s) {
      await handleSignInWithCredential(e, s, _lastEmail);
    } catch (e, s) {
      Crashlytics.report(e, trace: s, reason: 'thirdPartySignIn $notFirebaseAuthException}');
      return unexpectedErrorDialog();
    }
  }

  static Future<void> safeEmailSignIn(String email, String password) async {
    try {
      unfocus();
      _lastEmail = email;
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      goToHome();
    } on FirebaseAuthException catch (e, s) {
      await handleSignInWithEmailFirebaseAuthException(
        e,
        s,
        () => confirmationDialog(
          middle: get.accountWithThisEmailDoesntExist(email),
          onSuccess: () => _createEmailAccount(email: email, password: password),
        ),
      );
    } catch (e, s) {
      Crashlytics.report(e, trace: s, reason: 'safeEmailSignIn $notFirebaseAuthException');
      return unexpectedErrorDialog();
    }
  }

  static Future<void> _createEmailAccount({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await getDialog(
        short: get.confirmation,
        middle: get.anEmailWithStepsToConfirmYourAddress(email),
      );

      await safeEmailSignIn(email, password);
    } on FirebaseAuthException catch (e, s) {
      await handleCreateUserWithEmailAndPasswordFirebaseAuthException(e, s);
    } catch (e, s) {
      Crashlytics.report(e, trace: s, reason: '_createEmailAccount $notFirebaseAuthException');
      return unexpectedErrorDialog();
    }
  }

  static Future<void> resetPassword(String email) async {
    unfocus();
    try {
      await _auth.sendPasswordResetEmail(email: email);

      getDialog(
        short: get.confirmation,
        middle: get.anEmailWithStepsToReset(email),
      );
    } on FirebaseAuthException catch (e, s) {
      await handleSendPasswordResetEmailFirebaseAuthException(e, s);
    } catch (e, s) {
      Crashlytics.report(e, trace: s, reason: 'resetPassword  $notFirebaseAuthException');
      return unexpectedErrorDialog();
    }
  }

  static Future<void> updateName(String? name) async => user?.updateDisplayName(name);

  static Future<void> deleteUser() async {
    try {
      final id = user!.uid;

      await Authentication.user?.delete();

      await Database.deleteAllUser(id);
      Get.put(UserController()).clear();

      goToHome();
    } on FirebaseAuthException catch (e, s) {
      await handleDeleteAccountFirebaseAuthException(e, s);
    } catch (e, s) {
      Crashlytics.report(e, trace: s, reason: 'deleteAllUser $notFirebaseAuthException');
      return unexpectedErrorDialog();
    }
  }

  static Future<AuthCredential?> _tryGetGoogleCredential() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return null;

      _lastEmail = googleUser.email;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      return GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    } catch (e, s) {
      Crashlytics.report(e, trace: s, reason: '_tryGetGoogleCredential');
    }
    return null;
  }

  static Future<AuthCredential?> _tryGetAppleCredential() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email],
      );

      _lastEmail = appleCredential.email;

      return OAuthProvider('apple.com').credential(
        accessToken: appleCredential.authorizationCode,
        idToken: appleCredential.identityToken,
      );
    } catch (e, s) {
      Crashlytics.report(e, trace: s, reason: '_tryGetAppleCredential');
    }
    return null;
  }
}
