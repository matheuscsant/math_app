// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'math_schema.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Produto extends $Produto with RealmEntity, RealmObjectBase, RealmObject {
  Produto(
    int id,
    String name,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  Produto._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

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
      'name': name.toEJson(),
    };
  }

  static EJsonValue _toEJson(Produto value) => value.toEJson();
  static Produto _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
      } =>
        Produto(
          fromEJson(id),
          fromEJson(name),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Produto._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Produto, 'Produto', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
