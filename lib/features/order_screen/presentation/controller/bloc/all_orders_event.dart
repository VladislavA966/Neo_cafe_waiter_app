part of 'all_orders_bloc.dart';

@immutable
sealed class AllOrdersEvent {}

class GetAllOrders extends AllOrdersEvent {}

class FilterOrdersByStatus extends AllOrdersEvent {
  final String status;
  FilterOrdersByStatus(this.status);
}
