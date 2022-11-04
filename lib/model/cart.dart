import 'package:flutter/material.dart';

class Cart with ChangeNotifier{
  int? id;
  int productId, quantity;

  Cart(
      {required this.productId,
        required this.quantity,});

  Cart.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        productId = json['productId'],
        quantity = json['quantity'];


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'quantity': quantity,
    };
  }
}
