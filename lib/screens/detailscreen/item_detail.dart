import 'package:flutter/material.dart';
import 'package:myproject/constants.dart';
import 'package:myproject/models/model.dart';
import 'package:myproject/widget/custom_button.dart';

import 'widgets/details.dart';
import 'widgets/expandable.dart';
import 'widgets/header.dart';

class ItemDetailsSreen extends StatelessWidget {
  static const routeName = 'item-details-screen/';
  final MGrocery item;

  const ItemDetailsSreen({this.item});

  @override
  Widget build(BuildContext context) {
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
                title: 'Reviews',
                trailing: Row(
                  children: List.generate(
                      5,
                      (index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 20,
                          )),
                ),
                description: '',
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: RoundButton(
                  key: Key(''),
                  title: 'Add To Cart',
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
