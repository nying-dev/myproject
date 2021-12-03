import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myproject/models/model.dart';
import 'package:myproject/mq.dart';
import 'grocery_item.dart';

class ExclusiveOffers extends StatefulWidget {
  ExclusiveOffers({
    Key key,
  });

  @override
  _ExclusiveOffersState createState() => _ExclusiveOffersState();
}

class _ExclusiveOffersState extends State<ExclusiveOffers> {
  Future<List<MGrocery>> _future;
  List<MGrocery> itemlist = [];
  //data from firestore
  Future<List<MGrocery>> _getItmes() async {
    final queryItems = await FirebaseFirestore.instance
        .collection('INVENTORY')
        .where("category", isEqualTo: "Condiments")
        .get();
    List<QueryDocumentSnapshot> docs = queryItems.docs;
    final itemlist = docs.map((doc) => MGrocery.fromJson(doc.data())).toList();
    return itemlist;
  }

  @override
  void initState() {
    print(_getItmes());
    _future = _getItmes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MQuery.height * 0.35,
        child: FutureBuilder(
            future: _future,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print(snapshot.hasData);
              if (snapshot.hasData) {
                itemlist = snapshot.data;
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  scrollDirection: Axis.horizontal,
                  itemCount: itemlist == null ? 0 : itemlist.length,
                  itemBuilder: (BuildContext context, int i) =>
                      GroceryItem(item: itemlist[i]),
                  separatorBuilder: (_, __) => SizedBox(width: 10),
                );
              } else {
                return Container();
              }
            }));
  }
}
