class IngredientEntity {
  final int id;
  final String name;
  final int quantity;
  final String measurementUnit;

  IngredientEntity(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.measurementUnit});
}
