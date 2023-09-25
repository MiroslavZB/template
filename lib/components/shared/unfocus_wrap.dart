import 'package:flutter/material.dart';
import 'package:template/utils/unfocus.dart';

Widget unfocusWrap({required Widget child}){
  return InkWell(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: unfocus,
    child: child,
  );
}
