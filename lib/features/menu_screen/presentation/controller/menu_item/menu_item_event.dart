part of 'menu_item_bloc.dart';

@immutable
sealed class MenuItemEvent {}

class GetAllItemsEvent extends MenuItemEvent {
  final int id;

  GetAllItemsEvent({required this.id});
}
