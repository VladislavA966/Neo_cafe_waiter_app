part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartStarted extends CartEvent {}

class CartItemAdded extends CartEvent {
  final CartItemEntity item;

  CartItemAdded(this.item);
}

class CartItemRemoved extends CartEvent {
  final int itemId;

  CartItemRemoved(this.itemId);
}

class CartItemsRequested extends CartEvent {}

class CleanCartEvent extends CartEvent {}
