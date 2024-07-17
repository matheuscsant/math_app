import 'package:flutter/material.dart';
import 'package:math_app/services/realm.service.dart';
import 'package:math_app/utils/preferences.util.dart';
import 'package:math_app/views/main.view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await RealmService.initRealm();
  await PreferencesUtil.initSharedPreferences();

  runApp(const MainView());
}
