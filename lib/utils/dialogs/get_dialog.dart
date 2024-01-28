import 'package:template/index.dart';

Future<void> getDialog({
  required String short,
  required String middle,
  List<Widget> actions = const [],
  bool disableAll = false,
}) =>
    Get.defaultDialog(
      title: short,
      middleText: middle,
      barrierDismissible: !disableAll,
      backgroundColor: t.background,
      onWillPop: disableAll ? () => Future.value(false) : null,
      titleStyle: TextStyle(color: t.onBackground, fontSize: sh1),
      titlePadding: pad(h: 20, tp: 10),
      middleTextStyle: TextStyle(
        color: t.onBackground,
        fontSize: sh5,
        fontWeight: FontWeight.w500,
      ),
      actions: actions,
    );
