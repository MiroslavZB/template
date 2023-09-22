import 'package:template/utils/custom_widgets/custom_widgets_index.dart';

PreferredSizeWidget backAppBar(String text) {
  return AppBar(
    backgroundColor: accentColor,
    leading: IconButton(
      onPressed: () => Get.back(),
      icon: const Icon(Icons.arrow_back_ios_new, color: onAccentColor),
    ),
    title: txts(text, s: sh2, col: onAccentColor, b: true),
    centerTitle: true,
  );
}
