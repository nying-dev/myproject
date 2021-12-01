import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myproject/models/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ItemCartPage extends StatefulWidget {
  @override
  _ItemCart createState() => _ItemCart();
}

class _ItemCart extends State<ItemCartPage> {
  Future<List<MCartItem>> _future;
  double total = 0.0;
  List<MCartItem> cartList = [];
  Future<List<MCartItem>> _getProducts() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User user = auth.currentUser;
    String uid = user.uid;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Cart')
        .get();
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    final cartList = docs.map((doc) => MCartItem.fromJson(doc.data())).toList();
    return cartList;
  }

  checkOut() {
    total = 0.0;

    cartList.forEach((element) {
      total += (element.item.price * element.count);
    });
  }

  Future<void> delete(String id) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User user = auth.currentUser;
    String uid = user.uid;
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Cart')
        .doc(id)
        .delete();
  }

  @override
  void initState() {
    _future = _getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Cart",
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        toolbarHeight: 60,
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      ),
      //future Builder
      body: FutureBuilder(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              cartList = snapshot.data;
              return ListView.builder(
                  itemCount: cartList == null ? 0 : cartList.length,
                  itemBuilder: (BuildContext context, int index) {
                    MCartItem cartItem = cartList[index];
                    return Column(children: [
                      ListTile(
                        title: Column(
                          children: [
                            Text(
                              (cartItem.item.name).toString(),
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Text(
                                  'PHP',
                                  style: TextStyle(
                                      fontSize: 8, color: Color(0xff0FA956)),
                                ),
                                Text('${cartItem.item.price}',
                                    style: TextStyle(color: Color(0xff0FA956)))
                              ],
                            )
                          ],
                        ),
                        leading: Image.network(
                          cartItem.item.url,
                          width: 50,
                          height: 50,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _incrementButton(counter: () {
                              setState(() {
                                cartItem.count++;
                                checkOut();
                              });
                            }),
                            Text(
                              cartItem.count.toString(),
                              overflow: TextOverflow.fade,
                            ),
                            _decrementButton(counter: () {
                              setState(() {
                                if (cartItem.count > 0) {
                                  cartItem.count--;
                                }
                                checkOut();
                              });
                            }),
                            Container(
                              child: GestureDetector(
                                onTap: () {
                                  String id = cartItem.item.name.toString();
                                  setState(() {
                                    cartList.removeAt(index);
                                    delete(id);
                                  });
                                },
                                child: Icon(Icons.delete, color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.green)
                    ]);
                  });
            } else {
              return Container();
            }
          }),

      //navigator bar
      // ignore: unnecessary_new
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: new Text("Total:"),
                subtitle: Text('₱${total.toStringAsFixed(2)}'),
              ),
            ),
            Expanded(
                child: new MaterialButton(
                    onPressed: () {},
                    child: new Text("Check out",
                        style: TextStyle(color: Colors.white)),
                    color: Colors.green))
          ],
        ),
      ),
    );
  }

//button adding
  Widget _incrementButton({Function counter}) {
    return Container(
      height: 32,
      width: 32,
      margin: EdgeInsets.symmetric(horizontal: 6),
      child: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.black87),
          backgroundColor: Colors.white,
          onPressed: counter),
    );
  }

//button decrement
  Widget _decrementButton({Function counter}) {
    return Container(
        height: 32,
        width: 32,
        margin: EdgeInsets.symmetric(horizontal: 6),
        child: FloatingActionButton(
            child: new Icon(Icons.remove, color: Colors.black87),
            backgroundColor: Colors.white,
            onPressed: counter));
  }
}
