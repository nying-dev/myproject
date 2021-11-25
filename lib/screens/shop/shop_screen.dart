// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/cupertino.dart';
import 'package:myproject/constants.dart';
import 'package:flutter/material.dart';
import 'package:myproject/mq.dart';

import 'widget/banners.dart';
import 'widget/exclusive.dart';

class ShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MQuery().init(context);
    return SafeArea(
      child: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 20, bottom: 100),
          child: Column(
            children: [
              SizedBox(height: 10),
              // ignore: prefer_const_constructors
              Banners(
                key: Key(''),
              ),
              _buildSectiontitle('Recommend for you', () {}),
              ExclusiveOffers(
                key: Key(''),
              ),
              SizedBox(height: 10),
              _buildSectiontitle('Best Sellings', () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectiontitle(String title, [VoidCallback onTap]) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Constants.kTitleStyle),
            InkWell(
              onTap: onTap ?? () {},
              child: Text(
                'See all',
                style: TextStyle(color: Color(0xff53B175)),
              ),
            ),
          ],
        ));
  }
}
