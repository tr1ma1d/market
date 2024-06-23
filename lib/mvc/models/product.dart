

class Product{
  int? productId;
  String? title;
  String? productDescription;
  int? price;
  double? rating;
  String? imgUrl;
  int? isAvailableForSale;
  static int count = 0;


  static List<Product> list = [];


  Product({required this.productId, required this.title, required this.productDescription,
    required this.price, required this.rating, required this.imgUrl, required this.isAvailableForSale});

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
        productId: json["productId"],
        title: json["title"],
        productDescription: json["productDescription"],
        price: json["price"],
        rating: json["rating"],
        imgUrl: json["imgUrl"],
        isAvailableForSale: json["isAvailableForSale"],
    );
  }





}