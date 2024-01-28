import 'dart:math';

import 'package:template/index.dart';
import 'package:template/modules/authentication/authentication.dart';
import 'package:template/modules/user/models/private_user_model.dart';
import 'package:template/modules/user/models/public_user_model.dart';
import 'package:template/modules/user/user_controller.dart';
import 'package:template/services/database.dart';

bool finished = false;
Future<void> initUser() async {
  if (!finished) {
    finished = true;
    try {
      await _fetchAndSetUserFromDatabase();
    } catch (e, s) {
      Crashlytics.report(e, trace: s, reason: 'initUser _fetchAndSetUserFromDatabase error');
      rethrow;
    }
  }
}

Future<void> _fetchAndSetUserFromDatabase() async {
  final uid = Authentication.user!.uid;

  final user = Get.put(UserController());

  await Future.delayed(const Duration(milliseconds: 10));
  user.clear(uid);

  final privateUserData = await Database.getPrivateUser(uid);
  final publicUserData = await Database.getPublicUser(uid);

  if (privateUserData == null || publicUserData == null) {
    // User Doesn't exist

    // Setup Public User
    final PublicUser publicUser = PublicUser(uid: uid, name: Authentication.user!.displayName);
    user.setPublicUser(publicUser);
    await Database.putPublicUser(publicUser);

    // Setup Private User
    final PrivateUser privateUser = PrivateUser(
      email: Authentication.user!.email,
      emailVerified: Authentication.user!.emailVerified,
    );
    user.setPrivateUser(privateUser);
    await Database.putPrivateUser(uid, privateUser);

    return;
  }

  // User exists and data isn't null
  await user.setUserFromFirestore(publicUserData: publicUserData, privateUserData: privateUserData);
}

String generateRandomString() {
  final Random random = Random();
  final StringBuffer buffer = StringBuffer();

  for (int i = 0; i < 6; i++) {
    final bool isNumber = random.nextBool();

    if (isNumber) {
      // Generate a random number (0-9)
      buffer.write(random.nextInt(10));
    } else {
      // Generate a random uppercase letter (A-Z)
      final int asciiOffset = 'A'.codeUnitAt(0);
      final int randomLetter = asciiOffset + random.nextInt(26);
      buffer.write(String.fromCharCode(randomLetter));
    }
  }

  return '#$buffer';
}
