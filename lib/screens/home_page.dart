import 'package:flutter/material.dart';
import 'package:myproject/screens/shop/shop_screen.dart';
import 'package:myproject/widget/bottom_tabs.dart';
import 'package:myproject/screens/profile/profile.dart';
import 'package:flutter_svg/svg.dart';

import 'package:myproject/screens/shop/widget/cart_screen.dart';
import 'shop/widget/search.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  PageController _tabsPageController = PageController();
  int _selectedTab = 0;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: RichText(
              // ignore: unnecessary_new
              text: new TextSpan(
            style: new TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
            children: <TextSpan>[
              new TextSpan(text: 'My ', style: TextStyle(color: Colors.yellow)),
              new TextSpan(text: 'Grocery'),
            ],
          )),
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          toolbarHeight: 60,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ItemCart()));
              },
              child: Container(
                child: SvgPicture.asset('assets/icon/cart.svg',
                    color: Colors.white, width: 30.0, height: 30.0),
                padding: EdgeInsets.only(right: 30.0),
              ),
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabsPageController,
                onPageChanged: (num) {
                  setState(() {
                    _selectedTab = num;
                    print('Selected tabs${_selectedTab}');
                  });
                },
                children: [
                  Center(
                    child: ShopScreen(),
                  ),
                  Center(child: Text("Category")),
                  Center(
                    child: Text("Notify"),
                  ),
                  Center(
                    child: Profile(),
                  ),
                ],
              ),
            ),
            BottomTabs(
              selectedTab: _selectedTab,
              tabPressed: (num) {
                _tabsPageController.animateToPage(num,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInCubic);
              },
            )
          ],
        ));
  }
}
