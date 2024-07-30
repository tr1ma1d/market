
import 'package:json_annotation/json_annotation.dart';

part "category.g.dart";

@JsonSerializable()
class Category {
  int? id;
  final String? title;
  String? imageUrl;
  int? hasSubcategory;
  String? fullName;
  String? categoryDescription;



  Category(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.hasSubcategory,
      required this.fullName,
      required this.categoryDescription});
  

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
