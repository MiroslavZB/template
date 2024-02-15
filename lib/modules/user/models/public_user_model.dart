import 'package:template/index.dart';

class PublicUser {
  final String id;
  final String? name;
  final String? photoUrl;

  PublicUser({
    String? uid,
    this.name,
    this.photoUrl,
  }) : id = uid ?? _emptyId;
  factory PublicUser.fromFirestore(Map<String, dynamic> json) {
    try {
      return PublicUser(
        uid: json['id'],
        name: json['name'],
        photoUrl: json['photoUrl'],
      );
    } catch (e, s) {
      Crashlytics.report(e, trace: s, reason: 'PublicUser.fromFirestore - json: $json');
      return PublicUser.empty();
    }
  }

  PublicUser copyWith({
    String? uid,
    String? name,
    String? photoUrl,
  }) {
    return PublicUser(
      uid: uid ?? id,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  factory PublicUser.empty() => PublicUser(uid: _emptyId);

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'name': name,
        'photoUrl': photoUrl,
      };

  static const String _emptyId = '0';

  // Getters
  bool get isEmpty => id == _emptyId;
  bool get isNotEmpty => id != _emptyId;

  @override
  String toString() => toFirestore().toString();
}
