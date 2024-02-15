import 'package:get/get.dart';

double percentWidth(int x) {
  if (x <= 0) return 0;
  final double width = Get.width;
  if (x > 100) return width;
  return x * width * 0.01;
}

double percentHeight(int x) {
  if (x <= 0) return 0;
  final double height = Get.height;
  if (x > 100) return height;
  return x * height * 0.01;
}
