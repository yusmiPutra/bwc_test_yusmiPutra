import 'dart:async';
import 'package:bwc_test/model/res_product.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseRepo {
  Future<List<Product>?> getProduct() async {
    DatabaseReference postRef =
        FirebaseDatabase.instance.ref().child("Product");
    List<Product>? _foodList = [];
    var snapshot =
        (await postRef.once()).snapshot.value as Map;
    var res = snapshot.values.toList();
    for (var data in res) {
      _foodList.add(Product(data['title'], data['price'], data['image']));
    }
    return _foodList;
  }

  final key = "cache_product";
  Future<bool> saveAllProduct(List<Product> productList) async {
    SharedPreferences? sharedPreferences =
    await SharedPreferences.getInstance();
    String data = json.encode(productList);
    return await sharedPreferences.setString(key, data);
  }

  Future<List<Product>> getAllProduct() async {
    SharedPreferences? sharedPreferences =
    await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString(key);
    if (data != null) {
      List<dynamic> dataList = json.decode(data);
      List<Product> productList = [];
      for (var productData in dataList) {
        productList.add(Product.fromJson(productData));
      }
      return productList;
    }
    return [];
  }
}
