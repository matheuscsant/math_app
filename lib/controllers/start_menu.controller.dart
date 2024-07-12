// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:math_app/repository/math_schema.dart';
import 'package:math_app/services/produto.service.dart';
import 'package:math_app/services/realm.service.dart';
import 'package:math_app/utils/components.util.dart';
import 'package:share_plus/share_plus.dart';

class StartMenuController {
  final ProdutoService _service = ProdutoService();

  Future<bool> enviarProdutos(
      BuildContext context, List<Produto> produtos) async {
    try {
      bool result = await _service.deleteAllProdutos();

      if (result) {
        await _service.postAllProdutos(produtos);
      } else {
        throw Exception();
      }
    } on TimeoutException catch (e) {
      log(e.toString());
      ComponentsUtils.showSnackBarTimeout(context);
      return false;
    } catch (e) {
      log(e.toString());
      ComponentsUtils.showSnackProdutosFalha(context);
      return false;
    }

    return true;
  }

  Future<bool> sincronizarProdutos(BuildContext context) async {
    try {
      List<Produto> produtos = await _service.getAllProdutos();

      await RealmService.deleteAll<Produto>();
      await RealmService.addList(produtos);
    } on TimeoutException catch (e) {
      log(e.toString());
      ComponentsUtils.showSnackBarTimeout(context);
      return false;
    } catch (e) {
      log(e.toString());
      ComponentsUtils.showSnackProdutosFalha(context);
      return false;
    }

    return true;
  }

  Future<void> enviarRelatorio(List<Produto> produtos, List<bool> selectedItems,
      BuildContext context) async {
    StringBuffer sb = StringBuffer();

    for (var i = 0; i < selectedItems.length; i++) {
      if (selectedItems[i]) {
        sb.write("${produtos[i].name}\n");
      }
    }

    Navigator.of(context).pop();

    await Share.share(sb.toString());
  }
}
