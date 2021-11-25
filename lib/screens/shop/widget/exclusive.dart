import 'package:flutter/material.dart';
import 'package:myproject/models/model.dart';
import 'package:myproject/mq.dart';
import 'grocery_item.dart';

class ExclusiveOffers extends StatelessWidget {
  ExclusiveOffers({
    Key key,
  });

  final List<MGrocery> _items = [
    MGrocery(
      name: 'Organic Bananas',
      url: 'assets/images/items/bananas.png',
      description: '7pcs',
      price: 4.99,
    ),
    MGrocery(
      name: 'Red Apple',
      url: 'assets/images/items/apples.png',
      description: '1kg',
      price: 5.99,
    ),
    MGrocery(
      name: 'Red Pepper',
      url: 'assets/images/items/pepper.png',
      description: '1kg',
      price: 3.99,
    ),
    MGrocery(
      name: 'coca-cola',
      url: 'assets/images/items/coca_cola.png',
      description: '100ml',
      price: 20.99,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MQuery.height * 0.35,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        scrollDirection: Axis.horizontal,
        itemCount: _items.length,
        itemBuilder: (_, i) => GroceryItem(item: _items[i]),
        separatorBuilder: (_, __) => SizedBox(width: 10),
      ),
    );
  }
}
