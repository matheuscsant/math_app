import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:math_app/theme/color_schemes.dart';
import 'package:math_app/views/manager_realm.view.dart';
import 'package:math_app/views/start_menu.view.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: false, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: false, colorScheme: darkColorScheme),
      initialRoute: "/",
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      routes: {
        "/": (context) => const StartMenuView(),
        "/manager_realm": (context) => const ManagerRealm(),
      },
    );
  }
}
