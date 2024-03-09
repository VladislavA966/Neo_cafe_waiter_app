part of 'menu_item_bloc.dart';

@immutable
sealed class MenuItemState {}

final class MenuItemInitial extends MenuItemState {}

final class MenuItemLoading extends MenuItemState {}

final class MenuItemLoaded extends MenuItemState {
  final List<ItemEntity> model;

  MenuItemLoaded({required this.model});
}

final class MenuItemError extends MenuItemState {
  final String errorText;

  MenuItemError({required this.errorText});
}
