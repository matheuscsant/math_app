// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:math_app/repository/math_schema.dart';
import 'package:math_app/services/produto.service.dart';
import 'package:math_app/services/realm.service.dart';
import 'package:math_app/utils/components.util.dart';

class StartMenuController {
  final ProdutoService _service = ProdutoService();

  Future<bool> enviarProdutos(
      BuildContext context, List<Produto> produtos) async {
    try {
      await _service.postAllProdutos(produtos);
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
}
