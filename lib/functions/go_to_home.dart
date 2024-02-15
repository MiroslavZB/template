import 'package:get/get.dart';

void goToHome() => Get.until((route) => Get.currentRoute == '/');
