import 'package:flutter/material.dart';
import 'package:myproject/models/model.dart';
import 'package:myproject/screens/detailscreen/item_detail.dart';

import 'package:myproject/constants.dart';
import 'package:myproject/mq.dart';

class GroceryItem extends StatelessWidget {
  final MGrocery item;
  const GroceryItem({
    this.item,
  });

  void onTap(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => ItemDetailsSreen(item: item)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        width: MQuery.width * 0.4,
        decoration: BoxDecoration(
          border: Border.all(color: kBorderColor, width: 1.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: LayoutBuilder(
          builder: (_, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: item.hashCode,
                  child: Image.network(
                    item.url,
                    height: constraints.maxHeight * 0.29,
                    errorBuilder: (context, error, stackTrace) {
                      print(error);
                    },
                  ),
                ),
                SizedBox(height: 10),
                Text(item.name, style: Constants.kTitleStyle),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\₱${item.price}',
                      style: Constants.kTitleStyle
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
