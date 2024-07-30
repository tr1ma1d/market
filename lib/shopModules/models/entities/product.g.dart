// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      productId: (json['productId'] as num?)?.toInt(),
      title: json['title'] as String?,
      productDescription: json['productDescription'] as String?,
      price: (json['price'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'] as String?,
      isAvailableForSale: (json['isAvailableForSale'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'productId': instance.productId,
      'title': instance.title,
      'productDescription': instance.productDescription,
      'price': instance.price,
      'rating': instance.rating,
      'imageUrl': instance.imageUrl,
      'isAvailableForSale': instance.isAvailableForSale,
    };
