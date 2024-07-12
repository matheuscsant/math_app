// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:math_app/controllers/start_menu.controller.dart';
import 'package:math_app/repository/math_schema.dart';
import 'package:math_app/services/realm.service.dart';
import 'package:math_app/utils/components.util.dart';
import 'package:math_app/widgets/dialog_excluir_item.widget.dart';
import 'package:math_app/widgets/dialog_filtrar_produtos.widget.dart';
import 'package:math_app/widgets/dialog_produto.widget.dart';
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
  List<bool> isSelectedItems = List.generate(
    RealmService.getAll<Produto>().length,
    (index) => false,
  );
  bool _allSelected = false;

  void handleClick(int item) async {
    switch (item) {
      case 0:
        if (filteredProdutos.value.isEmpty) {
          ComponentsUtils.showSnackBarWarning(
              context, "Nenhum produto para ser enviado!");
          break;
        }

        ComponentsUtils.showDialogLoading(
            "Enviando produtos, aguarde...", context);
        bool result =
            await _controller.enviarProdutos(context, filteredProdutos.value);
        if (result) ComponentsUtils.showSnackProdutosEnviados(context);
        Navigator.of(context).pop();
        break;
      case 1:
        ComponentsUtils.showDialogLoading(
            "Sincronizados produtos, aguarde...", context);
        bool result = await _controller.sincronizarProdutos(context);
        if (result) ComponentsUtils.showSnackProdutosSincronizados(context);
        Navigator.of(context).pop();

        filteredProdutos.value = RealmService.getAll<Produto>();
        isSelectedItems = List.generate(
          filteredProdutos.value.length,
          (index) => false,
        );

        setState(() {
          _allSelected = false;
        });
        break;

      case 2:
        ComponentsUtils.showDialogLoading(
            "Preparando relatório, aguarde...", context);
        await _controller.enviarRelatorio(
            filteredProdutos.value, isSelectedItems, context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text("Robs App"),
        actions: <Widget>[
          _allSelected
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      for (var i = 0; i < isSelectedItems.length; i++) {
                        isSelectedItems[i] = false;
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
                      for (var i = 0; i < isSelectedItems.length; i++) {
                        isSelectedItems[i] = true;
                      }
                    });
                    _allSelected = true;
                  },
                  icon: const Icon(Icons.select_all),
                ),
          _allSelected
              ? IconButton(
                  onPressed: () async {
                    bool? result = await showDialog(
                      context: context,
                      builder: (context) => const DialogExcluirItem(
                          "Você tem certeza que quer excluir os produtos selecionados?"),
                    );

                    if (!(result ?? false)) return;

                    List<Produto> produtosDeletar = filteredProdutos.value;
                    for (var i = 0; i < isSelectedItems.length; i++) {
                      if (isSelectedItems[i]) {
                        await RealmService.delete<Produto>(produtosDeletar[i]);
                      }
                    }
                    setState(() {
                      filteredProdutos.value =
                          RealmService.getAll<Produto>().toList();
                    });

                    isSelectedItems = List.generate(
                      filteredProdutos.value.length,
                      (index) => false,
                    );

                    _allSelected = false;
                    ComponentsUtils.showSnackProdutoExcluido(context);
                  },
                  icon: const Icon(Icons.delete_forever),
                )
              : Container(),
          IconButton(
            onPressed: () async {
              String? result = await showDialog(
                context: context,
                builder: (context) => const DialogFiltrarProdutos(),
              );
              if (result == null || result.isEmpty) {
                filteredProdutos.value = RealmService.getAll<Produto>();
              } else {
                filteredProdutos.value = RealmService.getAll<Produto>()
                    .where(
                      (p) => p.name.toUpperCase().contains(result),
                    )
                    .toList();
              }
              isSelectedItems = List.generate(
                filteredProdutos.value.length,
                (index) => false,
              );
            },
            icon: const Icon(Icons.search),
          ),
          PopupMenuButton<int>(
            color: Colors.blue,
            onSelected: (item) => handleClick(item),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text(
                  'Enviar produtos p/ banco de dados',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<int>(
                value: 1,
                child: Text(
                  'Receber produtos do banco de dados',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<int>(
                value: 2,
                child: Text(
                  'Enviar produtos selecionados p/ clientes',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Produto? result = await showDialog(
              context: context,
              builder: (context) => DialogInformacoesProduto(
                    Produto(ObjectId(), ""),
                  )) as Produto?;
          if (result == null) return;

          filteredProdutos.value = RealmService.getAll<Produto>();
          isSelectedItems = List.generate(
            filteredProdutos.value.length,
            (index) => false,
          );
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
                                    bool? result = await showDialog(
                                      context: context,
                                      builder: (context) => const DialogExcluirItem(
                                          "Você tem certeza que quer excluir este produto?"),
                                    );

                                    if (result == null || !result) return;

                                    await RealmService.delete(produto);

                                    filteredProdutos.value =
                                        RealmService.getAll<Produto>();
                                    isSelectedItems = List.generate(
                                      filteredProdutos.value.length,
                                      (index) => false,
                                    );

                                    ComponentsUtils.showSnackProdutoExcluido(
                                        context);
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
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    "Tab. de Preço: ${produto.tabelaDePreco}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : Container(),
                          Row(
                            children: [
                              Checkbox(
                                value: isSelectedItems[index],
                                onChanged: (value) {
                                  setState(() {
                                    isSelectedItems[index] = value ?? false;
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
