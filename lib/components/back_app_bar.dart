import 'package:template/index.dart';

PreferredSizeWidget backAppBar(String text) {
  return AppBar(
    backgroundColor: t.primary,
    leading: IconButton(
      onPressed: () => Get.back(),
      icon: Icon(Icons.arrow_back_ios_new, color: t.onPrimary),
    ),
    title: Txts(text, s: sh2, col: t.onPrimary, b: true),
    centerTitle: true,
  );
}
