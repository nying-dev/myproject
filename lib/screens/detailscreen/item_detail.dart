import 'package:flutter/material.dart';
import 'package:myproject/constants.dart';
import 'package:myproject/models/model.dart';
import 'package:myproject/screens/shop/widget/cart_screen.dart';
import 'package:myproject/service/firestore.dart';
import 'package:myproject/widget/custom_button.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'widgets/details.dart';
import 'widgets/expandable.dart';
import 'widgets/header.dart';

class ItemDetailsSreen extends StatefulWidget {
  final MGrocery item;
  ItemDetailsSreen({this.item});
  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsSreen> {
  static const routeName = 'item-details-screen/';

  FirestoreUser firestoreUser = FirestoreUser();
  FirebaseAnalytics analytics;
  var _myColorOne = Colors.grey;
  var _myColorTwo = Colors.grey;
  var _myColorThree = Colors.grey;
  var _myColorFour = Colors.grey;
  var _myColorFive = Colors.grey;
  int rating = 0;

  @override
  Widget build(BuildContext context) {
    final MGrocery item = widget.item;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Header(item: item),
              Details(item: item),
              SizedBox(height: 15),
              Divider(color: kBorderColor),
              Expandable(
                  trailing: Container(),
                  description: '',
                  title: 'Product Details'),
              Divider(color: kBorderColor, indent: 15, endIndent: 15),
              Expandable(
                title: 'Nutrition',
                trailing: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kSecondaryColor,
                  ),
                  child: Text('100gr'),
                ),
                description: '',
              ),
              Divider(color: kBorderColor, indent: 15, endIndent: 15),
              Expandable(
                title: 'Ratings',
                trailing: Row(children: <Widget>[
                  IconButton(
                    icon: new Icon(Icons.star),
                    onPressed: () => setState(() {
                      _myColorOne = Colors.orange;
                      _myColorTwo = null;
                      _myColorThree = null;
                      _myColorFour = null;
                      _myColorFive = null;
                      rating = 1;
                    }),
                    color: _myColorOne,
                  ),
                  IconButton(
                    icon: new Icon(Icons.star),
                    onPressed: () => setState(() {
                      _myColorOne = Colors.orange;
                      _myColorTwo = Colors.orange;
                      _myColorThree = Colors.grey;
                      _myColorFour = Colors.grey;
                      _myColorFive = Colors.grey;
                      rating = 2;
                    }),
                    color: _myColorTwo,
                  ),
                  IconButton(
                    icon: new Icon(Icons.star),
                    onPressed: () => setState(() {
                      _myColorOne = Colors.orange;
                      _myColorTwo = Colors.orange;
                      _myColorThree = Colors.orange;
                      _myColorFour = Colors.grey;
                      _myColorFive = Colors.grey;
                      rating = 3;
                    }),
                    color: _myColorThree,
                  ),
                  IconButton(
                    icon: new Icon(Icons.star),
                    onPressed: () => setState(() {
                      _myColorOne = Colors.orange;
                      _myColorTwo = Colors.orange;
                      _myColorThree = Colors.orange;
                      _myColorFour = Colors.orange;
                      _myColorFive = Colors.grey;
                      rating = 4;
                    }),
                    color: _myColorFour,
                  ),
                  IconButton(
                    icon: new Icon(Icons.star),
                    onPressed: () => setState(() {
                      _myColorOne = Colors.orange;
                      _myColorTwo = Colors.orange;
                      _myColorThree = Colors.orange;
                      _myColorFour = Colors.orange;
                      _myColorFive = Colors.orange;
                      rating = 5;
                    }),
                    color: _myColorFive,
                  ),
                ]),
                description: '',
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: RoundButton(
                  key: Key(''),
                  title: 'Add To Cart',
                  onTap: () {
                    MCartItem mCartItem = MCartItem();
                    item.rating = rating;
                    firestoreUser.UploadMyCartToFirebase(
                        myCart: MCartItem(item: item, count: 0));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ItemCartPage()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
