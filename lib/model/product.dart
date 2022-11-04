import 'package:flutter/material.dart';

class Product with ChangeNotifier{
  int? id;
  String name, image;
  int categoryId;
  double price, salePrice;
  bool isOnSale, isPiece;

  Product(
      {this.id,
        required this.name,
        required this.image,
        required this.categoryId,
        required this.price,
        required this.salePrice,
        required this.isOnSale,
        required this.isPiece});

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['image'],
        categoryId = json['categoryId'],
        price = json['price'],
        salePrice = json['salePrice'],
        isOnSale = json['isOnSale'],
        isPiece = json['isPiece'];


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'categoryId': categoryId,
      'price': price,
      'salePrice': salePrice,
      'isOnSale': isOnSale,
      'isPiece': isPiece,
    };
  }
}
