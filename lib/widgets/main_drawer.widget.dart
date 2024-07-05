import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_app/utils/string.util.dart';
import 'package:widget_marquee/widget_marquee.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: Color(0xFF005AC1)),
                  currentAccountPicture: const CircleAvatar(
                      backgroundImage:
                          NetworkImage("https://picsum.photos/200")),
                  accountName: const Text("José Roberto dos Santos"),
                  accountEmail: Marquee(
                    delay: const Duration(seconds: 1),
                    duration: const Duration(seconds: 8),
                    child: Text(
                      StringUtils.dateToBrazillianFormatDateLocalWithDay(
                          DateTime.now()),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("Início"),
                  onTap: () {
                    String currentRoute =
                        ModalRoute.of(context)!.settings.name ?? "";
                    currentRoute == "/" || currentRoute.isEmpty
                        ? Navigator.of(context).pop()
                        : Navigator.of(context)
                            .pushNamedAndRemoveUntil("/", (route) => false);
                  },
                ),
                const Divider(),
                kDebugMode || kProfileMode
                    ? ExpansionTile(
                        title: const Text("Debug"),
                        leading: const Icon(Icons.code),
                        children: [
                          ListTile(
                            leading: const Icon(Icons.table_view),
                            title: const Text("Manager Realm"),
                            onTap: () => Navigator.of(context)
                                .pushNamed("/manager_realm"),
                          ),
                        ],
                      )
                    : Container()
              ],
            ),
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Column(
              children: [
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout_rounded),
                  title: const Text("Sair"),
                  onTap: () => SystemNavigator.pop(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
