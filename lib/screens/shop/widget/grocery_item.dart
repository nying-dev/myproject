import 'package:flutter/material.dart';
import 'package:myproject/models/model.dart';
import 'package:myproject/screens/detailscreen/item_detail.dart';
import 'package:flutter_image/network.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myproject/constants.dart';
import 'package:myproject/mq.dart';

class GroceryItem extends StatelessWidget {
  final MGrocery item;
  final String itemId;
  const GroceryItem({this.item, this.itemId});

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
                Container(
                  height: 100,
                  width: 100,
                  child: Hero(
                    tag: item.hashCode,
                    child: Image.network(
                      item.url,
                      height: constraints.maxHeight * 0.29,
                      errorBuilder: (context, error, stackTrace) {
                        return CachedNetworkImage(
                            progressIndicatorBuilder:
                                (context, url, progress) => Center(
                                      child: CircularProgressIndicator(
                                        value: progress.progress,
                                      ),
                                    ),
                            imageUrl: item.url,
                            fit: BoxFit.cover);
                      },
                    ),
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
