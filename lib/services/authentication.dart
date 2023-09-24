import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus {
  success,
}

class Authentication {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static Stream<User?> get onAuthStateChanged => _auth.authStateChanges();

  static FirebaseAuth get auth => _auth;
  static AuthStatus? status;
}
