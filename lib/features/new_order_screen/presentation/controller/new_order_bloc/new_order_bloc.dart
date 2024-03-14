import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/entity/table_entity.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/use_case/order_use_case.dart';

part 'new_order_event.dart';
part 'new_order_state.dart';

class NewOrderBloc extends Bloc<NewOrderEvent, NewOrderState> {
  final NewOrderUseCase orderUseCase;
  NewOrderBloc(this.orderUseCase) : super(NewOrderInitial()) {
    on<SendNewOrderEvent>((event, emit) async {
      emit(
        NewOrderLoading(),
      );
      try {
        await orderUseCase.call(event.table);
        emit(
          NewOrderLoaded(),
        );
      } catch (e) {
        emit(
          NewOrderError(
            errorText: e.toString(),
          ),
        );
      }
    });
  }
}
