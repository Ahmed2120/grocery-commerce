import 'package:flutter/material.dart';

class Category with ChangeNotifier{
  int? id;
  String name, image;

  Category(
      {this.id,
        required this.name,
        required this.image,});

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['image'];


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
