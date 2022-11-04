import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../provider/wishlist_provider.dart';
import '../services/utils.dart';

class HeartBTN extends StatelessWidget {
  const HeartBTN({Key? key, required this.productId}) : super(key: key);
  final int productId;

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool isInWishlist = wishlistProvider.isItemInWishlist(productId);

    final Color color = Utils(context).color;
    return GestureDetector(
      onTap: () {
        wishlistProvider.toggleProductToWishlist(productId: productId);
      },
      child: Icon(
        isInWishlist ? IconlyBold.heart : IconlyLight.heart,
        size: 22,
        color: isInWishlist ? Colors.red : color,
      ),
    );
  }
}
