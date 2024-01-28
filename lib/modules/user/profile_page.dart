import 'package:flutter/material.dart';
import 'package:template/modules/user/components/delete_account_button.dart';
import 'package:template/modules/user/components/sign_out_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          SignOutButton(),
          DeleteAccountButton(),
        ],
      ),
    );
  }
}
