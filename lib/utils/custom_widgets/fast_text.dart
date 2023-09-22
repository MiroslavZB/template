import 'package:template/resources/colors.dart';
import 'package:template/resources/constants.dart';
import 'package:flutter/material.dart';

export 'package:template/resources/constants.dart';

Widget txts(
  String text, {
  double s = sh4,
  Color col = onBackgroundColor,
  FontWeight fw = FontWeight.normal,
  bool cent = true,
  bool u = false,
  bool b = false,
  bool i = false,
  TextOverflow ovf = TextOverflow.visible,
  List<Shadow> shadows = const [],
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    text,
    maxLines: maxLines,
    style: TextStyle(
      fontSize: s,
      color: col,
      fontWeight: b ? FontWeight.bold : fw,
      fontStyle: i ? FontStyle.italic : FontStyle.normal,
      decoration: u ? TextDecoration.underline : TextDecoration.none,
      overflow: overflow,
      shadows: shadows,
    ),
    textAlign: cent ? TextAlign.center : TextAlign.start,
    overflow: ovf,
  );
}
