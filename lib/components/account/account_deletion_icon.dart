import 'package:template/controllers/user_controller.dart';
import 'package:template/functions/confirmation_dialog.dart';
import 'package:template/services/authentication.dart';
import 'package:template/services/database.dart';
import 'package:template/utils/custom_widgets/custom_widgets_index.dart';

Widget accountDeletionIcon() {
  return IconButton(
    onPressed: () => confirmationDialog(
      title: 'Confirmation',
      middle: 'Are you sure you want to delete your account?',
      onSuccess: () async {
        Authentication.auth.currentUser!.delete();
        Database.deleteUser(Get.put(UserController()).info.value.id);
      },
    ),
    icon: const Icon(
      Icons.remove_circle_outline,
      color: errorColor,
    ),
  );
}
