import 'package:template/index.dart';
import 'package:template/modules/authentication/authentication.dart';

class PrivateUser {
  final String? email;
  final bool emailVerified;

  PrivateUser({
    this.emailVerified = false,
    this.email,
  });

  PrivateUser copyWith({
    String? email,
    bool? emailVerified,
  }) =>
      PrivateUser(
        email: email ?? this.email,
        emailVerified: emailVerified ?? this.emailVerified,
      );

  static Future<PrivateUser> fromFirestore(Map<String, dynamic> json) async {
    try {
      return PrivateUser(
        emailVerified: json['emailVerified'] ?? Authentication.user?.emailVerified ?? false,
        email: json['email'] ?? Authentication.user?.email,
      );
    } catch (e, s) {
      Crashlytics.report(e, trace: s, reason: 'PrivateUser.fromFirestore - json: $json');
      return PrivateUser.empty();
    }
  }

  Map<String, dynamic> toFirestore() => {
        'emailVerified': emailVerified,
        'email': email,
      };

  factory PrivateUser.empty() => PrivateUser();
}
