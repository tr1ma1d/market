// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      productId: json['productId'] as int?,
      title: json['title'] as String?,
      productDescription: json['productDescription'] as String?,
      price: json['price'] as int?,
      rating: (json['rating'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'] as String?,
      images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isAvailableForSale: json['isAvailableForSale'] as int?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'productId': instance.productId,
      'title': instance.title,
      'productDescription': instance.productDescription,
      'price': instance.price,
      'rating': instance.rating,
      'imageUrl': instance.imageUrl,
      'images': instance.images,
      'isAvailableForSale': instance.isAvailableForSale,
    };
