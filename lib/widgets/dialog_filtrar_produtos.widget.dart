import 'package:flutter/material.dart';
import 'package:math_app/formatters/uppercase.formatter.dart';

class DialogFiltrarProdutos extends StatefulWidget {
  const DialogFiltrarProdutos({super.key});

  @override
  State<DialogFiltrarProdutos> createState() => _DialogFiltrarProdutosState();
}

class _DialogFiltrarProdutosState extends State<DialogFiltrarProdutos> {
  final TextEditingController _nomeProduto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(15),
      title: const Text(
        "Filtro dos produtos",
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextFormField(
              controller: _nomeProduto,
              inputFormatters: [UpperCaseTextFormatter()],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Produto"),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text("Cancelar"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, _nomeProduto.text),
          child: const Text("Filtrar"),
        )
      ],
    );
  }
}
