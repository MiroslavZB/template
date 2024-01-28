import 'package:flutter/material.dart';

EdgeInsets pad({
  double tp = 0,
  double bp = 0,
  double lp = 0,
  double rp = 0,
  double? all,
  double? h,
  double? v,
}) {
  return all != null
      ? EdgeInsets.all(all)
      : EdgeInsets.only(left: h ?? lp, right: h ?? rp, bottom: v ?? bp, top: v ?? tp);
}
