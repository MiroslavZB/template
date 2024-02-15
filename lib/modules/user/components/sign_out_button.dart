import 'dart:math';

import 'package:template/index.dart';
import 'package:template/modules/user/user_controller.dart';
import 'package:template/utils/dialogs/confirmation_dialog.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(pi),
      child: IconButton(
        onPressed: () => confirmationDialog(
          title: get.confirmation,
          middle: get.areYouSureYouWantToLogOut,
          onSuccess: Get.put(UserController()).signOut,
        ),
        icon: const Icon(Icons.logout_outlined),
      ),
    );
  }
}
