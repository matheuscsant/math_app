import 'package:flutter/material.dart';
import 'package:math_app/repository/math_schema.dart';
import 'package:math_app/services/realm.service.dart';
import 'package:math_app/utils/string.util.dart';
import 'package:math_app/widgets/dialog_produto.widget.dart';
import 'package:math_app/widgets/main_drawer.widget.dart';

class StartMenuView extends StatefulWidget {
  const StartMenuView({super.key});

  @override
  State<StartMenuView> createState() => _StartMenuViewState();
}

class _StartMenuViewState extends State<StartMenuView> {
  @override
  Widget build(BuildContext context) {
    List<Produto> allProdutos = RealmService.getAll<Produto>();

    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text("Robs App"),
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
                        "",
                        0),
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
                return GestureDetector(
                  onTap: () {
                    // Abrir item
                  },
                  onLongPress: () {},
                  child: Card(
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
                                child: Text(
                                  "Produto Nº ${produto.id}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    await RealmService.delete(produto);
                                    setState(() {
                                      allProdutos =
                                          RealmService.getAll<Produto>();
                                    });
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

                                    setState(() {
                                      allProdutos =
                                          RealmService.getAll<Produto>();
                                    });
                                  },
                                  icon: const Icon(Icons.edit_outlined))
                            ],
                          ),
                          Text(
                            "Produto: ${produto.nome}",
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "Valor unitário:",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                StringUtils.numberToCurrency(produto.preco),
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
