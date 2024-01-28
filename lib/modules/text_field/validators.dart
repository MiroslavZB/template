import 'package:get/get.dart';
import 'package:template/utils/extensions.dart';

String? validateEmail(String? value) {
  if (!value.safeNotEmpty) return null;
  if (!value!.isEmail) return 'Invalid email';
  return null;
}

String? validatePassword(String? value) {
  if (!value.safeNotEmpty) return null;
  if (value!.length < 8) return 'Password is too short.';
  if (value.length > 22) return 'Password is too long';
  if (!value.contains(RegExp(r'[A-Za-z]'))) return 'Password must contain a letter.';
  if (!value.contains(RegExp(r'\d'))) return 'Password must contain a number.';

  return null;
}
