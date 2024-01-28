import 'package:flutter/material.dart';
import 'package:template/resources/colors.dart';
import 'package:template/resources/text_style.dart';

class Txts extends StatelessWidget {
  final String text;
  final int? maxLines;
  final double s;
  final Color col;
  final FontWeight fw;
  final bool cent;
  final bool u;
  final bool b;
  final bool i;
  final TextOverflow? ovf;
  final List<Shadow> shadows;
  final Color? decorationColor;

  Txts(
    this.text, {
    super.key,
    this.maxLines,
    this.s = sh4,
    Color? col,
    this.fw = FontWeight.normal,
    this.cent = true,
    this.u = false,
    this.b = false,
    this.i = false,
    this.ovf = TextOverflow.ellipsis,
    this.shadows = const [],
    this.decorationColor,
  }) : col = col ?? t.onBackground;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: s,
        color: col,
        fontWeight: b ? FontWeight.bold : fw,
        fontStyle: i ? FontStyle.italic : FontStyle.normal,
        decoration: u ? TextDecoration.underline : TextDecoration.none,
        decorationColor: decorationColor,
        overflow: ovf,
        shadows: shadows,
      ),
      textAlign: cent ? TextAlign.center : TextAlign.start,
      overflow: ovf,
    );
  }
}
