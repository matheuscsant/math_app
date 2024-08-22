import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:math_app/firebase_options.dart';
import 'package:math_app/services/realm.service.dart';
import 'package:math_app/utils/preferences.util.dart';
import 'package:math_app/views/main.view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await RealmService.initRealm();
  await PreferencesUtil.initSharedPreferences();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  runApp(const MainView());
}
