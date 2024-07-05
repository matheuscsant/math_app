import 'package:json_annotation/json_annotation.dart';
import 'package:realm/realm.dart';

part 'math_schema.g.dart';
part 'math_schema.realm.dart';

/// Esta classe representa a entidade Produto do Realm
@RealmModel()
@JsonSerializable()
class $Produto {
  @PrimaryKey()
  @JsonKey(includeToJson: false, includeFromJson: false)
  late int id;
  late String name;

  Produto toRealmObject() {
    return Produto(
      id,
      name,
    );
  }

  static fromJson(Map<String, dynamic> json) => _$$ProdutoFromJson(json);

  Map<String, dynamic> toJson() => _$$ProdutoToJson(this);
}

extension ProdutoJsonHandler on Produto {
  static Produto fromJson(Map<String, dynamic> json) =>
      _$$ProdutoFromJson(json).toRealmObject();

  Map<String, dynamic> toJson() => _$$ProdutoToJson(this);
}
