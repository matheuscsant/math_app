import 'package:flutter/material.dart';
import 'package:math_app/repository/math_schema.dart';
import 'package:math_app/services/realm.service.dart';
import 'package:math_app/utils/string.util.dart';

class SearchProdutos extends SearchDelegate {
  final ValueNotifier<int> _radioGroup = ValueNotifier<int>(1);
  final ValueNotifier<List<Produto>> _filteredProducts =
      ValueNotifier<List<Produto>>([]);

  SearchProdutos() : super(searchFieldLabel: "Pesquisa de produtos");

  @override
  void dispose() {
    super.dispose();
    _radioGroup.dispose();
    _filteredProducts.dispose();
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () => query.isEmpty ? close(context, null) : query = "",
            icon: const Icon(Icons.close))
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) => buildSuggestions(context);

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Produto> allProdutos = RealmService.getAll<Produto>().toList();

    Map<bool Function(int i), bool Function(Produto produto)> filterOptions = {
      (i) => i == 0: (Produto produto) =>
          produto.id.toString().contains(query.toLowerCase()),
      (i) => i == 1: (Produto produto) =>
          (produto.nome).toLowerCase().contains(query.toLowerCase()),
    };

    Map<bool Function(int i), String> searchOptions = {
      (i) => i == 0: "Código",
      (i) => i == 1: "Nome",
    };

    _filteredProducts.value = allProdutos
        .where((produto) => filterOptions.entries.any(
            (option) => option.key(_radioGroup.value) && option.value(produto)))
        .toList();

    return Scaffold(
      bottomNavigationBar:
          SingleChildScrollView(child: buildFilter(searchOptions, context)),
      body: buildItens(),
    );
  }

  ExpansionTile buildFilter(
      Map<Function, String> searchOptions, BuildContext context) {
    return ExpansionTile(
      title: ValueListenableBuilder(
        valueListenable: _radioGroup,
        builder: (context, value, child) => Text(
            "Filtrando por: ${searchOptions.entries.firstWhere((option) => option.key(_radioGroup.value)).value}"),
      ),
      leading: const Icon(Icons.filter_list_outlined),
      initiallyExpanded: false,
      children: [
        Row(
          children: [
            Flexible(
              flex: 1,
              child: ValueListenableBuilder(
                valueListenable: _radioGroup,
                builder: (context, value, child) => RadioListTile(
                  title: const Text("Código"),
                  value: 0,
                  groupValue: _radioGroup.value,
                  onChanged: (value) {
                    _radioGroup.value = value as int;
                    query = "";
                    buildSuggestions(context);
                  },
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: ValueListenableBuilder<int>(
                valueListenable: _radioGroup,
                builder: (context, value, child) => RadioListTile(
                  groupValue: _radioGroup.value,
                  title: const Text("Nome"),
                  value: 1,
                  onChanged: (value) {
                    _radioGroup.value = value as int;
                    query = "";
                    buildSuggestions(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  ValueListenableBuilder buildItens() {
    return ValueListenableBuilder(
      valueListenable: _filteredProducts,
      builder: (context, value, child) => ListView.builder(
        itemCount: _filteredProducts.value.length,
        itemBuilder: (context, index) {
          final Produto produto = _filteredProducts.value[index];
          final double preco = _filteredProducts.value[index].preco;
          return Container(
            color: Theme.of(context).disabledColor,
            child: GestureDetector(
              onTap: () {
                // close(context, produto);
              },
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
                              "${produto.id} - ${produto.nome}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              StringUtils.numberToCurrency(preco),
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
