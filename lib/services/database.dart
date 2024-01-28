import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:template/modules/user/models/private_user_model.dart';
import 'package:template/modules/user/models/public_user_model.dart';

const String publicUsersCollection = 'publicUsers';
const String privateUsersCollection = 'privateUsers';

class Database {
  static final firestore = FirebaseFirestore.instance;

  // User
  static DocumentReference<Map<String, dynamic>> _getPublicUserRef(String id) =>
      firestore.collection(publicUsersCollection).doc(id);

  static DocumentReference<Map<String, dynamic>> _getPrivateUserRef(String id) =>
      firestore.collection(privateUsersCollection).doc(id);

  static Future<Map<String, dynamic>?> getPublicUser(String id) async {
    try {
      return (await _getPublicUserRef(id).get()).data();
    } catch (_) {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getPrivateUser(String id) async {
    try {
      return (await _getPrivateUserRef(id).get()).data();
    } catch (_) {
      return null;
    }
  }

  static Future<void> putPublicUser(PublicUser user) async {
    try {
      await _getPublicUserRef(user.id).set(user.toFirestore());
    } catch (_) {
      rethrow;
    }
  }

  static Future<void> putPrivateUser(String id, PrivateUser user) async {
    try {
      await _getPrivateUserRef(id).set(user.toFirestore());
    } catch (_) {
      rethrow;
    }
  }

  static Future<void> deleteAllUser(String id) async {
    await _getPublicUserRef(id).delete();
    await _getPrivateUserRef(id).delete();
  }
}
