import 'package:template/index.dart';
import 'package:template/utils/dialogs/get_dialog.dart';

Future<void> confirmationDialog({
  required Future<void> Function() onSuccess,
  String title = '',
  String middle = '',
}) =>
    getDialog(
      short: title,
      middle: middle,
      actions: [
        SizedBox(
          width: Get.width - 100,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  child: Txts('Cancel', col: t.primary),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => onSuccess().whenComplete(() => Get.back()),
                  child: Txts('Confirm', col: t.primary),
                ),
              )
            ],
          ),
        ),
      ],
    );
