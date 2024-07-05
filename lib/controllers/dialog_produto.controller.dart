import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:math_app/repository/math_schema.dart';
import 'package:math_app/services/realm.service.dart';

class DialogProdutoController {
  late Produto produto;

  late GlobalKey<FormState> produtoFormKey;

  final TextEditingController idController = TextEditingController();
  late final TextEditingController nomeController;

  DialogProdutoController(this.produto) {
    produtoFormKey = GlobalKey<FormState>();
    nomeController = TextEditingController(text: produto.name);
  }

  Future<bool> onSaveProduto(BuildContext context) async {
    if (!produtoFormKey.currentState!.validate()) return false;

    bool update = RealmService.exists<Produto>(produto.id);

    RealmService.startTransaction();

    try {
      produto.name = nomeController.text;
    } catch (e) {
      RealmService.rollback();
      log(e.toString());
      return false;
    }

    RealmService.commit();

    if (!update) {
      await RealmService.add<Produto>(produto);
    }

    return true;
  }
}
