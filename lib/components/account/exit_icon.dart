import 'dart:math';

import 'package:template/functions/confirmation_dialog.dart';
import 'package:template/services/authentication.dart';
import 'package:template/utils/custom_widgets/custom_widgets_index.dart';

Widget exitIcon() {
  return Transform(
    alignment: Alignment.center,
    transform: Matrix4.rotationY(pi),
    child: IconButton(
      onPressed: () => confirmationDialog(
        title: 'Confirmation',
        middle: 'Are you sure you want to log out?',
        onSuccess: () => Authentication.auth.signOut(),
      ),
      icon: const Icon(Icons.logout_outlined),
    ),
  );
}
