import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:template/functions/unfocus.dart';
import 'package:template/index.dart';
import 'package:template/utils/dialogs/confirmation_dialog.dart';
import 'package:template/utils/dialogs/get_dialog.dart';

enum ThirdPartySignIn {
  google,
  apple;
}

class Authentication {
  static String? _lastEmail;

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Getters
  static FirebaseAuth get auth => _auth;
  static User? get user => _auth.currentUser;
  static Stream<User?> get onAuthStateChanged => _auth.authStateChanges();

  static Future<void> thirdPartySignIn(ThirdPartySignIn type) async {
    AuthCredential? credential;

    if (type == ThirdPartySignIn.google) {
      try {
        final googleUser = await GoogleSignIn().signIn();

        if (googleUser == null) return;

        _lastEmail = googleUser.email;

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      } catch (e, s) {
        Crashlytics.report(e, trace: s, reason: 'thirdPartySignIn - Google');
      }
    }

    if (type == ThirdPartySignIn.apple) {
      try {
        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [AppleIDAuthorizationScopes.email],
        );

        _lastEmail = appleCredential.email;

        credential = OAuthProvider('apple.com').credential(
          accessToken: appleCredential.authorizationCode,
          idToken: appleCredential.identityToken,
        );
      } catch (e, s) {
        Crashlytics.report(e, trace: s, reason: 'thirdPartySignIn - Apple');
      }
    }

    if (credential == null) return getDialog(short: get.authError, middle: get.anUnexpectedError);

    try {
      await _auth.signInWithCredential(credential);

      Get.until((route) => Get.currentRoute == '/');
    } on FirebaseAuthException catch (e, s) {
      String? message;
      switch (e.code) {
        case 'account-exists-with-different-credential':
          message = 'An account with this email already exists with a different provider.'
              'Please, try a different sign-in method.';
          {
            if (_lastEmail == null) break;
            final providers = await _auth.fetchSignInMethodsForEmail(_lastEmail!);
            final authProvider = providers.firstOrNull;
            if (authProvider == null) break;

            message = 'An account with this email is already registered with a different provider.'
                ' Please use your $authProvider account to sign in.';
            break;
          }
        default:
          break;
      }
      Crashlytics.report(e,
          trace: s, reason: 'thirdPartySignIn FIREBASE error: type - ${type.name} -> error: $e \ncode: ${e.code}');

      return getDialog(short: get.error, middle: message ?? get.anUnexpectedError);
    } catch (e, s) {
      Crashlytics.report(e,
          trace: s, reason: 'thirdPartySignIn NOT FIREBASE eror: type - ${type.name} -> error: $e');
      return getDialog(short: get.error, middle: get.anUnexpectedError);
    }
  }

  static void safeEmailSignIn(String email, String password) async {
    try {
      unfocus();
      _lastEmail = email;
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Get.until((route) => Get.currentRoute == '/');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return getDialog(short: get.error, middle: get.invalidEmail);
        case 'user-disabled':
          return getDialog(short: get.error, middle: get.accountDisabled);
        case 'wrong-password':
          return getDialog(short: get.error, middle: get.wrongPassword);

        case 'INVALID_LOGIN_CREDENTIALS':
        case 'user-not-found':
          {
            confirmationDialog(
              middle: get.accountWithThisEmailDoesntExist(email),
              onSuccess: () async {
                _createEmailAccount(email: email, password: password).then((bool value) async {
                  if (value) {
                    await getDialog(
                      short: get.confirmation,
                      middle: get.anEmailWithStepsToConfirmYourAddress(email),
                    );
                    safeEmailSignIn(email, password);
                  }
                });
              },
            );
            return;
          }
        default:
          {
            Crashlytics.report(e, reason: 'safeEmailSignIn error: $e, e.code: ${e.code}');
            getDialog(short: get.error, middle: get.anUnexpectedError);
            return;
          }
      }
    } catch (e, s) {
      Crashlytics.report(e, trace: s, reason: 'safeEmailSignIn error NOT FirebaseAuthException');
    }
  }

  static Future<bool> _createEmailAccount({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        getDialog(short: get.error, middle: get.weakPassword);
      } else {
        getDialog(short: get.error, middle: get.invalidEmail);
      }

      return false;
    } catch (e, s) {
      Crashlytics.report(e, trace: s, reason: '_createEmailAccount error NOT FirebaseAuthException');
      return false;
    }
    return true;
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
      switch (e.code) {
        case 'invalid-email':
          return getDialog(short: get.error, middle: get.invalidEmail);

        case 'user-not-found':
          return getDialog(short: get.error, middle: get.userNotFound);

        case 'missing-android-pkg-name':
        case 'missing-continue-uri':
        case 'missing-ios-bundle-id':
        case 'invalid-continue-uri':
        case 'unauthorized-continue-uri':
        default:
          {
            Crashlytics.report(e, trace: s, reason: 'resetPassword, e.code: ${e.code}');
            getDialog(short: get.error, middle: get.anUnexpectedError);
            return;
          }
      }
    } catch (e, s) {
      Crashlytics.report(e, trace: s, reason: 'resetPassword error NOT FirebaseAuthException');
      return;
    }
  }

  static Future<void> updateName(String? name) async => await user?.updateDisplayName(name);
}
