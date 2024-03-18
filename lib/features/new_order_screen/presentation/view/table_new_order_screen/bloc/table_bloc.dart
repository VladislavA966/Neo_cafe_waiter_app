import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:neo_cafe_24/features/menu_screen/domain/use_cases/category_use_case.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/entity/table_entity.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/use_case/all_tables_use_case.dart';

part 'table_event.dart';
part 'table_state.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  final AllTableUseCase allTableUseCase;
  TableBloc(this.allTableUseCase) : super(TableInitial()) {
    on<GetAllTablesEvent>(
      _getAllTablesEvent,
    );
  }

  Future<void> _getAllTablesEvent(
      GetAllTablesEvent event, Emitter<TableState> emit) async {
    emit(TableLoading());
    try {
      final tables = await allTableUseCase(
        NoParams(),
      );
      emit(
        TableLoaded(tables: tables),
      );
    } catch (e) {
      emit(
        TableError(
          errorText: e.toString(),
        ),
      );
    }
  }
}
