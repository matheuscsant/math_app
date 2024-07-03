import 'package:flutter/material.dart';
import 'package:math_app/services/realm.service.dart';
import 'package:math_app/views/main.view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await RealmService.initRealm();

  runApp(const MainView());
}
