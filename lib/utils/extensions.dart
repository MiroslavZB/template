import 'package:template/utils/custom_widgets/custom_widgets_index.dart';

extension Validate on GlobalKey<FormState> {
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
