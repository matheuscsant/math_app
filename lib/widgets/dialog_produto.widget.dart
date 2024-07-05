// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:math_app/controllers/dialog_produto.controller.dart';
import 'package:math_app/formatters/uppercase.formatter.dart';
import 'package:math_app/repository/math_schema.dart';

class DialogInformacoesProduto extends StatefulWidget {
  final Produto produto;

  const DialogInformacoesProduto(this.produto, {super.key});

  @override
  State<DialogInformacoesProduto> createState() =>
      _DialogInformacoesProdutoState();
}

class _DialogInformacoesProdutoState extends State<DialogInformacoesProduto> {
  late final DialogProdutoController _controller;

  @override
  void initState() {
    super.initState();
    _controller = DialogProdutoController(widget.produto);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(15),
      title: const Text(
        "Informações do produto",
      ),
      content: Form(
        key: _controller.produtoFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _controller.nomeController,
              inputFormatters: [UpperCaseTextFormatter()],
              validator: (value) => value == null || value.isEmpty
                  ? "Nome do produto deve ser preenchido!"
                  : null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  "Produto",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text("Cancelar"),
        ),
        TextButton(
          onPressed: () async {
            bool resultInsert = await _controller.onSaveProduto(context);

            if (resultInsert) {
              Navigator.pop(context, widget.produto);
            }
          },
          child: const Text("Salvar"),
        )
      ],
    );
  }
}
