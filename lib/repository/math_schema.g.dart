// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'math_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

$Produto _$$ProdutoFromJson(Map<String, dynamic> json) => $Produto()
  ..id = (json['id'] as num).toInt()
  ..nome = json['nome'] as String
  ..preco = (json['preco'] as num).toDouble();

Map<String, dynamic> _$$ProdutoToJson($Produto instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'preco': instance.preco,
    };
