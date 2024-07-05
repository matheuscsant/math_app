// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:math_app/controllers/start_menu.controller.dart';
import 'package:math_app/repository/math_schema.dart';
import 'package:math_app/services/realm.service.dart';
import 'package:math_app/utils/components.util.dart';
import 'package:math_app/widgets/dialog_excluir_item.widget.dart';
import 'package:math_app/widgets/dialog_produto.widget.dart';
import 'package:math_app/widgets/main_drawer.widget.dart';

class StartMenuView extends StatefulWidget {
  const StartMenuView({super.key});

  @override
  State<StartMenuView> createState() => _StartMenuViewState();
}

class _StartMenuViewState extends State<StartMenuView> {
  final StartMenuController _controller = StartMenuController();
  late List<Produto> allProdutos;

  void handleClick(int item) async {
    switch (item) {
      case 0:
        if (allProdutos.isEmpty) {
          ComponentsUtils.showSnackBarWarning(
              context, "Nenhum produto para ser enviado!");
          break;
        }

        ComponentsUtils.showDialogLoading(
            "Enviando produtos, aguarde...", context);
        bool result = await _controller.enviarProdutos(context, allProdutos);
        if (result) ComponentsUtils.showSnackProdutosEnviados(context);
        Navigator.of(context).pop();
        break;
      case 1:
        ComponentsUtils.showDialogLoading(
            "Sincronizados produtos, aguarde...", context);
        bool result = await _controller.sincronizarProdutos(context);
        if (result) ComponentsUtils.showSnackProdutosSincronizados(context);
        Navigator.of(context).pop();
        setState(() {});
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    allProdutos = RealmService.getAll<Produto>();

    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text("Robs App"),
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (item) => handleClick(item),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                  value: 0, child: Text('Enviar produtos')),
              const PopupMenuItem<int>(
                  value: 1, child: Text('Sincronizar produtos')),
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
                    Produto(
                        allProdutos.lastOrNull == null
                            ? 1
                            : allProdutos.last.id + 1,
                        ""),
                  )) as Produto?;
          if (result == null) return;

          setState(() {
            allProdutos = RealmService.getAll<Produto>();
          });
        },
      ),
      body: allProdutos.isEmpty
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
              itemCount: allProdutos.length,
              itemBuilder: (context, index) {
                Produto produto = allProdutos[index];
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
                            IconButton(
                                onPressed: () async {
                                  bool? result = await showDialog(
                                    context: context,
                                    builder: (context) => const DialogExcluirItem(
                                        "Você tem certeza que quer excluir este produto?"),
                                  );

                                  if (result == null || !result) return;

                                  await RealmService.delete(produto);
                                  setState(() {
                                    allProdutos =
                                        RealmService.getAll<Produto>();
                                  });
                                },
                                icon:
                                    const Icon(Icons.delete_outline_outlined)),
                            IconButton(
                                onPressed: () async {
                                  Produto? result = await showDialog(
                                      context: context,
                                      builder: (context) =>
                                          DialogInformacoesProduto(
                                            produto,
                                          )) as Produto?;
                                  if (result == null) return;

                                  setState(() {
                                    allProdutos =
                                        RealmService.getAll<Produto>();
                                  });
                                },
                                icon: const Icon(Icons.edit_outlined))
                          ],
                        ),
                        Text(
                          produto.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
