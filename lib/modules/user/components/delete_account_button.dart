import 'package:template/index.dart';
import 'package:template/modules/user/user_controller.dart';
import 'package:template/utils/dialogs/confirmation_dialog.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => confirmationDialog(
        title: 'Confirmation',
        middle: 'Are you sure you want to delete your account?',
        onSuccess: Get.put(UserController()).deleteUser,
      ),
      icon: Icon(
        Icons.remove_circle_outline,
        color: t.error,
      ),
    );
  }
}
