part of 'order_info_bloc.dart';

@immutable
sealed class OrderInfoEvent {}
final class GerOrderInfoEvent extends OrderInfoEvent {
  final int tableNumber;

  GerOrderInfoEvent({required this.tableNumber});
}
