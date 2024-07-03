import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/services.dart';

class StringsFormatters {
  /// Este método é utilizado para setar a máscara de CPF/CNPJ, no atributo inputFormatters
  /// dos TextFormField.
  static TextInputFormatter getMaskCpfOrCnpj() {
    return TextInputMask(
        mask: ["999.999.999-99", "99.999.999/9999-99"], reverse: false);
  }

  /// Este método é utilizado para setar a máscara de somente CPF, no atributo inputFormatters
  /// dos TextFormField.
  static TextInputFormatter getMaskCpf() {
    return TextInputMask(mask: ["999.999.999-99"], reverse: false);
  }

  /// Este método é utilizado para setar a máscara de somente CNPJ, no atributo inputFormatters
  /// dos TextFormField.
  static TextInputFormatter getMaskCnpj() {
    return TextInputMask(mask: ["99.999.999/9999-99"], reverse: false);
  }

  /// Este método é utilizado para setar a máscara de telefone, no atributo inputFormatters
  /// dos TextFormField, tanto telefones de 8 digitos, quando telefones de 9 digitos.
  static TextInputFormatter getMaskTelephone() {
    return TextInputMask(
        mask: ["(99) 9999-9999", "(99) 99999-9999"], reverse: false);
  }

  /// Este método é utilizado para setar a máscara de porcentagem, no atributo inputFormatters
  /// dos TextFormField.
  ///
  /// Exemplo de utilização:
  ///   ```dart
  ///     String double = 100236123.59;
  ///     // Se torna -> % 123,59
  ///   ```
  static getMaskPercent() {
    return TextInputMask(
      mask: '%! !999,99',
      placeholder: '0',
      maxPlaceHolders: 3,
      reverse: true,
    );
  }

  /// Este método é utilizado para setar a máscara de volumes/estoques, no atributo inputFormatters
  /// dos TextFormField.
  ///
  /// Exemplo de utilização:
  ///   ```dart
  ///     String double = 100236123.5989665;
  ///     // Se torna -> 100.236.123,5989
  ///   ```
  static getMaskStock() {
    return TextInputMask(
      mask: '999.999.999,9999',
      placeholder: '0',
      maxPlaceHolders: 5,
      reverse: true,
    );
  }

  /// Este método é utilizado para setar a máscara de decimal, no atributo inputFormatters
  /// dos TextFormField, essa máscara não tem limite.
  ///
  /// Exemplo de utilização:
  ///   ```dart
  ///     String double = 100236123.59;
  ///     // Se torna -> 100.236.123,59
  ///   ```
  static TextInputFormatter getMaskDecimal() {
    return TextInputMask(
      mask: '999.999.999,99',
      placeholder: '0',
      maxPlaceHolders: 3,
      reverse: true,
    );
  }

  /// Este método é utilizado para setar a máscara customizavel de decimal, no atributo inputFormatters
  /// dos TextFormField, essa máscara não tem limite.
  ///
  /// Exemplo de utilização:
  ///   ```dart
  ///     // customDecimal = 2
  ///     String double = 100236123.59;
  ///     // Se torna -> 100.236.123,59
  ///     // customDecimal = 4
  ///     String double = 100236123.59;
  ///     // Se torna -> 100.236.123,5900
  ///     // customDecimal = 6
  ///     String double = 100236123.59;
  ///     // Se torna -> 100.236.123,590000
  ///   ```
  static TextInputFormatter getMaskCustomDecimal(int customDecimal) {
    return TextInputMask(
      mask: '999.999.999,'.padRight(12 + customDecimal, '9'),
      placeholder: '0',
      maxPlaceHolders: customDecimal + 1,
      reverse: true,
    );
  }
}
