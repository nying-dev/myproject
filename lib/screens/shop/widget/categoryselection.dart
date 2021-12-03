import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myproject/models/model.dart';
import 'package:myproject/mq.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myproject/screens/shop/widget/grocery_item.dart';

class SelectionCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MQuery.height * 0.1,
        child: ListView(
          scrollDirection: Axis.horizontal,
          // ignore: prefer_const_literals_to_create_immutables
          padding: const EdgeInsets.symmetric(horizontal: 10),
          children: [
            InkWell(
              highlightColor: Color(0xFFA5D687),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryItem(
                              category: 'For you',
                              database: '',
                            )));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                margin: EdgeInsets.all(5),
                decoration:
                    myBoxDecoration(), //             <--- BoxDecoration here
                child: Picsvg(path: 'assets/icon/foryou.svg'),
              ),
            ),
            //---beverages
            InkWell(
              highlightColor: Color(0xFFA5D687),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryItem(
                            category: 'Beverages', database: 'Beverages')));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                margin: EdgeInsets.all(5),
                decoration:
                    myBoxDecoration(), //             <--- BoxDecoration here
                child: Picsvg(path: 'assets/icon/beverages.svg'),
              ),
            ),
            //---cigarettes
            InkWell(
              highlightColor: Color(0xFFA5D687),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryItem(
                              category: 'Cigarettes',
                              database: 'Cigarettes',
                            )));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                margin: EdgeInsets.all(5),
                decoration:
                    myBoxDecoration(), //             <--- BoxDecoration here
                child: Picsvg(path: 'assets/icon/cigarettes.svg'),
              ),
            ),
            //--condiments
            InkWell(
              highlightColor: Color(0xFFA5D687),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryItem(
                              category: 'Condiments',
                              database: 'Condiments',
                            )));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                margin: EdgeInsets.all(5),
                decoration:
                    myBoxDecoration(), //             <--- BoxDecoration here
                child: Picsvg(path: 'assets/icon/condiments.svg'),
              ),
            ),
          ],
        ));
  }

  Widget Picsvg({String path}) {
    final Widget svg = new SvgPicture.asset(
      path,
      width: 60,
      height: 20,
    );
    return svg;
  }
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(50)),
    border: Border.all(
      color: Color(0xffb0adb6),
      style: BorderStyle.solid,
    ),
  );
}

//

class CategoryItem extends StatefulWidget {
  final String category;
  final String database;
  CategoryItem({this.category, this.database});
  @override
  _categoryItemState createState() => _categoryItemState();
}

class _categoryItemState extends State<CategoryItem> {
  Future<List<MGrocery>> _items;
  List<MGrocery> itemList = [];

  Future<List<MGrocery>> _getItmes() async {
    final queryItems = await FirebaseFirestore.instance
        .collection('INVENTORY')
        .where("category", isEqualTo: widget.database)
        .get();
    List<QueryDocumentSnapshot> docs = queryItems.docs;
    final itemlist = docs.map((doc) => MGrocery.fromJson(doc.data())).toList();
    return itemlist;
  }

  @override
  void initState() {
    _items = _getItmes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        toolbarHeight: 60,
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      ),
      body: FutureBuilder(
          future: _items,
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              itemList = snapshot.data;
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    return GroceryItem(item: itemList[index]);
                  });
            } else {
              return Container();
            }
          }),
    );
  }
}
