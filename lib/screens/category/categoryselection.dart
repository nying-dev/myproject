import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myproject/models/model.dart';
import 'package:myproject/service/firestore.dart';
import 'package:myproject/mq.dart';
import 'package:myproject/screens/shop/widget/grocery_item.dart';
import 'package:myproject/recommendation/recommend.dart';

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
  FirestoreUser firestoreUser = FirestoreUser();

  @override
  void initState() {
    print('${widget.category}');
    if (widget.category == 'For you') {
      _items = firestoreUser.recommend_health();
    } else {
      _items = firestoreUser.getItmes(widget.database);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Food'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                setState(() {
                  category = 'Food';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Beverages'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                setState(() {
                  category = 'Beverages';
                });

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
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
                    return GroceryItem(
                        item: itemList[index], itemId: itemList[index].id);
                  });
            } else {
              return Container();
            }
          }),
    );
  }
}
