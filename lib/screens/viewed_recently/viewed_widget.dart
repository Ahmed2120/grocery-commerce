import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../../consts/firebase_consts.dart';
import '../../inner_screens/product_details.dart';
import '../../model/viwed_prod.dart';
import '../../provider/cart_provider.dart';
import '../../provider/products_provider.dart';
import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class ViewedRecentlyWidget extends StatefulWidget {
  const ViewedRecentlyWidget({Key? key}) : super(key: key);

  @override
  _ViewedRecentlyWidgetState createState() => _ViewedRecentlyWidgetState();
}

class _ViewedRecentlyWidgetState extends State<ViewedRecentlyWidget> {
  @override
  Widget build(BuildContext context) {
    final viewedProd = Provider.of<ViewedProd>(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final product = productProvider.getProdById(viewedProd.productId);
    bool isInCart = cartProvider.isItemInCart(product.id!);
    double price = product.isOnSale ? product.salePrice : product.price;

    Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:  GestureDetector(
        onTap: ()=> Navigator.of(context).pushNamed(ProductDetails.routeName, arguments: product),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FancyShimmerImage(
                imageUrl: product.image,
                boxFit: BoxFit.fill,
                height: size.width * 0.27,
                width: size.width * 0.25,
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                children: [
                  TextWidget(
                    text: product.name,
                    color: color,
                    textSize: 24,
                    isTitle: true,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextWidget(
                    text: '\$${price.toStringAsFixed(2)}',
                    color: color,
                    textSize: 20,
                    isTitle: false,
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Material(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.green,
                  child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: isInCart ? null : (){
                        final User? user = authInstance.currentUser;
                        if(user == null){
                          GlobalMethods.errorDialog(subtitle: 'Please login first.', context: context);
                          return;
                        }
                        cartProvider.addProductsToCart(productId: product.id!, quantity: 1);},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          isInCart ? Icons.check : IconlyBold.plus,
                          color: Colors.white,
                          size: 20,
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      
    );
  }
}
