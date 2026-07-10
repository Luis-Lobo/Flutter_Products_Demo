import 'package:equatable/equatable.dart';
import 'package:flutter_products_demo/src/features/products/domain/models/rating_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Equatable {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'price')
  final double price;

  @JsonKey(name: 'quantity', defaultValue: 1)
  final int quantity;

  @JsonKey(name: 'category')
  final String category;

  @JsonKey(name: 'image')
  final String image;

  @JsonKey(name: 'rating')
  final RatingModel rating;
  //final String rating;

  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  @override
  List<Object?> get props =>
      [id, title, description, price, quantity, category, image, rating];
}
