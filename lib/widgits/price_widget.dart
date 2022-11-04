import 'package:flutter/material.dart';
import 'package:grocery_commerce/widgits/text_widget.dart';

import '../services/utils.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({Key? key, required this.salePrice, required this.price, required this.isOnSale}) : super(key: key);

  final double salePrice;
  final double price;
  final bool isOnSale;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    return FittedBox(
        child: Row(
      children: [
        TextWidget(
          text: '$salePrice\$',
          color: Colors.green,
          textSize: 22,
        ),
        const SizedBox(
          width: 5,
        ),
        Visibility(
          visible: isOnSale,
          child: Text(
            '$price\$',
            style: TextStyle(
              fontSize: 15,
              color: color,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        )
      ],
    ));
  }
}
