// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_all_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      category:
          CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      itemImage: json['item_image'] as String?,
      pricePerUnit: json['price_per_unit'] as int?,
      branch: json['branch'] as int?,
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((e) => IngredientModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'item_image': instance.itemImage,
      'price_per_unit': instance.pricePerUnit,
      'branch': instance.branch,
      'category': instance.category,
      'ingredients': instance.ingredients,
    };

IngredientModel _$IngredientModelFromJson(Map<String, dynamic> json) =>
    IngredientModel(
      id: json['id'] as int,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      measurementUnit: json['measurement_unit'] as String,
    );

Map<String, dynamic> _$IngredientModelToJson(IngredientModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'measurement_unit': instance.measurementUnit,
    };
