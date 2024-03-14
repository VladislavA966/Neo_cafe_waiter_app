part of 'new_order_bloc.dart';

@immutable
sealed class NewOrderState {}

final class NewOrderInitial extends NewOrderState {}

final class NewOrderLoading extends NewOrderState {}

final class NewOrderLoaded extends NewOrderState {}

final class NewOrderError extends NewOrderState {
  final String errorText;

  NewOrderError({required this.errorText});
}
