import 'package:flutter/material.dart';

import '../theme/color_schemes.dart';

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
            Icon(
              Icons.info_outline,
              color: Theme.of(context).colorScheme == darkColorScheme
                  ? Colors.black
                  : Colors.white,
            ),
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
  /// avisando que ocorreu uma falha de TimeOut em alguma requisição.
  static showSnackBarTimeout(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.warning_amber,
              color: Theme.of(context).colorScheme == darkColorScheme
                  ? darkColorScheme.error
                  : lightColorScheme.error,
            ),
            const SizedBox(
              width: 10,
            ),
            const Flexible(
              child: Text(
                "Tempo da solicitação excedido!",
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Método que recebe um BuildContext [context] para construir uma snackBar,
  /// avisando que os produtos foram enviados com sucesso.
  static showSnackProdutosEnviados(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check,
              color: Theme.of(context).colorScheme == darkColorScheme
                  ? Colors.green
                  : Colors.lightGreenAccent,
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              width: 10,
            ),
            const Flexible(
              child: Text(
                "Produtos enviados com sucesso!",
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Método que recebe um BuildContext [context] para construir uma snackBar,
  /// avisando que os produtos foram sincronizados.
  static showSnackProdutosSincronizados(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check,
              color: Theme.of(context).colorScheme == darkColorScheme
                  ? Colors.green
                  : Colors.lightGreenAccent,
            ),
            const SizedBox(
              width: 10,
            ),
            const Flexible(
              child: Text(
                "Produtos sincronizados com sucesso!",
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Método que recebe um BuildContext [context] para construir uma snackBar,
  /// avisando que o produto foi excluído.
  static showSnackProdutoExcluido(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check,
              color: Theme.of(context).colorScheme == darkColorScheme
                  ? Colors.green
                  : Colors.lightGreenAccent,
            ),
            const SizedBox(
              width: 10,
            ),
            const Flexible(
              child: Text(
                "Produto(s) excluído(s) com sucesso!",
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Método que recebe um BuildContext [context] para construir uma snackBar,
  /// avisando que ocorreu uma falha ao inserir/atualizar os produtos.
  static showSnackProdutosFalha(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.close,
              color: Colors.red,
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                "Falha ao inserir/atualizar os produtos",
                maxLines: 2,
              ),
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

  /// Método que recebe duas Strings [title] e [content] e um BuildContext [context],
  /// para construir uma Dialog com um SingleChildScroll para permitir grandes quantidades
  /// de textos.
  ///
  /// [title] Será o título da Dialog
  /// [content] Será o conteúdo da Dialog
  static showDialogWithSingleChildScroll(
      String title, String content, BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Ok"))
        ],
        content: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              content,
            ),
          ),
        ),
      ),
    );
  }
}
