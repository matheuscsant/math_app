import 'package:flutter/material.dart';
import 'package:math_app/services/realm.service.dart';

import '../repository/math_schema.dart';
import '../utils/components.util.dart';
import '../widgets/dialog_excluir_item.widget.dart';
import '../widgets/dialog_produto.widget.dart';

class SearchProdutos extends SearchDelegate {
  final List<Produto> _allProdutos = RealmService.getAll<Produto>();

  final ValueNotifier<List<Produto>> filteredProdutos =
      ValueNotifier<List<Produto>>([]);

  SearchProdutos() : super();

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
        inputDecorationTheme: searchFieldDecorationTheme,
        primaryColor: Colors.white,
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Colors.white));
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () => query.isEmpty ? close(context, null) : query = "",
            icon: const Icon(Icons.close)),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, filteredProdutos.value),
      );

  @override
  Widget buildResults(BuildContext context) => buildSuggestions(context);

  @override
  Widget buildSuggestions(BuildContext context) {
    filteredProdutos.value = _allProdutos
        .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return Scaffold(
        backgroundColor: Colors.grey,
        body: ValueListenableBuilder(
          valueListenable: filteredProdutos,
          builder: (context, value, child) => ListView.builder(
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

                                ComponentsUtils.showSnackProdutoExcluido(
                                    context);
                              },
                              icon: const Icon(Icons.delete_outline_outlined)),
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
                                "TAB. DE PREÇO: ${produto.tabelaDePreco}",
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
                            value: filteredProdutos.value[index].isSelected ??
                                false,
                            onChanged: (value) {
                              filteredProdutos.value[index].isSelected = value;
                              buildSuggestions(context);
                            },
                          ),
                          const Text(
                            "Enviar p/ cliente",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
