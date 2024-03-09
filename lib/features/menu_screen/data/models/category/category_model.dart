import 'package:json_annotation/json_annotation.dart';
import 'package:neo_cafe_24/features/menu_screen/domain/entity/category_entity.dart';
part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  final int? id;
  final String? name;
  @JsonKey(name: "image")
  final String? image;

  CategoryModel({this.id, this.name, this.image});
  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
  CategoryEntity toEntity() =>
      CategoryEntity(id: id ?? 0, name: name ?? '', image: image ?? '');
}
