import 'package:firebase_auth/firebase_auth.dart';
import 'package:template/l10n/localizations.dart';
import 'package:template/modules/authentication/authentication.dart';
import 'package:template/services/crashlytics.dart';
import 'package:template/utils/dialogs/get_dialog.dart';
import 'package:template/utils/dialogs/unexpected_error_dialog.dart';

Future<void> handleCreateUserWithEmailAndPasswordFirebaseAuthException(e, s) {
  switch (e.code) {
    case 'weak-password':
      return getDialog(short: get.error, middle: get.weakPassword);
    case 'invalid-email':
      return getDialog(short: get.error, middle: get.invalidEmail);
    case 'email-already-in-use':
      return getDialog(short: get.error, middle: get.accountWithThisEmailAlreadyExists);
    default:
      Crashlytics.report(e, trace: s, reason: '_createUserWithEmailAndPassword');
      return unexpectedErrorDialog();
  }
}

Future<void> handleSignInWithEmailFirebaseAuthException(
  FirebaseAuthException e,
  StackTrace s,
  Future<void> Function() onUserNotFound,
) async {
  switch (e.code) {
    case 'invalid-email':
      return getDialog(short: get.error, middle: get.invalidEmail);
    case 'user-disabled':
      return getDialog(short: get.error, middle: get.accountDisabled);
    case 'wrong-password':
      return getDialog(short: get.error, middle: get.wrongPassword);

    case 'INVALID_LOGIN_CREDENTIALS':
    case 'invalid-credential':
      return getDialog(short: get.error, middle: get.invalidCredentials);
    case 'user-not-found':
      await onUserNotFound();

    default:
      Crashlytics.report(e, reason: 'safeEmailSignIn');
      return unexpectedErrorDialog();
  }
}

Future<void> handleSendPasswordResetEmailFirebaseAuthException(FirebaseAuthException e, StackTrace s) {
  switch (e.code) {
    case 'invalid-email':
      return getDialog(short: get.error, middle: get.invalidEmail);
    case 'user-not-found':
      return getDialog(short: get.error, middle: get.userNotFound);
    default:
      Crashlytics.report(e, trace: s, reason: 'resetPassword');
      return unexpectedErrorDialog();
  }
}

Future<void> handleDeleteAccountFirebaseAuthException(FirebaseAuthException e, StackTrace s) {
  switch (e.code) {
    case 'requires-recent-login':
      return getDialog(
        short: get.error,
        middle: get.thisOperationIsSensitiveAndRequiresRecentLogin,
      );
    default:
      Crashlytics.report(e, trace: s, reason: 'deleteUser');
      return unexpectedErrorDialog();
  }
}

Future<void> handleSignInWithCredential(FirebaseAuthException e, StackTrace s, String? lastEmail) async {
  String? message;
  switch (e.code) {
    case 'user-disabled':
      return getDialog(short: get.error, middle: get.accountDisabled);
    case 'account-exists-with-different-credential':
      message = get.accountWithThisEmailExistsWithADifferentProvider;

      if (lastEmail == null) break;
      final providers = await Authentication.auth.fetchSignInMethodsForEmail(lastEmail);
      final authProvider = providers.firstOrNull;
      if (authProvider == null) break;

      message = get.accountWithThisEmailIsAlreadyRegisteredWithADifferentProvider(authProvider);
      break;

    default:
      Crashlytics.report(e, trace: s, reason: 'thirdPartySignIn');
      break;
  }
  return getDialog(short: get.error, middle: message ?? get.anUnexpectedError);
}
