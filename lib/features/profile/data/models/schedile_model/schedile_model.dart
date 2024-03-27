import 'package:json_annotation/json_annotation.dart';
part 'schedile_model.g.dart';

@JsonSerializable()
class ScheduleModel {
  @JsonKey(name: "day")
  final String? day;
  @JsonKey(name: "start_time")
  final String? startTime;
  @JsonKey(name: "end_time")
  final String? endTime;

  ScheduleModel(
      {required this.day, required this.startTime, required this.endTime});

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);
}
