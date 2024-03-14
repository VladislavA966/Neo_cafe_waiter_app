part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

class CartLoadInProgress extends CartState {}

class CartLoadSuccess extends CartState {
  final List<CartItemEntity> items;

  CartLoadSuccess(this.items);
}

class CartLoadFailure extends CartState {}
