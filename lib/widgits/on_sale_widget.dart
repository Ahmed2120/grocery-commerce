import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_commerce/widgits/text_widget.dart';
import 'package:provider/provider.dart';

import '../consts/firebase_consts.dart';
import '../inner_screens/product_details.dart';
import '../model/product.dart';
import '../provider/cart_provider.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';
import 'heart_btn.dart';
import 'price_widget.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({Key? key}) : super(key: key);

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final theme = Utils(context).getTheme;
    Size size = Utils(context).getScreenSize;
    final product = Provider.of<Product>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool isInCart = cartProvider.isItemInCart(product.id!);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: ()=> Navigator.of(context).pushNamed(ProductDetails.routeName, arguments: product),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FancyShimmerImage(
                      imageUrl: product.image,
                      height: size.width * 0.21,
                      width: size.width * 0.2,
                      boxFit: BoxFit.fill,
                    ),
                    Column(
                      children: [
                        TextWidget(
                          text: product.isPiece ? '1Piece' : '1KG',
                          color: color,
                          textSize: 22,
                          isTitle: true,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: isInCart ? null : () {
                                final User? user = authInstance.currentUser;
                                if(user == null){
                                  GlobalMethods.errorDialog(subtitle: 'Please login first.', context: context);
                                  return;
                                }
                                cartProvider.addProductsToCart(productId: product.id!, quantity: 1);
                              },
                              child: Icon(
                                isInCart ? IconlyBold.bag2 : IconlyLight.bag2,
                                size: 22,
                                color: isInCart ? Colors.green : color,
                              ),
                            ),
                            HeartBTN(productId: product.id!,),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                PriceWidget(salePrice: product.salePrice, price: product.price,isOnSale: product.isOnSale,),
                const SizedBox(height: 5),
                TextWidget(
                  text: product.name,
                  color: color,
                  textSize: 16,
                  isTitle: true,
                ),
                const SizedBox(height: 5),
              ]),
        ),
      ),
    );
  }
}
