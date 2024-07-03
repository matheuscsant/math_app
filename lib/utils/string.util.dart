import 'package:intl/intl.dart';

/// ## Classe estática, utilizada para tratamento de dados.
/// Possui algumas propriedades como:
/// 1. Todo método que receba um parâmetro como DateTime e retorne uma String,
/// sempre vai fazer tratamento para transformar a data recebida em local DateTime.
/// 2. Todo método que retorne um algo sem ser uma String, fará tratamento para
/// UTC DateTime, uma vez que para comunicar com webservices, deve ser passado sempre
/// em UTC.
class StringUtils {
  /// Formatador de decimal
  static final NumberFormat decimalFormatter =
      NumberFormat.decimalPatternDigits(locale: "pt_BR", decimalDigits: 2);

  /// Formatador de valor (R$)
  static final NumberFormat currencyFormatter =
      NumberFormat.currency(locale: "pt_BR", symbol: "R\$", decimalDigits: 2);

  /// Formatador de decimal com 4 casas decimais
  static final NumberFormat stockFormatter =
      NumberFormat.decimalPatternDigits(locale: "pt_BR", decimalDigits: 4);

  /// Formatador para compactar números
  static final NumberFormat numberCompactFormatter =
      NumberFormat.compact(locale: "pt_BR");

  /// Formatador para compactar valores
  static final NumberFormat currencyCompactFormatter =
      NumberFormat.compactCurrency(
          locale: "pt_BR", symbol: "R\$", decimalDigits: 2);

  /// Formatador para transformar um DateTime no formato brasileiro (Apenas data)
  static final DateFormat brazillianFormatDate = DateFormat("dd/MM/yyyy");

  /// Formatador para transformar um DateTime no formato brasileiro com horas
  static final DateFormat brazillianFormatDateTime =
      DateFormat("dd/MM/yyyy HH:mm");

  /// Formatador para transformar um DateTime em extenso em portugês
  static final DateFormat brazillianFormatDateLocalWithDay =
      DateFormat.yMMMMEEEEd("pt_BR");

  /// Método para verificar se uma String [s] é null/vazia ou não.
  /// - Pode ser útil em locais onde teriamos que ter essa duas verificações,
  /// o operador ?? do Dart, apenas chega se é null ou não.
  /// 1. Utilizando uma String não vazia:
  ///   ```dart
  ///     String s = "string";
  ///     StringUtils.isNullOrEmpty(s) // false
  ///   ```
  /// 2. Utilizando uma String vazia:
  ///   ```dart
  ///     String s = "";
  ///     StringUtils.isNullOrEmpty(s) // true
  ///   ```
  /// 3. Utilizando uma String null:
  ///   ```dart
  ///     String? s = null;
  ///     StringUtils.isNullOrEmpty(s) // true
  ///   ```
  static bool isNullOrEmpty(String? s) {
    return s == null || s.isEmpty;
  }

  /// Método para transformar um double [number] em uma String formatada em decimal.
  ///
  /// Exemplo de utilização:
  ///   ```dart
  ///     double d = 23.45;
  ///     StringUtils.numberToDecimal(d) // "23,45"
  ///   ```
  static String numberToDecimal(double number) {
    return decimalFormatter.format(number);
  }

  /// Método para transformar um double [number] em uma String formatada em
  /// valor (R$).
  ///
  /// Exemplo de utilização:
  ///   ```dart
  ///     double d = 23.45;
  ///     StringUtils.numberToCurrency(d) // "R$ 23,45"
  ///   ```
  static String numberToCurrency(double number) {
    return currencyFormatter.format(number);
  }

  /// Método para transformar um double [number] em uma String formatada com 4
  /// casas decimais.
  ///
  /// Exemplo de utilização:
  ///   ```dart
  ///     double d = 23.4556;
  ///     StringUtils.numberToStock(d) // "23,4556"
  ///   ```
  static String numberToStock(double number) {
    return stockFormatter.format(number);
  }

