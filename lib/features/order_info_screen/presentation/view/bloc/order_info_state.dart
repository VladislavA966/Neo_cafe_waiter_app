part of 'order_info_bloc.dart';

@immutable
sealed class OrderInfoState {}

final class OrderInfoInitial extends OrderInfoState {}

final class OrderInfoLoading extends OrderInfoState {}

final class OrderInfoLoaded extends OrderInfoState {
  final OrderInfoEntity order;

  OrderInfoLoaded({required this.order});
}

final class OrderInfoError extends OrderInfoState {
  final String errorText;

  OrderInfoError({required this.errorText});
}
