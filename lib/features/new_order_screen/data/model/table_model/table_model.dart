import 'package:json_annotation/json_annotation.dart';
part 'table_model.g.dart';

@JsonSerializable()
class TableModel {
  @JsonKey(name: "table_number")
  final int tableNumber;
  @JsonKey(name: "status")
  final String status;

  TableModel({required this.tableNumber, required this.status});
  factory TableModel.fromJson(Map<String, dynamic> json) =>
      _$TableModelFromJson(json);
  Map<String, dynamic> toJson() => _$TableModelToJson(this);
}
