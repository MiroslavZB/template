import 'package:flutter/material.dart';
import 'package:template/functions/unfocus.dart';

class UnfocusWrap extends StatelessWidget {
  final Widget child;

  const UnfocusWrap({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      focusColor: Colors.transparent,
      onTap: unfocus,
      child: child,
    );
  }
}
