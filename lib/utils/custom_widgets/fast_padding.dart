import 'package:flutter/material.dart';

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
