import 'package:flutter/material.dart';
import 'package:math_app/controllers/dialog_servidor.controller.dart';

class DialogServidor extends StatefulWidget {
  final DialogServidorController _controller = DialogServidorController();

  DialogServidor({super.key});

  @override
  State<DialogServidor> createState() => _DialogServidorState();
}

class _DialogServidorState extends State<DialogServidor> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._controller.servidorFormKey,
      child: AlertDialog(
        scrollable: true,
        title: const Text("Definir servidor"),
        content: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: TextFormField(
            controller: widget._controller.servidorController,
            decoration: const InputDecoration(
              label: Text("IP do servidor"),
              hintText: "Exemplo: 192.168.0.112:8080",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => widget._controller.onSave(context),
            child: const Text("Salvar"),
          )
        ],
      ),
    );
  }
}
