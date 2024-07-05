import 'package:flutter/material.dart';

class DialogExcluirItem extends StatelessWidget {
  final String labelText;

  const DialogExcluirItem(
    this.labelText, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirmação de exclusão"),
      content: Text(labelText),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancelar")),
        TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Excluir"))
      ],
    );
  }
}
