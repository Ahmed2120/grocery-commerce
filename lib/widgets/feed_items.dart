import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_commerce/provider/cart_provider.dart';
import 'package:grocery_commerce/widgets/price_widget.dart';
import 'package:grocery_commerce/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../consts/firebase_consts.dart';
import '../inner_screens/product_details.dart';
import '../model/product.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';
import 'heart_btn.dart';

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({Key? key}) : super(key: key);

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  final _quantityTextController = TextEditingController();
  final FocusNode _quantityFocusNode = FocusNode();

  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final product = Provider.of<Product>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool isInCart = cartProvider.isItemInCart(product.id!);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () => Navigator.of(context).pushNamed(ProductDetails.routeName, arguments: product),
          borderRadius: BorderRadius.circular(12),
          child: Column(children: [
            FancyShimmerImage(
              imageUrl: product.image,
              height: size.width * 0.21,
              width: size.width * 0.2,
              boxFit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: FittedBox(
                      child: TextWidget(
                        text: product.name,
                        color: color,
                        textSize: 18,
                        isTitle: true,
                      ),
                    ),
                  ),
                  Flexible(flex: 1, child: HeartBTN(productId: product.id!,)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      flex: 3,
                      child: PriceWidget(
                        salePrice: product.salePrice,
                        price: product.price,
                        isOnSale: product.isOnSale,
                      )),
                  Flexible(
                    child: Row(
                      children: [
                        Flexible(
                          flex: 6,
                          child: FittedBox(
                            child: TextWidget(
                              text: product.isPiece ? 'Piece' : 'KG',
                              color: color,
                              textSize: 18,
                              isTitle: true,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                            flex: 2,
                            child: TextFormField(
                              controller: _quantityTextController,
                              focusNode: _quantityFocusNode,
                              key: const ValueKey('10'),
                              style: TextStyle(color: color, fontSize: 18),
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              enabled: true,
                              onChanged: (valueee) {
                                setState(() {});
                              },
                              onEditingComplete: () {
                                if (_quantityTextController.text.isEmpty) {
                                  setState(() {
                                    _quantityTextController.text = '1';
                                  });
                                }
                                _quantityFocusNode.unfocus();
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.]'),
                                ),
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: isInCart ? null : () {
                  final User? user = authInstance.currentUser;
                  if(user == null){
                    GlobalMethods.errorDialog(subtitle: 'Please login first.', context: context);
                    return;
                  }
                  cartProvider.addProductsToCart(productId: product.id!, quantity: int.parse(_quantityTextController.text));
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Theme.of(context).cardColor),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                        ),
                      ),
                    )),
                child: TextWidget(
                  text: isInCart ? 'In Cart' : 'Add to cart',
                  maxLines: 1,
                  color: color,
                  textSize: 20,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
