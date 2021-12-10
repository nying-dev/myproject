import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myproject/service/firestore.dart';
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
  FirestoreUser firestoreUser = FirestoreUser();
  //data from firestore

  @override
  void initState() {
    _future = firestoreUser.getItmes("Condiments");
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
                  itemBuilder: (BuildContext context, int i) => GroceryItem(
                    item: itemlist[i],
                    itemId: itemlist[i].id,
                  ),
                  separatorBuilder: (_, __) => SizedBox(width: 10),
                );
              } else {
                return Container();
              }
            }));
  }
}
