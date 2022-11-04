import 'package:flutter/cupertino.dart';

import '../model/wishlist.dart';

class WishlistProvider with ChangeNotifier {
  Map<String, Wishlist> _wishlistItems = {};

  List<Wishlist> get getWishlistItems {
    return _wishlistItems.values.toList();
  }

  void toggleProductToWishlist({
    required int productId,
  }) {
    if(isItemInWishlist(productId)) {
     removeItem(productId);
    }else{
      _wishlistItems.putIfAbsent(productId.toString(), () => Wishlist(productId: productId));
    }
    notifyListeners();
  }

  void removeItem(int productId) {
    _wishlistItems.remove("$productId");
    notifyListeners();
  }

  void removeAllItems() {
    _wishlistItems.clear();
    notifyListeners();
  }

  bool isItemInWishlist(int productId){
    return _wishlistItems.containsKey(productId.toString());
  }
}
