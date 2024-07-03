import 'package:math_app/repository/math_schema.dart';
import 'package:realm/realm.dart';

/// ## Classe utilizada para gerenciar e realizar operações no Realm.
/// Esta classe possui todos os métodos para interagir com o Realm, a instância
/// do Realm não fica exposta pois ela pode fazer mais coisas, como alterar configurações
/// congelar o banco entre outras, que para o aplicativo não é interessante que seja
/// alterado.
///
/// Para alterar atributos de uma entidade no Realm utilizando os controllers do Flutter,
/// é necessário utilizarmos Transactions, todas as alterações devem
/// ser feitas após um Start na Transaction e após as alterações ou no caso de erros
/// deve ser chamado as operações Rollback ou Commit. No caso de ser lançado uma
/// Exception e a Transaction não receber um Rollback, ela continuará aberta, prendendo
/// as demais operações que viriam posteriomente.
///
/// > The SDK handles writes in terms of transactions. A transaction is a list
/// of read and write operations that the SDK treats as a single indivisible operation.
/// In other words, a transaction is all or nothing: either all of the operations
/// in the transaction succeed or none of the operations in the transaction take effect.
/// >
/// > All writes must happen in a transaction.
/// >
/// > The database allows only one open transaction at a time. The SDK blocks
/// other writes on other threads until the open transaction is complete.
/// Consequently, there is no race condition when reading values from the
/// database within a transaction.
/// >
/// > -- <cite>[Realm Documentation](https://www.mongodb.com/docs/atlas/device-sdks/sdk/flutter/crud/create/#std-label-flutter-write-transactions)</cite>
class RealmService {
  static final _config = Configuration.local(
    [Produto.schema],
    shouldDeleteIfMigrationNeeded: true,
  );

  /// Instância do Realm.
  static late final Realm _instance;

  /// Instância da Transaction utilizada nas operações com os controllers.
  static late Transaction _transaction;

  /// Método para iniciar o Realm.
  static Future<void> initRealm() async {
    _instance = Realm(_config);
  }

  /// Método que recebe uma String [query] e é feita uma query nos registros armazenados no Realm,
  /// também é um método parametrizado, então deve ser passado o tipo no método de qual entidade
  /// estamos consultado. Volta o tipo RealmResults, que pode ser usado o método
  /// .firstOrNull() para tratamento de objeto null.
  static RealmResults<T> findByQuery<T extends RealmObject>(String query) {
    return _instance.query<T>(query);
  }

  /// Método utilizado para deletar todos os registros de uma entidade,
  /// é um método parametrizado, então deve ser passado o tipo no método de qual
  /// entidade terá seus registros limpados.
  static Future<void> deleteAll<T extends RealmObject>() =>
      _instance.writeAsync(() => _instance.deleteAll<T>());

  /// Método utilizado para recuperar todos os Schemas/Entidades que estão presentes
  /// no Realm.
  static List<SchemaObject> getAllSchemas() =>
      _instance.config.schemaObjects.toList();

  /// Método que recebe um Object [primaryKey] e é feita uma consulta através
  /// da PrimaryKey, no caso de não encontrar, voltaram o tipo da Entidade só que null.
  static T? find<T extends RealmObject>(Object primaryKey) {
    return _instance.find<T>(primaryKey);
  }

  /// Método que recebe um Object [primaryKey] e é feita uma consulta através
  /// da PrimaryKey e retorna um bool true ou false se o registros existir.
  static bool exists<T extends RealmObject>(Object primaryKey) {
    return _instance.find<T>(primaryKey) != null;
  }

  /// Método para buscar todos os registros da entidade que foi passado parametrizado
  /// no método.
  static List<T> getAll<T extends RealmObject>() {
    return _instance.all<T>().toList();
  }

  /// Método que recebe uma entidade T [object], que será adicionado aos registros
  /// da entidade que foi parametrizada no método.
  static Future<T> add<T extends RealmObject>(T object) async =>
      await _instance.writeAsync(() => _instance.add<T>(object));

  /// Método que recebe uma lista da entidade T [items], que será adicionado aos registros
  /// da entidade que foi parametrizada no método.
  static Future<void> addList<T extends RealmObject>(Iterable<T> items) async =>
      await _instance.writeAsync(() => _instance.addAll<T>(items));

  /// Método que recebe uma entidade T [item], que será atualizado, a PrimaryKey do registro
  /// deve ser preservado, pois assim é possível atualizar o registro.
  static Future<T> update<T extends RealmObject>(T item) async {
    return await _instance
        .writeAsync<T>(() => _instance.add<T>(item, update: true));
  }

  /// Método que recebe uma entidade T [item], que será deletado.
  static Future<void> delete<T extends RealmObject>(T item) async {
    await _instance.writeAsync(() => _instance.delete<T>(item));
  }

  /// Método utilizado para iniciar uma Transaction, deve-se ter muita atenção
  /// no lançamento de exception, pois caso uma exception seja lançada durante
  /// a Transaction, deve ser feito o commit ou o rollback, do contrário a transaction
  /// ficará aberta, impedindo qualquer outra operação no Realm.
  static void startTransaction() => _transaction = _instance.beginWrite();

  /// Método utilizado para confirmar as alterações que foram feitas durante a Transaction.
  static void commit() => _transaction.commit();

  /// Método utilizado para cancelar e voltar o Realm ao seu estado anterior as
  /// alterações que foram feitas durante a Transaction.
  static void rollback() => _transaction.rollback();

  /// Método utilizado para encerrar o Realm.
  static void dispose() {
    _instance.close();
  }

  /// Método utilizado para limpar o Realm.
  /// Normalmente utilizado no login da aplicação.
  static Future<void> clearRealm() async {
    await RealmService.deleteAll<Produto>();
  }
}
