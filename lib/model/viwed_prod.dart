import 'package:flutter/material.dart';

class ViewedProd with ChangeNotifier{
  int? id;
  int productId;

  ViewedProd(
      {required this.productId,});

  ViewedProd.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        productId = json['productId'];


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
    };
  }
}
