import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus {
  success,
  invalidPhone,
  timeOut,
}

class Authentication {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static Stream<User?> get onAuthStateChanged => _auth.authStateChanges();

  static FirebaseAuth get auth => _auth;
  static AuthStatus? status;

  String? verificationId;

  static authWithPhone({String? phone, String? sms}) async {
    return _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          status = AuthStatus.invalidPhone;
          return;
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        if (sms != null) {
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: sms,
          );
          // Sign the user in (or link) with the credential
          await _auth.signInWithCredential(credential);
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        status = AuthStatus.timeOut;
      },
    );
  }
}
