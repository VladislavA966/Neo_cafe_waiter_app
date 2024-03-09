import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:neo_cafe_24/features/menu_screen/domain/entity/item_entity.dart';
import 'package:neo_cafe_24/features/menu_screen/domain/use_cases/menu_items_use_case.dart';

part 'menu_item_event.dart';
part 'menu_item_state.dart';

class MenuItemBloc extends Bloc<MenuItemEvent, MenuItemState> {
  final AllItemsUseCase getAllitems;
  MenuItemBloc(this.getAllitems) : super(MenuItemInitial()) {
    getAllItemsEvent();
  }

  void getAllItemsEvent() {
    return on<GetAllItemsEvent>(
      (event, emit) async {
        emit(MenuItemLoading());
        try {
          final model = await getAllitems(CategoryParams(id: event.id));
          emit(
            MenuItemLoaded(model: model),
          );
        } catch (e) {
          emit(
            MenuItemError(
              errorText: e.toString(),
            ),
          );
        }
      },
    );
  }
}
