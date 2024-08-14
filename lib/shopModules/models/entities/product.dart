import 'package:internet_market/core/models/base_item_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends BaseItemModel<Product> {
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
  }) : super(productId);

  @override
  load(Product? newItem) {
    updateItem(newItem);
  }

  @override
  Product onItemLoaded() {
    return item!;
  }

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
