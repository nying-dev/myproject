import 'package:flutter/material.dart';
import 'package:myproject/screens/category/category.dart';
import 'package:myproject/screens/shop/shop_screen.dart';
import 'package:myproject/widget/bottom_tabs.dart';
import 'package:myproject/screens/profile/profile.dart';
import 'package:flutter_svg/svg.dart';
import 'package:badges/badges.dart';
import 'package:myproject/screens/shop/widget/cart_screen.dart';
import 'package:myproject/service/analytic.dart';

//TODO 1st: ValueNotifier declaration
final badgecart = ValueNotifier<int>(0);

class Homepage extends StatefulWidget {
  _HomepageState hompage = _HomepageState();
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  PageController _tabsPageController = PageController();
  AnalyticServices analyticservices = AnalyticServices();
  int _selectedTab = 0;
  String firstWord = 'My ';
  String sencondWord = 'Grocery';

  //update future state
  @override
  void initState() {
    super.initState();
    _tabsPageController = PageController();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    analyticservices.testSetCurrentScreen(screenName: 'Home');
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: RichText(
              // ignore: unnecessary_new
              text: new TextSpan(
            style: new TextStyle(fontSize: 20.0, color: Colors.white),
            children: <TextSpan>[
              new TextSpan(
                  text: firstWord, style: TextStyle(color: Colors.yellow)),
              new TextSpan(text: sencondWord)
            ],
          )),
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          toolbarHeight: 60,
          actions: [
            GestureDetector(
              onTap: () {
                setState(() {
                  badgecart.value = 0;
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ItemCartPage()));
              },
              child: Container(
                padding: EdgeInsets.only(right: 30.0),
                child: Badge(
                  badgeColor: Colors.yellow,
                  showBadge: badgecart.value > 0 ? true : false,
                  badgeContent: Text(badgecart.value.toString()),
                  animationType: BadgeAnimationType.slide,
                  child: SvgPicture.asset('assets/icon/cart.svg',
                      color: Colors.white, width: 30.0, height: 30.0),
                ),
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
                  Center(child: Category()),
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
                headTittle(num);
                _tabsPageController.animateToPage(num,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInCubic);
              },
            )
          ],
        ));
  }

  void headTittle(num) {
    if (num == 0) {
      firstWord = 'My ';
      sencondWord = 'Grocery';
    } else if (num == 1) {
      firstWord = 'C';
      sencondWord = 'ategory';
    } else if (num == 2) {
      firstWord = 'N';
      sencondWord = 'otify';
    } else if (num == 3) {
      firstWord = 'U';
      sencondWord = 'ser';
    }
  }
}

class ChildPage extends StatelessWidget {
  final ValueChanged<int> update;
  ChildPage({this.update});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => update(100), // Passing value to the parent widget.
      child: Text('Update (in child)'),
    );
  }
}
