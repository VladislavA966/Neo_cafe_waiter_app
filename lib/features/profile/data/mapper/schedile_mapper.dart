import 'package:neo_cafe_24/core/mapper/mapper.dart';
import 'package:neo_cafe_24/features/profile/data/models/schedile_model/schedile_model.dart';
import 'package:neo_cafe_24/features/profile/domain/entities/schedule_entity.dart';

class ShceduleMapper extends Mapper<ScheduleModel, ScheduleEntity> {
  @override
  ScheduleEntity mapper(ScheduleModel model) {
    return ScheduleEntity(
        day: model.day ?? '',
        startTime: model.startTime ?? '',
        endTime: model.endTime ?? '');
  }
}
