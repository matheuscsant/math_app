import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:math_app/enums/url_webservices.enum.dart';
import 'package:math_app/repository/math_schema.dart';

class ProdutoService {
  /// Método que será utilizado para enviar um request para o endpoint de produtos
  /// no tipo GET para recuperar todos os produtos.
  Future<List<Produto>> getAllProdutos() async {
    late List<Produto> produtos;

    Uri uri = Uri.http(
        UrlWebservice.urlLocal.url, UrlWebservice.endPointProdutos.url);

    late http.Response response;

    try {
      response = await http.get(uri, headers: {
        "Content-type": "application/json",
        "Charset": "utf-8",
      }).timeout(const Duration(seconds: 15));

      produtos = List.from(
          (json.decode(utf8.decode(response.bodyBytes)) as List)
              .map((p) => ProdutoJsonHandler.fromJson(p))
              .toList());
    } catch (e) {
      rethrow;
    }

    return produtos;
  }

  /// Método que será utilizado para enviar um request para o endpoint de produtos
  /// no tipo POST para cadastrar os produtos que temos localmente.
  Future<bool> postAllProdutos(List<Produto> produtos) async {
    Uri uri = Uri.http(
        UrlWebservice.urlLocal.url, UrlWebservice.endPointProdutos.url);

    late http.Response response;

    try {
      response = await http.post(uri,
          body: json.encode(produtos.map((p) => p.toJson()).toList()),
          headers: {
            "Content-type": "application/json",
            "Charset": "utf-8",
          }).timeout(const Duration(seconds: 15));

      if (response.statusCode != 201) return false;
    } catch (e) {
      rethrow;
    }

    return true;
  }

  /// Método que será utilizado para enviar um request para o endpoint de produtos
  /// no tipo DELETE para apagar todos os produtos que temos no banco.
  Future<bool> deleteAllProdutos() async {
    Uri uri = Uri.http(
        UrlWebservice.urlLocal.url, UrlWebservice.endPointProdutos.url);

    late http.Response response;

    try {
      response = await http.delete(uri, headers: {
        "Content-type": "application/json",
        "Charset": "utf-8",
      }).timeout(const Duration(seconds: 15));

      if (response.statusCode != 204) return false;
    } catch (e) {
      rethrow;
    }

    return true;
  }
}
