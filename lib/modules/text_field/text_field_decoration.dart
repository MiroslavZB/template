import 'package:flutter/material.dart';
import 'package:template/resources/border_radius.dart';
import 'package:template/resources/colors.dart';
import 'package:template/resources/text_style.dart';

InputDecoration textFieldDecoration({BorderRadius? borderRadius, Color? focusColor}) {
  return InputDecoration(
    errorStyle: textSH6.copyWith(color: t.error),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: focusColor ?? t.primary),
      borderRadius: borderRadius ?? mediumBorderRadius,
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: t.outline),
      borderRadius: borderRadius ?? mediumBorderRadius,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: t.primary, width: 2),
      borderRadius: borderRadius ?? mediumBorderRadius,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: t.error, width: 1.5),
      borderRadius: borderRadius ?? mediumBorderRadius,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: t.error, width: 2),
      borderRadius: borderRadius ?? mediumBorderRadius,
    ),
  );
}
