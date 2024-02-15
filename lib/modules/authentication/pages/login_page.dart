import 'dart:io';

import 'package:template/components/expanded_button.dart';
import 'package:template/functions/percent_screen.dart';
import 'package:template/index.dart';
import 'package:template/modules/authentication/authentication.dart';
import 'package:template/modules/authentication/pages/sign_in_with_email_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: pad(h: percentWidth(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ExpandedButton(
              onTap: () => Get.to(() => const SignInWithEmailPage(), transition: Transition.fadeIn),
              iconData: Icons.email,
              text: get.signInWithEmail,
              border: Border.all(width: 2, color: t.primary),
            ),
            ExpandedButton(
              onTap: () => Authentication.thirdPartySignIn(ThirdPartySignIn.google),
              color: Colors.white,
              onColor: Colors.black,
              iconData: Icons.g_mobiledata, // TODO: add your own google icon
              text: get.signInWithGoogle,
              border: Border.all(width: 2),
            ),
            if (Platform.isIOS)
              ExpandedButton(
                onTap: () => Authentication.thirdPartySignIn(ThirdPartySignIn.apple),
                color: Colors.black,
                onColor: Colors.white,
                iconData: Icons.apple,
                text: get.signInWithApple,
                border: Border.all(width: 2),
              ),
            InkWell(
              onTap: () => Authentication.auth.signInAnonymously(),
              child: Txts('Continue as Guest', u: true),
            ),
          ],
        ),
      ),
    );
  }
}
