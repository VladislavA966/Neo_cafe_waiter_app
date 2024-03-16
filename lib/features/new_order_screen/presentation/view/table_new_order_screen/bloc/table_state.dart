part of 'table_bloc.dart';

@immutable
sealed class TableState {}

final class TableInitial extends TableState {}

final class TableLoading extends TableState {}

final class TableLoaded extends TableState {
  final List<TableEntity> tables;

  TableLoaded({required this.tables});
}

final class TableError extends TableState {
  final String errorText;

  TableError({required this.errorText});
}
