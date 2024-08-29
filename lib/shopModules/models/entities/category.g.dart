// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      categoryId: (json['categoryId'] as num?)?.toInt(),
      title: json['title'] as String?,
      imageUrl: json['imageUrl'] as String?,
      hasSubcategory: (json['hasSubcategory'] as num?)?.toInt(),
      fullName: json['fullName'] as String?,
      categoryDescription: json['categoryDescription'] as String?,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.categoryId,
      'name': instance.title,
      'imageUrl': instance.imageUrl,
      'hasSubcategory': instance.hasSubcategory,
      'fullName': instance.fullName,
      'categoryDescription': instance.categoryDescription,
    };
