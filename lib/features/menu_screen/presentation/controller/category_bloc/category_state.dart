part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryAllLoaded extends CategoryState {
  final List<CategoryEntity> model;

  CategoryAllLoaded({required this.model});
}

final class CategoryAllLoading extends CategoryState {}

final class CategoryAllError extends CategoryState {
  final String errorText;

  CategoryAllError({required this.errorText});
}
