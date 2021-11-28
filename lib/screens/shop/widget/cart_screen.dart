import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myproject/models/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myproject/service/firestore.dart';
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
                    return ListTile(
                      title: Text((cartItem.item.price).toString()),
                      leading: Image.asset(cartItem.item.url),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _incrementButton(counter: () {
                            setState(() {
                              cartItem.count++;
                              checkOut();
                            });
                          }),
                          Text(cartItem.count.toString()),
                          _decrementButton(counter: () {
                            setState(() {
                              if (cartItem.count > 0) {
                                cartItem.count--;
                              }
                              checkOut();
                            });
                          })
                        ],
                      ),
                    );
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
                subtitle: Text('${total.toStringAsFixed(2)}'),
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

  Widget _listItem(int index) {
    return InkWell(
        child: Container(
      height: 120,
      child: Row(
        children: <Widget>[
          Container(
            width: 50,
            margin: EdgeInsets.all(50),
            height: 100,
            child: Image.asset(
              'assets/images/items/coca_cola.png',
              width: 500,
              height: 500,
            ),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 25.0)
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Row(
              children: [
                _incrementButton(counter: () {
                  setState(() {
                    print(index);

                    index += 1;
                  });
                }),
                Text('${index}', style: TextStyle(fontSize: 18.0)),
                _decrementButton(counter: () {
                  if (index > 0) {
                    setState(() {
                      print(index);
                      index -= 1;
                    });
                  }
                })
              ],
            ),
          )
        ],
      ),
    ));
  }

//button adding
  Widget _incrementButton({Function counter}) {
    return FloatingActionButton(
        child: Icon(Icons.add, color: Colors.black87),
        backgroundColor: Colors.white,
        onPressed: counter);
  }

//button decrement
  Widget _decrementButton({Function counter}) {
    return FloatingActionButton(
        child: new Icon(Icons.remove, color: Colors.black87),
        backgroundColor: Colors.white,
        onPressed: counter);
  }
}
