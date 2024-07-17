import 'package:flutter/cupertino.dart';
import 'package:math_app/utils/preferences.util.dart';

class DialogServidorController {
  late final TextEditingController servidorController;
  late GlobalKey<FormState> servidorFormKey;

  DialogServidorController() {
    servidorFormKey = GlobalKey<FormState>();
    servidorController =
        TextEditingController(text: PreferencesUtil.getString("IP_SERVIDOR"));
  }

  void onSave(BuildContext context) {
    if (!servidorFormKey.currentState!.validate()) return;

    PreferencesUtil.setString("IP_SERVIDOR", servidorController.text);
    Navigator.of(context).pop();

  }
}
