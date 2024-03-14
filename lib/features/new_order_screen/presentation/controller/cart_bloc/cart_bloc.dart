import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/entity/cart_item_entity.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/use_case/cart_use_case.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartUseCase cartUseCase;

  CartBloc({required this.cartUseCase}) : super(CartLoadInProgress()) {
    on<CartStarted>((event, emit) async {
      try {
        final items = await cartUseCase.getItemsUseCase();
        emit(CartLoadSuccess(items));
        print('Создано');
      } catch (_) {
        emit(CartLoadFailure());
      }
    });

    on<CartItemAdded>((event, emit) async {
      try {
        await cartUseCase.addItemUseCase(event.item);
        final items = await cartUseCase.getItemsUseCase();
        emit(CartLoadSuccess(items));
        print('Добавлено');
      } catch (e) {
        print('Произошла хуйня какая то');
      }
    });

    on<CartItemRemoved>((event, emit) async {
      try {
        await cartUseCase.removeItemAtUseCase(event.itemId);
        final items = await cartUseCase.getItemsUseCase();
        emit(CartLoadSuccess(items));
      } catch (e) {
        print('Произошла, какая то хуета');
      }
    });

    on<CartItemsRequested>((event, emit) async {
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
        print('Произошла, какая то хуета');

        emit(CartLoadFailure());
      }
    });
    on<CleanCartEvent>((event, emit) async {
      emit(CartLoadInProgress());
      await cartUseCase.clearCart();
      emit(CartLoadFailure());
      print('Корзина пуста');
    });
  }
}
