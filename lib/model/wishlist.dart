import 'package:flutter/material.dart';

class Wishlist with ChangeNotifier{
  int? id;
  int productId;

  Wishlist(
      {required this.productId,});

  Wishlist.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        productId = json['productId'];


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
    };
  }
}
