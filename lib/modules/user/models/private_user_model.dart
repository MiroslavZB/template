import 'package:template/index.dart';
import 'package:template/modules/authentication/authentication.dart';
import 'package:template/modules/user/models/public_user_model.dart';
import 'package:template/services/database.dart';

class PrivateUser {
  final List<String> following;
  final PublicUser? specialFollowing;
  final String? email;
  final bool emailVerified;

  PrivateUser({
    this.following = const [],
    this.specialFollowing,
    this.emailVerified = false,
    this.email,
  });

  PrivateUser copyWith({
    List<String>? following,
    PublicUser? specialFollowing,
    String? email,
    bool? emailVerified,
  }) =>
      PrivateUser(
        following: following ?? this.following,
        specialFollowing: specialFollowing?.isEmpty == true ? null : specialFollowing ?? this.specialFollowing,
        email: email ?? this.email,
        emailVerified: emailVerified ?? this.emailVerified,
      );

  static Future<PrivateUser> fromFirestore(Map<String, dynamic> json) async {
    // special following
    PublicUser? specialFollowing;
    dynamic value = json['specialFollowing'];
    if (value is String) {
      final publicUserData = await Database.getPublicUser(value);

      if (publicUserData != null) specialFollowing = PublicUser.fromFirestore(publicUserData);
    }

    try {
      return PrivateUser(
        following: (json['following'] as List? ?? []).map((e) => e.toString()).toList(),
        specialFollowing: specialFollowing,
        emailVerified: json['emailVerified'] ?? Authentication.user?.emailVerified ?? false,
        email: json['email'] ?? Authentication.user?.email,
      );
    } catch (e, s) {
      Crashlytics.report(e, trace: s, reason: 'PrivateUser.fromFirestore - json: $json');
      return PrivateUser.empty();
    }
  }

  Map<String, dynamic> toFirestore() => {
        'following': following,
        'specialFollowing': specialFollowing?.id,
        'emailVerified': emailVerified,
        'email': email,
      };

  factory PrivateUser.empty() => PrivateUser();
}
