
class Category{
  int? id;
  final String? name;
  String? imageUrl;

  Category({required this.id, required this.name, required this.imageUrl});
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
  @override
  String toString() {
    return 'Category{id: $id, name: $name, imageUrl: $imageUrl}';
  }
}