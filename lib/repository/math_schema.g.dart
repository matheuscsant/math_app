// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'math_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

$Produto _$$ProdutoFromJson(Map<String, dynamic> json) => $Produto()
  ..codigoAlternativo = (json['codigoAlternativo'] as num?)?.toInt()
  ..name = json['name'] as String
  ..tabelaDePreco = json['tabelaDePreco'] as String?;

Map<String, dynamic> _$$ProdutoToJson($Produto instance) => <String, dynamic>{
      'codigoAlternativo': instance.codigoAlternativo,
      'name': instance.name,
      'tabelaDePreco': instance.tabelaDePreco,
    };
