import 'package:flutter/material.dart';
import 'package:get/get.dart';

EdgeInsets pad({
  double tp = 0,
  double bp = 0,
  double lp = 0,
  double rp = 0,
  double? all,
  double h = 0,
  double v = 0,
}) {
  return all != null
      ? EdgeInsets.all(all)
      : h != 0 || v != 0
          ? EdgeInsets.symmetric(horizontal: h, vertical: v)
          : EdgeInsets.only(left: lp, right: rp, bottom: bp, top: tp);
}

double percentWidth(int x) {
  if (x < 0) return 0;
  final double width = Get.width;
  if (x > 100) return width;
  return x * width * 0.01;
}

double percentHeight(int x) {
  if (x < 0) return 0;
  final double height = Get.height;
  if (x > 100) return height;
  return x * height * 0.01;
}
