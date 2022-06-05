import 'package:firebase_database/firebase_database.dart';

class Product {
  String? key, title, image;
  int? price;

  Product(
    this.title,
    this.price,
    this.image,
  );

  Product.fromSnapshoot(DataSnapshot snapshot) {
    var data = snapshot.value as Map;
    key = snapshot.key;
    title = data['title'];
    price = data['price'];
    image = data['image'];
  }
  factory Product.fromJson(Map<String, dynamic> json) =>
      Product(json['title'], json['price'], json['image']);

  toJson() {
    return {
      'title': title,
      'price': price,
      'image': image,
    };
  }
}
