import 'package:template/models/user_model.dart';
import 'package:get/get.dart';

export 'package:get/get.dart';

class UserController extends GetxController {
  // Fields
  final Rx<UserModel> info = UserModel.empty().obs;

  // Setters
  Future<void> setUser(UserModel? newUserInfo) async => info.value = newUserInfo ?? UserModel.empty();

  Map<String, dynamic> toFirestore() => {
        'user': info.value.toFirestore(),
      };

  Future<void> setUserFromFirestore(Map<String, dynamic> data) async {
    setUser(data['user'] != null ? UserModel.fromFirestore(data['user']) : null);
  }
}
