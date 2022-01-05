import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myproject/screens/category/categoryselection.dart';

class Category extends StatelessWidget {
  const Category({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for
    // the major Material Components.
    return Container(
        child: SingleChildScrollView(
            child: Container(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    width: 140,
                    height: 140,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          child: SvgPicture.asset('assets/icon/foryou.svg',
                              color: Colors.black, width: 100, height: 100),
                        ),
                        Text(
                          "For you",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryItem(
                                category: 'Beverages', database: 'Beverages')));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    width: 140,
                    height: 140,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          child: SvgPicture.asset('assets/icon/beverages.svg',
                              color: Colors.black, width: 100, height: 100),
                        ),
                        Text(
                          "Beverage",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    width: 140,
                    height: 140,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          child: SvgPicture.asset('assets/icon/cigarettes.svg',
                              color: Colors.black, width: 100, height: 100),
                        ),
                        Text(
                          "Cigarittes",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    width: 140,
                    height: 140,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          child: SvgPicture.asset('assets/icon/condiments.svg',
                              color: Colors.black, width: 100, height: 100),
                        ),
                        Text(
                          "Condiments",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoryItem(
                            category: 'Food',
                            database: 'Food',
                          )));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    width: 140,
                    height: 140,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          child: SvgPicture.asset('assets/icon/pantri.svg',
                              color: Colors.black, width: 100, height: 100),
                        ),
                        Text(
                          "Food",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryItem(
                                      category: 'Healthcare',
                                      database: 'Healthcare',
                                    )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        width: 140,
                        height: 140,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              child: SvgPicture.asset('assets/icon/health.svg',
                                  color: Colors.black, width: 100, height: 100),
                            ),
                            Text(
                              "Helth and care",
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryItem(
                                  category: 'Household Care',
                                  database: 'Household Care',
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    width: 140,
                    height: 140,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          child: SvgPicture.asset(
                              'assets/icon/householdcare.svg',
                              color: Colors.black,
                              width: 100,
                              height: 100),
                        ),
                        Text(
                          "Household Care",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryItem(
                                  category: 'Instant Noodles',
                                  database: 'Instant Noodles',
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    width: 140,
                    height: 140,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          child: SvgPicture.asset('assets/icon/noodles.svg',
                              color: Colors.black, width: 100, height: 100),
                        ),
                        Text(
                          "Instant Noodles",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryItem(
                                  category: 'Personal Care',
                                  database: 'Personal Care',
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    width: 140,
                    height: 140,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          child: SvgPicture.asset(
                              'assets/icon/personalcare.svg',
                              color: Colors.black,
                              width: 100,
                              height: 100),
                        ),
                        Text(
                          "Personal Care",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryItem(
                                    category: 'Snacks',
                                    database: 'Snacks',
                                  )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      width: 140,
                      height: 140,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            child: SvgPicture.asset('assets/icon/snack.svg',
                                color: Colors.black, width: 100, height: 100),
                          ),
                          Text(
                            "Snacks",
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryItem(
                                  category: 'Soup',
                                  database: 'Soup',
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    width: 140,
                    height: 140,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          child: SvgPicture.asset('assets/icon/soup.svg',
                              color: Colors.black, width: 100, height: 100),
                        ),
                        Text(
                          "Soup",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryItem(
                                    category: 'Spreads',
                                    database: 'Spreads',
                                  )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      width: 140,
                      height: 140,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            child: SvgPicture.asset('assets/icon/spread.svg',
                                color: Colors.black, width: 100, height: 100),
                          ),
                          Text(
                            "Spreads",
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    )));
  }
}
