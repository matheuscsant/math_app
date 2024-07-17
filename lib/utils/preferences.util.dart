import 'package:shared_preferences/shared_preferences.dart';

/// Classe utilizada para gerenciar o SharedPreferences.
class PreferencesUtil {
  /// Instância do SharedPreferences.
  static late final SharedPreferences _instance;

  /// Método para iniciar o SharedPreferences.
  static Future<SharedPreferences> initSharedPreferences() async =>
      _instance = await SharedPreferences.getInstance();

  /// Método que recebe uma String [key] e retorna um bool ou null caso não encontrar
  /// a chave no SharedPreferences.
  static bool? getBool(String key) => _instance.getBool(key);

  /// Método que recebe uma String [key] e retorna uma String ou null caso não encontrar
  /// a chave no SharedPreferences.
  static String? getString(String key) => _instance.getString(key);

  /// Método que recebe uma String [key] e retorna um double ou null caso não encontrar
  /// a chave no SharedPreferences.
  static double? getDouble(String key) => _instance.getDouble(key);

  /// Método que recebe uma String [key] e retorna um int ou null caso não encontrar
  /// a chave no SharedPreferences.
  static int? getInt(String key) => _instance.getInt(key);

  /// Método que recebe uma String [key] e retorna um DateTime ou null caso não encontrar
  /// a chave no SharedPreferences.
  /// - Nativamente o SharedPreferences não possui o tipo DateTime, então o valor é salvo
  /// como String e posteriormente convertido para DateTime ao recuperar.
  static DateTime? getDateTime(String key) => _instance.getString(key) != null
      ? DateTime.parse(_instance.get(key) as String)
      : null;

  /// Método que recebe uma String [key] e um bool [value] que será salvo
  /// no SharedPreferences. Retorna um bool se deu certo ou não.
  static Future<bool> setBool(String key, bool value) =>
      _instance.setBool(key, value);

  /// Método que recebe uma String [key] e uma String [value] que será salvo
  /// no SharedPreferences. Retorna um bool se deu certo ou não.
  static Future<bool> setString(String key, String value) =>
      _instance.setString(key, value);

  /// Método que recebe uma String [key] e um double [value] que será salvo
  /// no SharedPreferences. Retorna um bool se deu certo ou não.
  static Future<bool> setDouble(String key, double value) =>
      _instance.setDouble(key, value);

  /// Método que recebe uma String [key] e um int [value] que será salvo
  /// no SharedPreferences. Retorna um bool se deu certo ou não.
  static Future<bool> setInt(String key, int value) =>
      _instance.setInt(key, value);

  /// Método que recebe uma String [key] e um DateTime [value] que será salvo
  /// no SharedPreferences. Retorna um bool se deu certo ou não.
  /// - O DateTime [value] é salvo como String utilizando o .toString(), pois o
  /// SharedPreferences não tem nativamente um tipo DateTime para ser salvo.
  static Future<bool> setDateTime(String key, DateTime value) =>
      _instance.setString(key, value.toString());

  /// Método que recebe uma String [key], para excluir essa chave do SharedPreferences.
  static Future<void> remove(String key) => _instance.remove(key);
}