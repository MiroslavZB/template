import 'package:get/get.dart';

String? validateEmail(String? value) {
  if (value?.isNotEmpty != true) return null;
  if (!value!.isEmail) return 'Invalid email';
  return null;
}
