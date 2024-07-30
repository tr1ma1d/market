import 'package:json_annotation/json_annotation.dart';



part 'product.g.dart';

@JsonSerializable()
class Product {
  int? productId;
  String? title;
  String? productDescription;
  int? price;
  double? rating;
  String? imageUrl;
  int? isAvailableForSale;

  Product(
      {required this.productId,
      required this.title,
      required this.productDescription,
      required this.price,
      required this.rating,
      required this.imageUrl,
      required this.isAvailableForSale});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);


  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
