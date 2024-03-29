import 'package:json_annotation/json_annotation.dart';
part 'employe_model.g.dart';

@JsonSerializable()
class EmployeModel {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "username")
  String username;
  @JsonKey(name: "password")
  String password;
  EmployeModel(
      {required this.id, required this.username, required this.password});
  factory EmployeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeModelFromJson(json);
}
