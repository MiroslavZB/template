import 'package:template/index.dart';

class PublicUser {
  final String id;
  final String? name;
  final String tag;
  final String? photoUrl;
  final int followers;

  PublicUser({
    String? uid,
    String? tag,
    this.name,
    this.photoUrl,
    this.followers = 0,
  })  : id = uid ?? _emptyId,
        tag = tag ?? _emptyTag;

  factory PublicUser.fromFirestore(Map<String, dynamic> doc) {
    final Map<String, dynamic>? json = doc['publicUser'];
    if (json == null) return PublicUser.empty();

    try {
      return PublicUser(
        uid: json['id'],
        tag: json['tag'],
        name: json['name'],
        photoUrl: json['photoUrl'],
        followers: int.tryParse(json['followers']?.toString() ?? '0') ?? 0,
      );
    } catch (e, s) {
      Crashlytics.report(e, trace: s, reason: 'PublicUser.fromFirestore - json: $json');
      return PublicUser.empty();
    }
  }

  PublicUser copyWith({
    String? uid,
    String? tag,
    String? name,
    String? photoUrl,
    int? followers,
  }) {
    return PublicUser(
      uid: uid ?? id,
      tag: tag ?? this.tag,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      followers: followers ?? this.followers,
    );
  }

  factory PublicUser.empty() => PublicUser(uid: _emptyId);

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'tag': tag,
        'name': name,
        'photoUrl': photoUrl,
        'followers': followers,
      };

  // Private
  static const String _emptyId = '0';
  static const String _emptyTag = '#000000';

  // Getters
  bool get isEmpty => id == _emptyId;
  bool get isNotEmpty => id != _emptyId;

  @override
  String toString() => toFirestore().toString();
}
