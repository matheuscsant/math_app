import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:math_app/repository/math_schema.dart';
import 'package:math_app/services/realm.service.dart';

class DialogProdutoController {
  late Produto produto;

  late GlobalKey<FormState> produtoFormKey;

  final TextEditingController idController = TextEditingController();
  late final TextEditingController codigoAlternativoController;
  late final TextEditingController nomeController;
  late final TextEditingController tabelaDePrecoController;

  DialogProdutoController(this.produto) {
    produtoFormKey = GlobalKey<FormState>();
    codigoAlternativoController =
        TextEditingController(text: produto.codigoAlternativo.toString() == "null" ? "" : produto.codigoAlternativo.toString());
    nomeController = TextEditingController(text: produto.name);
    tabelaDePrecoController =
        TextEditingController(text: produto.tabelaDePreco);
  }

  Future<bool> onSaveProduto(BuildContext context) async {
    if (!produtoFormKey.currentState!.validate()) return false;

    bool update = RealmService.exists<Produto>(produto.id);

    RealmService.startTransaction();

    try {
      produto.codigoAlternativo =
          int.tryParse(codigoAlternativoController.text);
      produto.name = nomeController.text;
      produto.tabelaDePreco = tabelaDePrecoController.text;
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
