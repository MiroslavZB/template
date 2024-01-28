import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:template/firebase_options.dart';
import 'package:template/index.dart';
import 'package:template/modules/authentication/authentication.dart';
import 'package:template/modules/routing/root.dart';

Future<void> main() async {
  GoogleFonts.config.allowRuntimeFetching = false;

  // Firebase Init
  WidgetsFlutterBinding.ensureInitialized();
  // TODO
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Authentication start
  Authentication.onAuthStateChanged.listen((user) {
    if (user != null) unawaited(Crashlytics.setUserId(user.uid));
  });
  // Authentication end

  // Crashlytics Start
  FlutterError.onError = Crashlytics.recordFlutterError;
  PlatformDispatcher.instance.onError = Crashlytics.recordPlatformError;
  if (Authentication.user != null) unawaited(Crashlytics.setUserId(Authentication.user!.uid));
  // Crashlytics End

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        //  textTheme: GoogleFonts.nunitoTextTheme(ThemeData.light().textTheme), // TODO
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        //  textTheme: GoogleFonts.nunitoTextTheme(ThemeData.dark().textTheme), // TODO
      ),
      home: const Root(),
    );
  }
}
