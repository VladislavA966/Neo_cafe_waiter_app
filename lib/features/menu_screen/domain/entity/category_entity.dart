class CategoryEntity {
  final int id;
  final String name;
  final String image;

  CategoryEntity({required this.id, required this.name, required this.image});
}

class CategoriesEntity {
  final List<CategoryEntity> categories;

  CategoriesEntity({required this.categories});
}
