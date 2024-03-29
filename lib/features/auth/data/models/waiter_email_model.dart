import 'package:json_annotation/json_annotation.dart';
part 'waiter_email_model.g.dart';

@JsonSerializable()
class WaiterEmailModel {
  @JsonKey(name: "csrf_token")
  final String csrfToken;
  @JsonKey(name: 'waiter_email')
  final String email;

  WaiterEmailModel({required this.email, required this.csrfToken});
  factory WaiterEmailModel.fromJson(Map<String, dynamic> json) =>
      _$WaiterEmailModelFromJson(json);
}
