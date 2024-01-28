# template

A template for a Flutter project.

## Introduction

This project is a template for a Flutter application.

## Getting Started
1. Create a new flutter app.
2. Fetch the files from this template:
   2.1 **Android** - key.properties.example and take a look at app/build.gradle), 
   2.2 lib
   2.3 test, 
   2.4 pubspec
   2.5 analysis_options
3. Setup a Firebase project:
   3.1 - Create a project in firebase
   3.2 - run `firebase login` to authenticate your terminal
   3.3 - run `flutterfire configure --project=<name-of-your-project>`
4. Search for `// TODO` and make changes where needed.
5. Change the bundle id for ALL environments (Android, iOS, etc)
6. Run `flutter create .` in the terminal
7. Replace all instances of package imports (`package:template`) from the template app with your
   app name.
8. Setup a Firebase project.
9. Initialize Firebase.

## Authentication
# Apple (for iOS only devices) 
   1. Follow the guide on https://firebase.google.com/docs/auth/ios/apple?hl=en&authuser=0
   2. Add Apple Sign in capability in XCode
# Google
   1. **For Android** - Follow the signing steps below to generate debug and release SHA1 and 
      SHA256 and add it to your firebase project 
   2. **For Apple** - Add the following to your project/ios/info.plist file:
```plist
<key>GIDClientID</key>
<!-- TODO: replace with **CLIENT_ID** from _GoogleService-Info.plist_ -->
<string>VVVVVVV</string>
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <!-- TODO: replace with **REVERSED_CLIENT_ID** from _GoogleService-Info.plist_ -->
            <string>com.googleusercontent.apps.VVVVVVV</string>
        </array>
    </dict>
</array>
```

## This template depends on:
1. Getx 
   1. State management
   2. Context-less **navigation**
   3. Context-less **dialogs**
   4. Context-less **screen Sizes**
   5. Context-less **l10n**
2. Firebase
   1. Authentication
   2. Firestore Database
   3. Crashlytics

## Utilities

This template features:
1. `pad()` -> fast way to add <b>Padding
2. `class Txts` -> fast way to add **Text**
3. Easy way to add **RichText**
4. Extensions for easy access to nullable and/or empty **String**s and **List**s
5. Material 3 color scheme
6. T&C and Privacy policy widget
7. Easy way to use Text Form Field
8. Validators
9. 

## Signing (Android)
) Debug:
1. Get the SHA1 and SHA256 with:
   ```bash
   keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore
   ```
2. And write the password "android"   

b) Release:
   1. Navigate to the directory for they key and **generate the key** with:
      ```bash
         keytool -genkeypair -v -keystore VVVVVV.jks -keyalg RSA -keysize 2048 -validity 10000 -alias VVVVVV -keypass VVVVVV -storepass VVVVVV
      ```
   2. Get the SHA1 and SHA256 with:
   ```bash
      keytool -list -v -keystore VVVVVVV.jks -alias VVVVVVV -storepass VVVVVVV -keypass VVVVVVV
   ```
