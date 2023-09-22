
import 'package:template/controllers/user_controller.dart';
import 'package:template/utils/custom_widgets/custom_widgets_index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static final firestore = FirebaseFirestore.instance;

  // Streams
  static final Stream<QuerySnapshot> _usersStream = firestore.collection(usersCollection).snapshots();

  static Stream<QuerySnapshot<Object?>> get usersStream => _usersStream;

  // User
  static DocumentReference<Map<String, dynamic>> _getUserRef(String id) =>
      firestore.collection(usersCollection).doc(id);

  static Future<DocumentSnapshot<Map<String, dynamic>>?> getUser(String id) async {
    try {
      return await _getUserRef(id).get();
    } catch (_) {
      return null;
    }
  }

  static Future<void> putUser() async {
    try {
      final UserController user = Get.put(UserController());
      await _getUserRef(user.info.value.id).set(user.toFirestore());
    } catch (_) {
      rethrow;
    }
  }

  static Future<void> deleteUser(String id) async => await _getUserRef(id).delete();
}
