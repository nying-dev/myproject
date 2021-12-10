import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Grocery item model
class MGrocery {
  final String id;
  final String name;
  final String url;
  final String description;
  final double price;
  int rating;
  MGrocery(
      {this.name,
      this.url,
      this.description,
      this.price,
      this.rating,
      this.id});

  factory MGrocery.fromJson(Map<String, dynamic> json, String id) {
    return MGrocery(
        id: id,
        name: json['productName'],
        description: json['productDescription'],
        price: json['price'].toDouble(),
        url: json['photosLink']);
  }
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
  final String id;
  final String Productid;
  final String Costumerid;
  int count = 0;
  final MGrocery item;
  MCartItem({this.Productid, this.Costumerid, this.count, this.item, this.id});

  dynamic toJson() => {
        'product_id': Productid,
        'costumer_id': Costumerid,
        'quantity': count,
      };

  factory MCartItem.fromJson(
      Map<String, dynamic> json, MGrocery item, String idCart) {
    return MCartItem(
      id: idCart,
      item: item,
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

class ODetails {
  final String id;
  final String costumerid;
  final String cartid;
  final DateFormat orderdate;
  final DateFormat deliverdate;
  final String status;
  final String addressdeliv;
  final String payMethod;
  ODetails(
      {this.id,
      this.costumerid,
      this.cartid,
      this.orderdate,
      this.deliverdate,
      this.status,
      this.addressdeliv,
      this.payMethod});

  dynamic toJson() => {
        'costumer_id': costumerid,
        'cart_id': cartid,
        'orderDate': orderdate,
        'deliveryAddress': addressdeliv,
        'paymentMethod': payMethod,
        'deliveryDate': deliverdate,
        'deliveryStatus': status
      };

  factory ODetails.fromJson(Map<String, dynamic> json) {
    return ODetails(
        costumerid: json['costumer_id'],
        cartid: json['cart_id'],
        orderdate: json['orderDate'],
        addressdeliv: json['deliveryAddress'],
        payMethod: json['PaymentMethod'],
        deliverdate: json['deliveryDate'],
        status: json['deliveryStatus']);
  }
}
