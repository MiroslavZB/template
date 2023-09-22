import 'package:flutter/material.dart';

Widget snapshotInfo({List<Widget>? children, Widget? child}) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children ?? [if (child != null) child],
      ),
    );
