import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/entity/cart_item_entity.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/use_case/cart_use_case.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartUseCase cartUseCase;

  CartBloc({required this.cartUseCase}) : super(CartLoadInProgress()) {
    on<CartStarted>(_cartStartedEvent);
    on<CartItemAdded>(_cartItemAdded);
    on<CartItemRemoved>(_cartItemRemoved);
    on<CartItemsRequested>(_cartItemRequested);
    on<CleanCartEvent>(_cleanCartEvent);
  }

  Future<void> _cleanCartEvent(
      CleanCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoadInProgress());
    await cartUseCase.clearCart();
    emit(CartLoadFailure());
    emit(CartLoadFailure());
  }

  FutureOr<void> _cartItemRequested(
      CartItemsRequested event, Emitter<CartState> emit) async {
    emit(CartLoadInProgress());
    try {
      final items = await cartUseCase.getItemsUseCase();
      if (items == []) {
        emit(CartLoadFailure());
      }
      emit(
        CartLoadSuccess(items),
      );
    } catch (_) {
      emit(CartLoadFailure());
    }
  }

  FutureOr<void> _cartItemRemoved(
      CartItemRemoved event, Emitter<CartState> emit) async {
    try {
      await cartUseCase.removeItemAtUseCase(event.itemId);
      final items = await cartUseCase.getItemsUseCase();
      emit(CartLoadSuccess(items));
    } catch (e) {
      emit(
        CartLoadFailure(),
      );
    }
  }

  FutureOr<void> _cartItemAdded(
      CartItemAdded event, Emitter<CartState> emit) async {
    try {
      await cartUseCase.addItemUseCase(event.item);
      final items = await cartUseCase.getItemsUseCase();
      emit(CartLoadSuccess(items));
    } catch (e) {
      emit(
        CartLoadFailure(),
      );
    }
  }

  FutureOr<void> _cartStartedEvent(event, emit) async {
    try {
      final items = await cartUseCase.getItemsUseCase();
      emit(CartLoadSuccess(items));
    } catch (_) {
      emit(CartLoadFailure());
    }
  }
}
