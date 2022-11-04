import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../../inner_screens/product_details.dart';
import '../../model/wishlist.dart';
import '../../provider/cart_provider.dart';
import '../../provider/products_provider.dart';
import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgits/heart_btn.dart';
import '../../widgits/text_widget.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final wishlist = Provider.of<Wishlist>(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final product = productProvider.getProdById(wishlist.productId);
    bool isInCart = cartProvider.isItemInCart(product.id!);
    double price = product.isOnSale ? product.salePrice : product.price;


    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: ()=> Navigator.of(context).pushNamed(ProductDetails.routeName, arguments: product),
        child: Container(
          height: size.height * 0.20,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(color: color, width: 1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  height: size.width * 0.25,
                  child: FancyShimmerImage(
                    imageUrl: product.image,
                    boxFit: BoxFit.fill,
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: isInCart ? null : () => cartProvider.addProductsToCart(productId: product.id!, quantity: 1),
                          icon: Icon(
                            isInCart ? IconlyBold.bag2 : IconlyLight.bag2,
                            color: isInCart ? Colors.green : color,
                          ),
                        ),
                        HeartBTN(productId: product.id!,),
                      ],
                    ),
                    TextWidget(
                      text: product.name,
                      color: color,
                      textSize: 20.0,
                      maxLines: 2,
                      isTitle: true,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextWidget(
                      text: '\$${price.toStringAsFixed(2)}',
                      color: color,
                      textSize: 18.0,
                      maxLines: 1,
                      isTitle: true,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
