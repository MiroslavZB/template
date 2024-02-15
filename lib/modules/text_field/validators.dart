import 'package:get/get.dart';
import 'package:template/l10n/localizations.dart';
import 'package:template/utils/extensions.dart';

String? validateEmail(String? value) {
  if (!value.safeNotEmpty) return null;
  if (!value!.isEmail) return get.invalidEmail;
  return null;
}

String? validatePassword(String? value) {
  if (!value.safeNotEmpty) return null;
  if (value!.length < 8) return get.passwordIsTooShort;
  if (value.length > 22) return get.passwordIsTooLong;
  if (!value.contains(RegExp(r'[A-Za-z]'))) return get.passwordMustContainALetter;
  if (!value.contains(RegExp(r'\d'))) return get.passwordMustContainANumber;

  return null;
}
