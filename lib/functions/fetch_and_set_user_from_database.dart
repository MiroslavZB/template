import 'package:template/controllers/user_controller.dart';
import 'package:template/models/user_model.dart';
import 'package:template/services/database.dart';

Future<void> fetchAndSetUserFromDatabase(String uid) async {
  final dbUser = await Database.getUser(uid);
  final user = Get.put(UserController());

  if (dbUser == null || !dbUser.exists || dbUser.data() == null) {
    // User Doesn't exist
    user.setUser(UserModel(uid: uid));
    return await Database.putUser();
  }

  // User exists and data isn't null
  await user.setUserFromFirestore(dbUser.data()!);
}