  /// Método para transformar um double [number] em uma String com o número
  /// compactado.
  ///
  /// Exemplo de utilização:
  ///   ```dart
  ///     double d = 10500;
  ///     StringUtils.numberToCompactNumber(d) // "10,5 mil"
  ///   ```
  static String numberToCompactNumber(double number) {
    return numberCompactFormatter.format(number);
  }

  /// Método para transformar um double [number] em uma String com o valor
  /// compactado.
  ///
  /// Exemplo de utilização:
  ///   ```dart
  ///     double d = 10500;
  ///     StringUtils.numberToCompactCurrency(d) // "R$ 10,5 mil"
  ///   ```
  static String numberToCompactCurrency(double number) {
    return currencyCompactFormatter.format(number);
  }

  /// Método para transformar uma String [number] em um double correspondente.
  ///
  /// Exemplo de utilização:
  ///   ```dart
  ///     String s = "10,56";
  ///     StringUtils.decimalToDouble(s) // 10.56
  ///   ```
  static double decimalToDouble(String number) {
    return decimalFormatter.parse(number).toDouble();
  }

  /// Método para transformar um DateTime [date] em uma String com o formato
  /// brasileiro.
  ///
  /// Exemplo de utilização:
  ///   ```dart
  ///     DateTime d = DateTime(2024, 11, 02);
  ///     StringUtils.dateToBrazillianDate(d) // "02/11/2024"
  ///   ```
  static String dateToBrazillianDate(DateTime date) {
    return brazillianFormatDate.format(date.toLocal());
  }

  /// Método para transformar uma String [brazillianDate] no formato brasileiro
  /// em um DateTime.
  ///
  /// Exemplo de utilização:
  ///   ```dart
  ///     String s = "02/11/2024";
  ///     StringUtils.brazillianDateToDate(s) // DateTime(2024, 11, 02)
  ///   ```
  static DateTime brazillianDateToDate(String brazillianDate) {
    return brazillianFormatDate.parse(brazillianDate).toUtc();
  }

  /// Método para transformar um DateTime [date] no formato brasileiro com horas.
  ///
  /// Exemplo de utilização:
  ///   ```dart
  ///     DateTime d = DateTime(2024, 11, 02, 15, 30);
  ///     StringUtils.dateToBrazillianDateTime(d) // "02/11/2024 15:30"
  ///   ```
  static String dateToBrazillianDateTime(DateTime date) {
    return brazillianFormatDateTime.format(date.toLocal());
  }

  /// Método para transformar um DateTime [date] no formato brasileiro
  /// por extenso.
  ///
  /// Exemplo de utilização:
  ///   ```dart
  ///     DateTime d = DateTime(2024, 03, 11);
  ///     StringUtils.dateToBrazillianFormatDateLocalWithDay(d) // "segunda-feira, 11 de março de 2024"
  ///   ```
  static String dateToBrazillianFormatDateLocalWithDay(DateTime date) {
    return brazillianFormatDateLocalWithDay.format(date.toLocal());
  }

  /// Método para retornar um DateTime com o último dia do mês atual.
  ///
  /// Exemplo de utilização:
  ///   ```dart
  ///     (24/05/2024)
  ///     StringUtils.lastDayOfMonth(d) // DateTime(2024, 5, 31)
  ///   ```
  static DateTime lastDayOfMonth() {
    DateTime today = DateTime.now();
    return DateTime(today.year, today.month + 1, 0);
  }

  /// Método para retornar um DateTime com o primeiro dia do mês atual.
  ///
  /// Exemplo de utilização:
  ///   ```dart
  ///     (24/05/2024)
  ///     StringUtils.lastDayOfMonth(d) // DateTime(2024, 5, 1)
  ///   ```
  static DateTime firstDayOfMonth() {
    DateTime today = DateTime.now();
    return DateTime(today.year, today.month, 1);
  }
}
