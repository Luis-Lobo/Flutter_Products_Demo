import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Equatable {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'price')
  final String price;

  @JsonKey(name: 'quantity')
  final int quantity;

  @JsonKey(name: 'category')
  final String category;

  @JsonKey(name: 'image')
  final String image;

  @JsonKey(name: 'rating')
  //final RatingModel rating;
  final String rating;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  @override
  List<Object?> get props => [id, name, description, price, quantity, category, image, rating];
}
