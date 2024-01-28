import 'package:template/index.dart';
import 'package:template/modules/authentication/authentication.dart';
import 'package:template/modules/user/models/private_user_model.dart';
import 'package:template/modules/user/models/public_user_model.dart';
import 'package:template/services/database.dart';

export 'package:get/get.dart';

class UserController extends GetxController {
  // Fields
  final Rx<PublicUser> _publicUser = PublicUser(uid: Authentication.user?.uid).obs;
  final Rx<PrivateUser> _privateUser = PrivateUser.empty().obs;

  // Getters
  // Private User
  bool get emailVerified => _privateUser.value.emailVerified;
  String? get email => _privateUser.value.email;

  // PublicUser
  String? get name => _publicUser.value.name;
  String? get photoUrl => _publicUser.value.photoUrl;

  // Private
  String get _id => _publicUser.value.id;

  // Setters
  void clear([String? uid]) {
    setPublicUser(uid == null ? null : PublicUser(uid: uid));
    setPrivateUser();
  }

  // Private User
  void setPrivateUser([PrivateUser? newUserInfo]) => _privateUser.value = newUserInfo ?? PrivateUser();

  // Public User
  void setPublicUser(PublicUser? newUserInfo) => _publicUser.value = newUserInfo ?? PublicUser.empty();

  Future<void> updateName(String? name) async {
    setPublicUser(_publicUser.value.copyWith(name: name ?? ''));
    await Authentication.updateName(name);
    await Database.putPublicUser(_publicUser.value);
  }

  void setPhoto(String? photoUrl) => setPublicUser(_publicUser.value.copyWith(photoUrl: photoUrl ?? ''));

  // Database
  Future<void> updatePrivateUser() async => Database.putPrivateUser(_id, _privateUser.value);

  Future<void> setUserFromFirestore({
    required Map<String, dynamic> publicUserData,
    required Map<String, dynamic> privateUserData,
  }) async {
    setPublicUser(PublicUser.fromFirestore(publicUserData));

    setPrivateUser(await PrivateUser.fromFirestore(privateUserData));
  }

  // Authentication
  Future<void> signOut() async {
    await Authentication.auth.signOut();
    clear();
  }

  Future<void> deleteUser() async {
    await Database.deleteAllUser(Authentication.user!.uid);

    await Authentication.auth.currentUser!.delete();

    await Authentication.auth.signOut();

    Get.back();
  }
}
