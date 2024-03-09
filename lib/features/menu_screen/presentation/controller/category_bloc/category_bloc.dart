import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:neo_cafe_24/features/menu_screen/domain/entity/category_entity.dart';
import 'package:neo_cafe_24/features/menu_screen/domain/use_cases/category_use_case.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryUseCase getAllCategories;
  CategoryBloc(this.getAllCategories) : super(CategoryInitial()) {
    getAllCategoriesEvent();
  }

  void getAllCategoriesEvent() {
    return on<GetAllCategoriesEvent>((event, emit) async {
      emit(CategoryAllLoading());
      try {
        final model = await getAllCategories.call(
          NoParams(),
        );
        emit(CategoryAllLoaded(model: model));
      } catch (e) {
        emit(
          CategoryAllError(
            errorText: e.toString(),
          ),
        );
      }
    });
  }
}
