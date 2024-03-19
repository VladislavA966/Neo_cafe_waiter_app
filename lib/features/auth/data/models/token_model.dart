import 'package:json_annotation/json_annotation.dart';
part 'token_model.g.dart';

@JsonSerializable()
class TokenModel {
  final String message;
  @JsonKey(name: "refresh_token")
  final String refreshToken;
  @JsonKey(name: "access_token")
  final String accessToken;
  @JsonKey(name: "branch_id")
  final int branchId;

  TokenModel(
      {required this.message,
      required this.refreshToken,
      required this.accessToken,
      required this.branchId});
  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);
}
