part of 'all_orders_bloc.dart';

@immutable
sealed class AllOrdersEvent {}

class GetAllOrders extends AllOrdersEvent {}
