// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'math_schema.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Produto extends $Produto with RealmEntity, RealmObjectBase, RealmObject {
  Produto(
    ObjectId id,
    String name, {
    int? codigoAlternativo,
    String? tabelaDePreco,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'codigoAlternativo', codigoAlternativo);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'tabelaDePreco', tabelaDePreco);
  }

  Produto._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  int? get codigoAlternativo =>
      RealmObjectBase.get<int>(this, 'codigoAlternativo') as int?;
  @override
  set codigoAlternativo(int? value) =>
      RealmObjectBase.set(this, 'codigoAlternativo', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String? get tabelaDePreco =>
      RealmObjectBase.get<String>(this, 'tabelaDePreco') as String?;
  @override
  set tabelaDePreco(String? value) =>
      RealmObjectBase.set(this, 'tabelaDePreco', value);

  @override
  Stream<RealmObjectChanges<Produto>> get changes =>
      RealmObjectBase.getChanges<Produto>(this);

  @override
  Stream<RealmObjectChanges<Produto>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Produto>(this, keyPaths);

  @override
  Produto freeze() => RealmObjectBase.freezeObject<Produto>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'codigoAlternativo': codigoAlternativo.toEJson(),
      'name': name.toEJson(),
      'tabelaDePreco': tabelaDePreco.toEJson(),
    };
  }

  static EJsonValue _toEJson(Produto value) => value.toEJson();
  static Produto _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'codigoAlternativo': EJsonValue codigoAlternativo,
        'name': EJsonValue name,
        'tabelaDePreco': EJsonValue tabelaDePreco,
      } =>
        Produto(
          fromEJson(id),
          fromEJson(name),
          codigoAlternativo: fromEJson(codigoAlternativo),
          tabelaDePreco: fromEJson(tabelaDePreco),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Produto._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Produto, 'Produto', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('codigoAlternativo', RealmPropertyType.int,
          optional: true, indexType: RealmIndexType.regular),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('tabelaDePreco', RealmPropertyType.string, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
