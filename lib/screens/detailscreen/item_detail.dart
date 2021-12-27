import 'package:flutter/material.dart';
import 'package:myproject/constants.dart';
import 'package:myproject/models/model.dart';
import 'package:myproject/service/firestore.dart';
import 'package:myproject/widget/custom_button.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:myproject/screens/home_page.dart';
import 'widgets/details.dart';
import 'widgets/expandable.dart';
import 'widgets/header.dart';
import 'package:myproject/recommendation/recommend.dart';

class ItemDetailsSreen extends StatefulWidget {
  final MGrocery item;
  final String itemId;
  ItemDetailsSreen({this.item, this.itemId});
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
  bool addItem = false;
  var url;
  var data;
  Homepage homepage = Homepage();
  @override
  Widget build(BuildContext context) {
    void _showScaffold(String message) {
      print(message);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }

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
                  onTap: () async {
                    addItem = await firestoreUser.setCart(itemId: item.id);
                    if (addItem) {
                      url = Uri.parse(
                          "http://192.168.1.112:5000//recommend?item=${item.name}");
                      data = await get_product(url);
                      print('recomend${data}');
                      _showScaffold('Add to cart');
                      badgecart.value++;
                    } else {
                      _showScaffold('Already in cart');
                    }
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
