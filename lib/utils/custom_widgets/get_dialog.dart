import 'package:template/utils/custom_widgets/custom_widgets_index.dart';

Future getDialog({
  required String short,
  required String middle,
  List<Widget> actions = const [],
  bool disableAll = false,
}) {
  return Get.defaultDialog(
    title: short,
    middleText: middle,
    barrierDismissible: !disableAll,
    backgroundColor: backgroundColor,
    onWillPop: disableAll ? () => Future.value(false) : null,
    titleStyle: const TextStyle(color: onBackgroundColor, fontSize: sh1),
    titlePadding: pad(lp: 20, rp: 20, tp: 10),
    middleTextStyle: const TextStyle(
      color: onBackgroundColor,
      fontSize: sh5,
      fontWeight: FontWeight.w500,
    ),
    actions: actions,
  );
}
