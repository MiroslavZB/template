import 'package:template/utils/custom_widgets/custom_widgets_index.dart';

Future<void> confirmationDialog({
  required Future<void> Function() onSuccess,
  String title = '',
  String middle = '',
}) async =>
    await getDialog(
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
                  child: txts('Cancel', col: accentColor),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => onSuccess().whenComplete(() => Get.back()),
                  child: txts('Confirm', col: accentColor),
                ),
              )
            ],
          ),
        ),
      ],
    );
