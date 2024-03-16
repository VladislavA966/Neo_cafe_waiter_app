part of 'table_bloc.dart';

@immutable
sealed class TableEvent {}

class GetAllTablesEvent extends TableEvent {}
