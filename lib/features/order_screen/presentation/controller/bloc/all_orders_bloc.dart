import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:neo_cafe_24/features/menu_screen/domain/use_cases/category_use_case.dart';
import 'package:neo_cafe_24/features/order_screen/domain/entity/order_info_entity.dart';
import 'package:neo_cafe_24/features/order_screen/domain/use_case/orders_list_use_case.dart';

part 'all_orders_event.dart';
part 'all_orders_state.dart';

class AllOrdersBloc extends Bloc<AllOrdersEvent, AllOrdersState> {
  List<OrderInfoEntity> _allOrders = [];
  final OrdersListUseCase ordersUseCase;
  AllOrdersBloc(this.ordersUseCase) : super(AllOrdersInitial()) {
    on<GetAllOrders>(getAllOrders);
    on<FilterOrdersByStatus>(filterOrdersByStatus);
  }

  
  void getAllOrders(GetAllOrders event, Emitter<AllOrdersState> emit) async {
    emit(AllOrdersLoading());
    try {
      final orders = await ordersUseCase(
        NoParams(),
      );
      _allOrders = orders;
      emit(
        AllOrdersLoaded(
          orders: orders,
        ),
      );
    } catch (e) {
      emit(
        AllOrdersError(
          errorText: e.toString(),
        ),
      );
    }
  }

  void filterOrdersByStatus(
      FilterOrdersByStatus event, Emitter<AllOrdersState> emit) {
    if (event.status == "Все") {
      emit(AllOrdersLoaded(orders: _allOrders));
    } else {
      final filteredOrders = _allOrders
          .where((order) => order.orderStatus == event.status)
          .toList();
      emit(AllOrdersLoaded(orders: filteredOrders));
    }
  }
}
