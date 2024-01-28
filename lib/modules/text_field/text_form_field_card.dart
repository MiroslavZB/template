import 'package:template/index.dart';
import 'package:template/utils/extensions.dart';

class TextFormFieldCard extends StatelessWidget {
  final TextEditingController controller;
  final GlobalKey<FormFieldState>? state;
  final TextFormField field;
  final EdgeInsets? margin;

  TextFormFieldCard({
    super.key,
    required this.field,
    required this.controller,
    this.state,
    EdgeInsets? margin,
  }) : margin = pad(bp: 20, h: 10);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: pad(h: 10, v: 5),
      child: Focus(
        onFocusChange: (bool hasFocus) {
          if (!hasFocus && controller.text.isNotEmpty) state?.valid;
        },
        child: field,
      ),
    );
  }
}
