part of 'all_orders_bloc.dart';

@immutable
sealed class AllOrdersState {}

final class AllOrdersInitial extends AllOrdersState {}

final class AllOrdersLoading extends AllOrdersState {}

final class AllOrdersLoaded extends AllOrdersState {
  final List<OrderInfoEntity> orders;

  AllOrdersLoaded({required this.orders});
}

final class AllOrdersError extends AllOrdersState {
  final String errorText;

  AllOrdersError({required this.errorText});
}
