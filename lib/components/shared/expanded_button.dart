import 'package:template/utils/custom_widgets/custom_widgets_index.dart';

Widget expandedButton({
  required void Function() onTap,
  Color? color,
  Color? onColor,
  IconData? iconData,
  String? text,
}) {
  return TextButton(
    onPressed: onTap,
    child: Container(
      padding: pad(v: 10),
      decoration: BoxDecoration(
        color: color ?? accentColor,
        borderRadius: bigBorderRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconData != null) Icon(iconData, color: onColor ?? onAcceptColor, size: 30),
          if (iconData != null && text != null) const SizedBox(width: 10),
          if (text != null) txts(text, s: sh3, col: onColor ?? onAcceptColor, b: true),
        ],
      ),
    ),
  );
}
