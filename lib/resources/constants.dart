import 'package:template/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:worldtime/worldtime.dart';

const String appName = 'Template';

// Border Radius
const double smallRadius = 8;
const double mediumRadius = 20;
const double bigRadius = 25;
const double extraBigRadius = 50;
const double circularRadius = 1000;

final BorderRadius smallBorderRadius = BorderRadius.circular(smallRadius);
final BorderRadius mediumBorderRadius = BorderRadius.circular(mediumRadius);
final BorderRadius bigBorderRadius = BorderRadius.circular(bigRadius);
final BorderRadius extraBigBorderRadius = BorderRadius.circular(extraBigRadius);
final BorderRadius circularBorderRadius = BorderRadius.circular(circularRadius);

// Icon size
const double regularIconSize = 25;
const double bigIconSize = 30;
const double extraBigIconSize = 40;

// Font size
const double sh1 = 26.0;
const double sh2 = 24.0;
const double sh3 = 22.0;
const double sh4 = 18.0;
const double sh5 = 16.0;
const double sh6 = 14.0;
const double sh7 = 12.0;
const double sh8 = 9.0;

// Font style
const TextStyle textSH1 = TextStyle(fontSize: sh1);
const TextStyle textSH2 = TextStyle(fontSize: sh2);
const TextStyle textSH3 = TextStyle(fontSize: sh3);
const TextStyle textSH4 = TextStyle(fontSize: sh4);
const TextStyle textSH5 = TextStyle(fontSize: sh5);
const TextStyle textSH6 = TextStyle(fontSize: sh6);

// Database
const String usersCollection = 'users';

// Time
// TODO
final defaultDateTime = DateTime(2022, 1, 1, 1, 0);

const String defaultTZ = 'Europe/Sofia';

final Worldtime worldTime = Worldtime();

const String dbFormatter = '\\D\\M\\Y\\h\\m\\s';

const String prettyFormatter = '\\h:\\m \\D/\\M/\\Y';

// TextField
List<String> numberFields = [];

List<String> multiLineFields = [];

InputDecoration fieldDecoration({
  String? hint,
  Widget? suffixIcon,
  EdgeInsets? contentPadding,
  required Color focusColor,
  required BorderRadius borderRadius,
}) {
  return InputDecoration(
    hintText: hint,
    counterText: '',
    suffixIcon: suffixIcon,
    contentPadding: contentPadding,
    errorStyle: textSH4.copyWith(color: errorColor),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: focusColor),
      borderRadius: borderRadius,
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: disabledColor),
      borderRadius: borderRadius,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: focusColor, width: 2),
      borderRadius: borderRadius,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: errorColor, width: 1.5),
      borderRadius: borderRadius,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: errorColor, width: 2),
      borderRadius: borderRadius,
    ),
  );
}
