import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject/models/model.dart';
import 'dart:async';
import 'package:myproject/service/record_local.dart';
import 'package:myproject/recommendation/recommend.dart';

class FirestoreUser {
  final FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference collectionUser =
      FirebaseFirestore.instance.collection('Users');
  CollectionReference collectionCart =
      FirebaseFirestore.instance.collection('Cart');
  CollectionReference collectionOrder =
      FirebaseFirestore.instance.collection('Order');
  Record_local recordlocal = Record_local();
  SnackBar snackBar;

  String Uid() {
    User user = auth.currentUser;
    String uid = user.uid;
    return uid;
  }

  Future<void> setUserInfo(Costumer costumer) async {
    String uid = Uid() as String;
    collectionUser
        .doc(uid)
        .set(costumer.toJson())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<Costumer> getUserInfo() async {
    final info = await collectionUser.doc(Uid()).get();
    final costumer = Costumer.fromJson(info.data());
    return costumer;
  }

  // ignore: unused_element
  Future<bool> setCart({String itemId}) async {
    String uid = Uid() as String;
    MCartItem myCart = MCartItem(Productid: itemId, Costumerid: uid, count: 0);
    final QuerySnapshot collLength = await collectionCart.get();
    if (collLength.size > 0) {
      return await collectionCart
          .where('product_id', isEqualTo: itemId)
          .get()
          .then((value) async {
        if (value.docs.isEmpty) {
          collectionCart
              .doc()
              .set(myCart.toJson())
              .then((value) => {print('Add to cart')})
              .catchError((e) => print(e));
          return true;
        } else {
          return false;
        }
      });
    } else {
      collectionCart
          .doc()
          .set(myCart.toJson())
          .then((value) => print('add to cart'))
          .catchError((e) => print(e));
      return true;
    }
  }

  Future<List<MGrocery>> getItmes(String category) async {
    final queryItems = await FirebaseFirestore.instance
        .collection('INVENTORY')
        .where("category", isEqualTo: category)
        .get();
    List<QueryDocumentSnapshot> docs = queryItems.docs;
    final itemlist =
        docs.map((doc) => MGrocery.fromJson(doc.data(), doc.id)).toList();
    return itemlist;
  }

  Future<MGrocery> getItem(String docid) async {
    DocumentSnapshot item = await FirebaseFirestore.instance
        .collection('INVENTORY')
        .doc(docid)
        .get();
    return MGrocery.fromJson(item.data(), item.id);
  }

  Future<void> updateCart(List<MCartItem> cart) {
    cart.forEach((element) {
      collectionCart
          .doc(element.id)
          .update({'quantity': element.toJson()['quantity']});
    });
  }

  CollectionReference inventory =
      FirebaseFirestore.instance.collection('INVENTORY');

  Future<List<MGrocery>> recommend_list() async {
    var itemlist = await recordlocal.read_record();
    List<MGrocery> items = [];
    for (String i in itemlist) {
      i = i.replaceAll("'", "");
      i = i.replaceAll(" ", "");
      DocumentSnapshot doc = await inventory.doc(i).get();
      print('Data:${doc.data()}');
      items.add(MGrocery.fromJson(doc.data(), i));
      print(i);
    }
    print('items:${items}');
    return items;
  }

  Future<List<MGrocery>> recommend_health() async {
    String ids = await get_health();
    var id_items = await recordlocal.str_to_arr(ids);
    List<MGrocery> items = [];
    for (var i in id_items) {
      i = i.replaceAll("'", "");
      i = i.replaceAll(" ", "");
      DocumentSnapshot doc = await inventory.doc(i).get();
      items.add(MGrocery.fromJson(doc.data(), i));
    }
    return items;
  }
}
