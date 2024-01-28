import 'package:template/components/back_app_bar.dart';
import 'package:template/components/expanded_button.dart';
import 'package:template/index.dart';
import 'package:template/modules/authentication/authentication.dart';
import 'package:template/modules/text_field/text_field_decoration.dart';
import 'package:template/modules/text_field/text_form_field_card.dart';
import 'package:template/modules/text_field/unfocus_wrap.dart';
import 'package:template/modules/text_field/validators.dart';
import 'package:template/utils/dialogs/get_dialog.dart';
import 'package:template/utils/extensions.dart';

class SignInWithEmailPage extends StatefulWidget {
  const SignInWithEmailPage({super.key});

  @override
  State<SignInWithEmailPage> createState() => _SignInWithEmailPageState();
}

class _SignInWithEmailPageState extends State<SignInWithEmailPage> {
  late final GlobalKey<FormFieldState> formKey;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormFieldState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  final passwordIsObscure = true.obs;
  final buttonIsEnabled = false.obs;

  void onChanged(_) => buttonIsEnabled.value = formKey.valid && !formHasEmpty;

  bool get formHasEmpty => [emailController, passwordController].any((e) => e.text.isEmpty);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(get.signInWithEmail),
      body: UnfocusWrap(
        child: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormFieldCard(
                  state: formKey,
                  controller: emailController,
                  field: TextFormField(
                    controller: emailController,
                    onChanged: (_) => formKey.valid,
                    validator: validateEmail,
                    decoration: textFieldDecoration().copyWith(hintText: get.email),
                  ),
                ),
                Obx(
                  () => TextFormFieldCard(
                    state: formKey,
                    controller: passwordController,
                    field: TextFormField(
                      controller: passwordController,
                      onChanged: (_) => formKey.valid,
                      validator: validatePassword,
                      obscureText: passwordIsObscure.value,
                      decoration: textFieldDecoration().copyWith(hintText: get.password),
                    ),
                  ),
                ),
                ExpandedButton(
                  onTap: () async {
                    if (!formKey.valid) return;
                    if (formHasEmpty) {
                      getDialog(short: 'Error', middle: 'All fields are required!');
                      return;
                    }
                    Authentication.safeEmailSignIn(emailController.text, passwordController.text);
                  },
                  text: get.continueString,
                  color: buttonIsEnabled.value ? t.primary : t.primary.withOpacity(0.5),
                  onColor: buttonIsEnabled.value ? t.onPrimary : t.onPrimary.withOpacity(0.7),
                ),
                InkWell(
                  onTap: () async {
                    final String email = emailController.text;
                    if (email.isNotEmpty && email.isEmail) {
                      await Authentication.resetPassword(email);
                      return;
                    }
                    await getDialog(short: get.error, middle: get.invalidEmail);
                  },
                  child: Txts(get.forgotPassword, s: sh5, u: true),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
