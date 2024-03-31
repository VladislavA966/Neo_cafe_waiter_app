import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:neo_cafe_24/features/order_screen/domain/entity/order_info_entity.dart';
import 'package:neo_cafe_24/features/order_screen/domain/use_case/order_info_use_case.dart';

part 'order_info_event.dart';
part 'order_info_state.dart';

class OrderInfoBloc extends Bloc<OrderInfoEvent, OrderInfoState> {
  final OrderInfoUseCase orderInfoUseCase;
  OrderInfoBloc(this.orderInfoUseCase) : super(OrderInfoInitial()) {
    on<GerOrderInfoEvent>(
      _getNewOrderInfoEvent,
    );
  }

  Future<void> _getNewOrderInfoEvent(
      GerOrderInfoEvent event, Emitter<OrderInfoState> emit) async {
    emit(OrderInfoLoading());
    try {
      final order = await orderInfoUseCase(
        TableParams(
          tableNumber: event.tableNumber,
        ),
      );
      emit(
        OrderInfoLoaded(
          order: order,
        ),
      );
    } catch (e) {
      emit(
        OrderInfoError(
          errorText: e.toString(),
        ),
      );
    }
  }
}
