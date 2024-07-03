import 'package:flutter/material.dart';

/// Classe de componentes que são utilizados frequentemente.
class ComponentsUtils {
  /// Método que recebe um BuildContext [context] e uma String [warningText] para
  /// construir uma snackBar, de aviso, o [warningText] será o conteúdo da snackBar.
  static showSnackBarWarning(BuildContext context, String warningText) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.info_outline),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                warningText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Método que recebe um BuildContext [context] para construir uma snackBar,
  /// avisando que o produto foi atualizado.
  static showSnackProdutoAtualizado(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.edit_document),
            SizedBox(
              width: 10,
            ),
            Text(
              "Produto atualizado com sucesso",
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  /// Método que recebe um BuildContext [context] para construir uma snackBar,
  /// avisando que o produto foi inserido.
  static showSnackProdutoInserido(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check),
            SizedBox(
              width: 10,
            ),
            Text(
              "Produto inserido com sucesso",
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  /// Método que recebe um BuildContext [context] para construir uma snackBar,
  /// avisando que ocorreu uma falha ao inserir/atualizar o produto.
  static showSnackProdutoFalha(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.close),
            SizedBox(
              width: 10,
            ),
            Text(
              "Falha ao inserir/atualizar o produto",
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  /// Método que recebe uma String [text] e um BuildContext [context] para construir
  /// um Dialog de loading, o [text] será o texto que vai aparecer ao lado do loading.
  static showDialogLoading(String text, BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    text,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
