import 'package:uuid/uuid.dart';

class UserModel {
  final String id;
  final bool isAdmin;

  UserModel({
    String? uid,
    this.isAdmin = false,
  }) : id = uid ?? const Uuid().v4();

  factory UserModel.fromFirestore(Map<String, dynamic> doc) {
    try {
      return UserModel(
        uid: doc['id'],
        isAdmin: doc['isAdmin'] == true,
      );
    } catch (_) {
      return UserModel.empty();
    }
  }

  factory UserModel.empty() => UserModel(uid: _emptyId);

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'isAdmin': isAdmin,
      };

  // Private
  static const String _emptyId = '0';

  // Getters
  bool get isEmpty => id == _emptyId;
  bool get isNotEmpty => id != _emptyId;

  @override
  String toString() => toFirestore().toString();
}
