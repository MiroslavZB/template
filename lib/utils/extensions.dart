import 'package:template/index.dart';

extension Validate on GlobalKey<FormFieldState<dynamic>> {
  bool get valid => currentState?.validate() ?? false;
}

extension NotNullAndEmptyList on List? {
  bool get safeEmpty => this?.isEmpty == true;
}

extension NotNullAndNotEmptyList on List? {
  bool get safeNotEmpty => this?.isNotEmpty == true;
}

extension NotNullAndEmptyString on String? {
  bool get safeEmpty => this?.isEmpty == true;
}

extension NotNullAndNotEmptyString on String? {
  bool get safeNotEmpty => this?.isNotEmpty == true;
}

extension Flip on RxBool {
  void flip() => value = !value;
}
