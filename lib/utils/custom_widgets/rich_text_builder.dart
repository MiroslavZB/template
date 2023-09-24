import 'package:flutter/material.dart';

Widget richTextBuilder(
  List<RichTextModel> texts, {
  required TextStyle style,
  TextAlign? textAlign,
  int? maxLines,
}) {
  return Text.rich(
    style: style,
    maxLines: maxLines,
    textAlign: textAlign,
    overflow: TextOverflow.ellipsis,
    TextSpan(
      children: texts.map((e) => TextSpan(text: e.text, style: e.style)).toList(),
    ),
  );
}

class RichTextModel {
  final String text;
  final TextStyle? style;

  RichTextModel({required this.text, this.style});
}
