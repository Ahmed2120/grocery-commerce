import 'package:flutter/cupertino.dart';

import '../model/cart.dart';

class CartProvider with ChangeNotifier {
  Map<String, Cart> _cartItems = {};

  List<Cart> get getCartItems {
    return _cartItems.values.toList();
  }

  void addProductsToCart({
    required int productId,
    required int quantity,
  }) {
    _cartItems.putIfAbsent(
        productId.toString(),
        () => Cart(
              productId: productId,
              quantity: quantity,
            ));
    notifyListeners();
  }

  void reduceQuantityByOne(int productId) {
    _cartItems.update("$productId",
        (value) => Cart(productId: productId, quantity: value.quantity - 1));
    notifyListeners();
  }

  void increaseQuantityByOne(int productId) {
    _cartItems.update("$productId",
        (value) => Cart(productId: productId, quantity: value.quantity + 1));
    notifyListeners();
  }

  void removeItem(int productId) {
    _cartItems.remove("$productId");
    notifyListeners();
  }

  void removeAllItems() {
    _cartItems.clear();
    notifyListeners();
  }

  bool isItemInCart(int productId){
    return _cartItems.containsKey(productId.toString());
  }
}
