import 'package:template/index.dart';

class ExpandedButton extends StatelessWidget {
  final void Function()? onTap;
  final bool iconTrail;
  final String? text;
  final TextStyle? textStyle;
  final Color color;
  final Color onColor;
  final Widget? trailingWidget;
  final Widget? leadingWidget;
  final IconData? iconData;
  final Border? border;
  final Gradient? gradient;
  final MainAxisAlignment? mainAxisAlignment;

  /// Primary button or else
  /// [trailingWidget] will be visible ONLY when [mainAxisAlignment] is MainAxisAlignment.start
  ExpandedButton({
    super.key,
    required this.onTap,
    this.iconTrail = false,
    this.text,
    this.textStyle,
    Color? color,
    Color? onColor,
    this.trailingWidget,
    this.leadingWidget,
    this.iconData,
    this.border,
    this.gradient,
    this.mainAxisAlignment,
  })  : color = color ?? t.primary,
        onColor = onColor ?? t.onPrimary;

  ExpandedButton.secondary({
    super.key,
    required this.onTap,
    this.iconTrail = false,
    this.text,
    this.textStyle,
    this.trailingWidget,
    this.leadingWidget,
    this.iconData,
    this.border,
    this.gradient,
    this.mainAxisAlignment,
  })  : color = t.secondary,
        onColor = t.onSecondary;

  ExpandedButton.secondaryHighlighted({
    super.key,
    required this.onTap,
    this.iconTrail = false,
    this.text,
    this.trailingWidget,
    this.leadingWidget,
    this.iconData,
    this.border,
    this.gradient,
    this.mainAxisAlignment,
  })  : color = t.secondary,
        onColor = t.primary,
        textStyle = textSH5.copyWith(color: t.onSecondary);

  @override
  Widget build(BuildContext context) {
    final List<Widget> content = [
      leadingWidget != null
          ? SizedBox(height: largeIconSize, width: largeIconSize, child: leadingWidget)
          : iconData != null
              ? Icon(iconData, color: onColor, size: largeIconSize)
              : const SizedBox.shrink(),
      if ((iconData != null || leadingWidget != null) && text != null) const SizedBox(width: 10),
      if (text != null)
        Text(
          text!,
          style: textStyle ?? textSH5.copyWith(color: onColor),
        ),
      if (trailingWidget != null && mainAxisAlignment == MainAxisAlignment.start) ...[
        Expanded(child: Container()),
        SizedBox(height: largeIconSize, width: largeIconSize, child: trailingWidget!),
        const SizedBox(width: 10),
      ],
    ];

    return TextButton(
      onPressed: onTap,
      child: Container(
        padding: pad(h: 15, v: 10),
        decoration: BoxDecoration(
          color: color,
          gradient: gradient,
          borderRadius: circularBorderRadius,
          border: border,
        ),
        child: Row(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
          children: iconTrail ? content.reversed.toList() : content,
        ),
      ),
    );
  }
}
