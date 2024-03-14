part of 'new_order_bloc.dart';

@immutable
sealed class NewOrderEvent {}

class SendNewOrderEvent extends NewOrderEvent {
  final TableEntity table;

  SendNewOrderEvent({required this.table});
}
