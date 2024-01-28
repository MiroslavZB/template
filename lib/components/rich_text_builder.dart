import 'package:flutter/gestures.dart';
import 'package:template/index.dart';

class RichTextBuilder extends StatelessWidget {
  final List<RichTextModel> texts;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;

  const RichTextBuilder({
    super.key,
    required this.texts,
    this.style,
    this.textAlign,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      TextSpan(
        children: texts
            .map((e) => TextSpan(
                  text: e.text,
                  style: style?.merge(e.style) ?? e.style,
                  recognizer: TapGestureRecognizer()..onTap = e.onTap,
                ))
            .toList(),
      ),
    );
  }
}

class RichTextModel {
  final String text;
  final TextStyle? style;
  final void Function()? onTap;

  RichTextModel({required this.text, this.style, this.onTap});
}
