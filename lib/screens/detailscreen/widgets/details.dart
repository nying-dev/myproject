import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myproject/models/model.dart';

import '../../../constants.dart';

class Details extends StatelessWidget {
  final MGrocery item;
  const Details({
    this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.name,
                style: Constants.kTitleStyle.copyWith(fontSize: 18),
              ),
              SvgPicture.asset(
                'assets/icons/favorite.svg',
                color: kBlackColor.withOpacity(0.7),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            item.description,
            style: Constants.kDescriptionStyle,
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Icon(
                Icons.horizontal_rule,
                color: kBlackColor.withOpacity(0.7),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: kBorderColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '1',
                  style: Constants.kTitleStyle,
                ),
              ),
              Icon(Icons.add, color: kPrimaryColor),
              Spacer(),
              Text('\$${item.price}',
                  style: Constants.kTitleStyle.copyWith(fontSize: 18))
            ],
          ),
        ],
      ),
    );
  }
}
