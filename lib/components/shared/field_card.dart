import 'package:template/utils/custom_widgets/custom_widgets_index.dart';

Widget fieldCard({
  required Map<String, TextEditingController> fields,
  required String hint,
  String? initialValue,
  String? id,
  bool readOnly = false,
  void Function(String? value)? onChanged,
  String? Function(String? value)? validator,
  Color? focusColor,
  BorderRadius? borderRadius,
  EdgeInsets? contentPadding,
}) {
  id ??= hint;
  fields[id] ??= TextEditingController(text: initialValue);
  return Container(
    padding: pad(h: 10, v: 5),
    child: TextFormField(
      controller: fields[id]!,
      readOnly: readOnly,
      maxLines: multiLineFields.contains(id) ? null : 1,
      keyboardType: numberFields.contains(id)
          ? TextInputType.number
          : hint == 'Phone'
              ? TextInputType.phone
              : hint == 'Email'
                  ? TextInputType.emailAddress
                  : null,
      decoration: fieldDecoration(
        hint: hint,
        contentPadding: contentPadding,
        focusColor: focusColor ?? accentColor,
        borderRadius: borderRadius ?? mediumBorderRadius,
      ),
      onChanged: onChanged,
      validator: validator,
    ),
  );
}
