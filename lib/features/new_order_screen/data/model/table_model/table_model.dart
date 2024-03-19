import 'package:json_annotation/json_annotation.dart';
part 'table_model.g.dart';

@JsonSerializable()
class TableModel {
  final int? id;
  @JsonKey(name: "table_number")
  final int? tableNumber;
  @JsonKey(name: "is_available")
  final bool? isAvailable;
  @JsonKey(name: "branch")
  final int? branch;

  factory TableModel.fromJson(Map<String, dynamic> json) =>
      _$TableModelFromJson(json);

  TableModel(
      {required this.id,
      required this.tableNumber,
      required this.isAvailable,
      required this.branch});
  Map<String, dynamic> toJson() => _$TableModelToJson(this);
}
