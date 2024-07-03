import 'package:flutter/services.dart';

/// Este classe é utilizado para setar a máscara Uppercase, no atributo inputFormatters
/// dos TextFormField.
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
