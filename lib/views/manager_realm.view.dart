import 'package:flutter/material.dart';
import 'package:math_app/repository/math_schema.dart' as repository;
import 'package:math_app/services/realm.service.dart';
import 'package:realm/realm.dart';

class ManagerRealm extends StatefulWidget {
  const ManagerRealm({super.key});

  @override
  State<ManagerRealm> createState() => _ManagerRealmState();
}

class _ManagerRealmState extends State<ManagerRealm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Manager Realm"),
        actions: [
          IconButton(
              onPressed: () =>
                  showSearch(context: context, delegate: SearchRealmManager()),
              icon: const Icon(Icons.search))
        ],
      ),
    );
  }
}

class SearchRealmManager extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () => query.isEmpty ? close(context, null) : query = "",
            icon: const Icon(Icons.close))
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );
  @override
  Widget buildResults(BuildContext context) {
    switch (query) {
      case "Produto":
        List<repository.Produto> produtos =
            RealmService.getAll<repository.Produto>().toList();
        return produtos.isEmpty
            ? const Center(
                child: Text("Nenhuma informação encontrada :("),
              )
            : ListView.builder(
                itemCount: produtos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        "Produto: ${produtos[index].id} - ${produtos[index].name}"),
                  );
                },
              );

      default:
        return const Center(
          child: Text("Nenhuma informação encontrada :("),
        );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<SchemaObject> suggestions = RealmService.getAllSchemas()
        .toList()
        .where((element) => element.name.contains(query))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final SchemaObject suggestion = suggestions[index];
        return ListTile(
          title: Text("Entidade: ${suggestion.name}"),
          onTap: () {
            query = suggestion.name;
            showResults(context);
          },
        );
      },
    );
  }
}
