// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'math_schema.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Produto extends $Produto with RealmEntity, RealmObjectBase, RealmObject {
  Produto(
    int id,
    String nome,
    double preco,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'nome', nome);
    RealmObjectBase.set(this, 'preco', preco);
  }

  Produto._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get nome => RealmObjectBase.get<String>(this, 'nome') as String;
  @override
  set nome(String value) => RealmObjectBase.set(this, 'nome', value);

  @override
  double get preco => RealmObjectBase.get<double>(this, 'preco') as double;
  @override
  set preco(double value) => RealmObjectBase.set(this, 'preco', value);

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
      'nome': nome.toEJson(),
      'preco': preco.toEJson(),
    };
  }

  static EJsonValue _toEJson(Produto value) => value.toEJson();
  static Produto _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'nome': EJsonValue nome,
        'preco': EJsonValue preco,
      } =>
        Produto(
          fromEJson(id),
          fromEJson(nome),
          fromEJson(preco),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Produto._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Produto, 'Produto', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('nome', RealmPropertyType.string),
      SchemaProperty('preco', RealmPropertyType.double),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
