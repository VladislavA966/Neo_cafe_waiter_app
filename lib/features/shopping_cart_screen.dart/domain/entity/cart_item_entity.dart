class CartItemEntity {
  final int id;
  final String image;
  final String name;
  final int price;
  int quantity;

  CartItemEntity(
      {required this.id,
      required this.image,
      required this.name,
      required this.price,
      required this.quantity});
}

class CartEntity {
  final List<CartItemEntity> items;

  CartEntity({required this.items});
}
