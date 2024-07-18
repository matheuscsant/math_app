// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:math_app/controllers/start_menu.controller.dart';
import 'package:math_app/repository/math_schema.dart';
import 'package:math_app/services/realm.service.dart';
import 'package:math_app/theme/color_schemes.dart';
import 'package:math_app/utils/components.util.dart';
import 'package:math_app/utils/string.util.dart';
import 'package:math_app/views/seach_produtos.view.dart';
import 'package:math_app/widgets/dialog_produto.widget.dart';
import 'package:math_app/widgets/dialog_servidor.widget.dart';
import 'package:realm/realm.dart';

class StartMenuView extends StatefulWidget {
  const StartMenuView({super.key});

  @override
  State<StartMenuView> createState() => _StartMenuViewState();
}

class _StartMenuViewState extends State<StartMenuView> {
  final StartMenuController _controller = StartMenuController();
  final ValueNotifier<List<Produto>> filteredProdutos =
      ValueNotifier(RealmService.getAll<Produto>());
  bool _allSelected = false;

  void handleClick(int item) async {
    switch (item) {
      case 0:
        if (filteredProdutos.value.isEmpty) {
          ComponentsUtils.showSnackBarWarning(
              context, "Nenhum produto para ser enviado!");
          break;
        }
        bool? resultEnviar =
            await ComponentsUtils.showDialogWithSingleChildScrollConfirm(
                "Aviso",
                "Ao enviar os produtos, todos os que estiverem no servidor, serão apagados, você tem certeza?",
                context,
                "Enviar");

        if (!resultEnviar) return;

        ComponentsUtils.showDialogLoading(
            "Enviando produtos, aguarde...", context);
        bool result =
            await _controller.enviarProdutos(context, filteredProdutos.value);
        if (result) {
          ComponentsUtils.showSnackProdutosSucesso(
              context, "Produtos enviados com sucesso!");
        }
        Navigator.of(context).pop();
        break;
      case 1:
        ComponentsUtils.showDialogLoading(
            "Sincronizados produtos, aguarde...", context);
        bool result = await _controller.sincronizarProdutos(context);
        if (result) {
          ComponentsUtils.showSnackProdutosSucesso(
              context, "Produtos sincronizados com sucesso!");
        }
        Navigator.of(context).pop();

        filteredProdutos.value = RealmService.getAll<Produto>();

        setState(() {
          _allSelected = false;
        });
        break;

      case 2:
        ComponentsUtils.showDialogLoading(
            "Preparando relatório, aguarde...", context);
        await _controller.enviarRelatorio(filteredProdutos.value, context);
        break;

      case 3:
        await showDialog(
          context: context,
          builder: (context) => DialogServidor(),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).colorScheme == lightColorScheme
            ? lightColorScheme.primaryContainer
            : darkColorScheme.primaryContainer,
        title: const Text("Robs App"),
        actions: <Widget>[
          _allSelected
              ? IconButton(
                  onPressed: () async {
                    bool result = await ComponentsUtils
                        .showDialogWithSingleChildScrollConfirm(
                            "Confirmação de exclusão",
                            "Você tem certeza que quer excluir os produtos selecionados?",
                            context,
                            "Excluir");

                    if (!(result)) return;

                    List<Produto> produtosDeletar = filteredProdutos.value;
                    for (var i = 0; i < filteredProdutos.value.length; i++) {
                      if (filteredProdutos.value[i].isSelected ?? false) {
                        await RealmService.delete<Produto>(produtosDeletar[i]);
                      }
                    }
                    setState(() {
                      filteredProdutos.value =
                          RealmService.getAll<Produto>().toList();
                    });

                    for (var p in filteredProdutos.value) {
                      p.isSelected = false;
                    }

                    _allSelected = false;
                    ComponentsUtils.showSnackProdutosSucesso(
                        context, "Produtos");
                  },
                  icon: const Icon(Icons.delete_forever),
                )
              : Container(),
          _allSelected
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      for (var i = 0; i < filteredProdutos.value.length; i++) {
                        filteredProdutos.value[i].isSelected = false;
                      }
                    });
                    _allSelected = false;
                  },
                  icon: const Icon(Icons.deselect),
                )
              : IconButton(
                  onPressed: () {
                    if (filteredProdutos.value.isEmpty) {
                      ComponentsUtils.showSnackBarWarning(
                          context, "Nenhum produto para ser selecionado!");
                      return;
                    }
                    setState(() {
                      for (var i = 0; i < filteredProdutos.value.length; i++) {
                        filteredProdutos.value[i].isSelected = true;
                      }
                    });
                    _allSelected = true;
                  },
                  icon: const Icon(Icons.select_all),
                ),
          IconButton(
            onPressed: () async {
              List<Produto> produtos = await showSearch(
                  context: context, delegate: SearchProdutos());
              setState(() {
                for (var p in produtos) {
                  if (p.isSelected ?? false) {
                    filteredProdutos.value
                        .where(
                          (other) => p.name == other.name,
                        )
                        .first
                        .isSelected = true;
                  }
                }
              });
            },
            icon: const Icon(Icons.search),
          ),
          PopupMenuButton<int>(
            onSelected: (item) => handleClick(item),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text(
                  'Enviar produtos p/ banco de dados',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<int>(
                value: 1,
                child: Text(
                  'Receber produtos do banco de dados',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<int>(
                value: 2,
                child: Text(
                  'Enviar produtos selecionados p/ clientes',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<int>(
                value: 3,
                child: Text(
                  'Definir servidor',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          Produto? result = await showDialog(
              context: context,
              builder: (context) => DialogInformacoesProduto(
                    Produto(ObjectId(), "", 0.0),
                  )) as Produto?;
          if (result == null) return;

          filteredProdutos.value = RealmService.getAll<Produto>();
          for (var i = 0; i < filteredProdutos.value.length; i++) {
            filteredProdutos.value[i].isSelected = false;
          }

          ComponentsUtils.showSnackProdutosSucesso(
              context, "Produto inserido com sucesso!");
        },
      ),
      body: ValueListenableBuilder(
        valueListenable: filteredProdutos,
        builder: (context, value, child) => value.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      size: 40,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Nenhum produto encontrado",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: filteredProdutos.value.length,
                itemBuilder: (context, index) {
                  Produto produto = filteredProdutos.value[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 15, right: 15, top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: produto.codigoAlternativo != null
                                    ? Text(
                                        "CÓD: ${produto.codigoAlternativo}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : Container(),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    bool result = await ComponentsUtils
                                        .showDialogWithSingleChildScrollConfirm(
                                            "Confirmação de exclusão",
                                            "Você tem certeza que quer excluir este produto?",
                                            context,
                                            "Excluir");

                                    if (!result) return;

                                    await RealmService.delete(produto);

                                    filteredProdutos.value =
                                        RealmService.getAll<Produto>();
                                    for (var i = 0;
                                        i < filteredProdutos.value.length;
                                        i++) {
                                      filteredProdutos.value[i].isSelected =
                                          false;
                                    }

                                    ComponentsUtils.showSnackProdutosSucesso(
                                        context,
                                        "Produto(s) excluído(s) com sucesso!");
                                  },
                                  icon: const Icon(
                                      Icons.delete_outline_outlined)),
                              IconButton(
                                  onPressed: () async {
                                    Produto? result = await showDialog(
                                        context: context,
                                        builder: (context) =>
                                            DialogInformacoesProduto(
                                              produto,
                                            )) as Produto?;
                                    if (result == null) return;

                                    filteredProdutos.value =
                                        RealmService.getAll<Produto>();

                                    ComponentsUtils.showSnackProdutosSucesso(
                                        context,
                                        "Produto atualizado com sucesso!");
                                  },
                                  icon: const Icon(Icons.edit_outlined))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              produto.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          produto.tabelaDePreco != null &&
                                  (produto.tabelaDePreco as String).isNotEmpty
                              ? Builder(
                                  builder: (context) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        "TAB. DE PREÇO: ${produto.tabelaDePreco}",
                                        style: TextStyle(
                                          color: produto.tabelaDePreco !=
                                                      null &&
                                                  produto.tabelaDePreco!
                                                      .contains("*")
                                              ? Colors.red
                                              : Theme.of(context).colorScheme ==
                                                      lightColorScheme
                                                  ? Colors.black
                                                  : Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "VALOR DO PRODUTO: ${StringUtils.numberToCurrency(produto.valorProduto)}",
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: produto.isSelected,
                                onChanged: (value) {
                                  setState(() {
                                    produto.isSelected = value ?? false;
                                  });
                                },
                              ),
                              const Text("Enviar p/ cliente",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
