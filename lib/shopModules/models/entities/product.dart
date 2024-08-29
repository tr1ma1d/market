
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product  {
  int? productId;
  String? title;
  String? productDescription;
  int? price;
  double? rating;
  String? imageUrl;
  List<String>? images;
  int? isAvailableForSale;

  Product({
    this.productId,
    this.title,
    this.productDescription,
    this.price,
    this.rating,
    this.imageUrl,
    this.images,
    this.isAvailableForSale,
  });


  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
