import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myproject/models/model.dart';
import 'dart:async';

class FirestoreUser {
  final FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference collectionUser =
      FirebaseFirestore.instance.collection('Users');
  CollectionReference collectionCart =
      FirebaseFirestore.instance.collection('Cart');
  CollectionReference collectionOrder =
      FirebaseFirestore.instance.collection('Order');

  String Uid() {
    User user = auth.currentUser;
    String uid = user.uid;
    return uid;
  }

  Future<void> setUserInfo({
    fname,
    lname,
    birthdate,
    province,
    municipality,
    baragay,
    medical,
    gender,
  }) async {
    String uid = Uid() as String;
    collectionUser
        .doc(uid)
        .set({
          'firstname': fname ?? '',
          'lastname': lname ?? '',
          'birtdate': birthdate ?? '',
          'medical': medical ?? '',
          'province': province ?? '',
          'municipality': municipality ?? '',
          'barangay': baragay ?? '',
          'gender': gender
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> getUserInfo() async {
    final info = await collectionUser.doc(Uid()).get();
    return info.data();
  }

  // ignore: unused_element
  Future<void> setCart({String itemId}) async {
    print('firestore');
    String uid = Uid() as String;
    MCartItem myCart = MCartItem(Productid: itemId, Costumerid: uid, count: 0);

    final QuerySnapshot collLength = await collectionCart.get();
    if (collLength.size > 0) {
      collectionCart
          .where('product_id', isEqualTo: itemId)
          .get()
          .then((value) => {
                print(value.docs.isEmpty),
                if (value.docs.isEmpty)
                  {
                    collectionCart
                        .doc()
                        .set(myCart.toJson())
                        .then((value) => print('add to cart'))
                        .catchError((e) => print(e))
                  }
              });
    } else {
      collectionCart
          .doc()
          .set(myCart.toJson())
          .then((value) => print('add to cart'))
          .catchError((e) => print(e));
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

  Future<void> setOrderDetail() {}
}
