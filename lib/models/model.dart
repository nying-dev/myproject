import 'package:flutter/material.dart';

// Grocery item model
class MGrocery {
  final String name;
  final String url;
  final String description;
  final double price;

  MGrocery({
    this.name,
    this.url,
    this.description,
    this.price,
  });
}

// Categories item model
class MCategory {
  final String title;
  final String url;
  final Color color;

  MCategory({this.title, this.url, this.color});
}

// Cart item model
class MCartItem {
  final MGrocery item;
  int count = 0;

  MCartItem({this.item, this.count});

  dynamic toJson() => {
        'name': item.name,
        'url': item.url,
        'description': item.description,
        'price': item.price,
        'quantity': count
      };

  factory MCartItem.fromJson(Map<String, dynamic> json) {
    MGrocery mCategory = MGrocery(
        name: json['name'],
        url: json['url'],
        description: json['description'],
        price: json['price']);

    return MCartItem(
      item: mCategory,
      count: json['quantity'],
    );
  }
}

class MGroceries {
  final String title;
  final Color color;
  final String url;

  MGroceries({this.title, this.color, this.url});
}
