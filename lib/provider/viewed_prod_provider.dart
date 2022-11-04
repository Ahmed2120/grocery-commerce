import 'package:flutter/cupertino.dart';

import '../model/viwed_prod.dart';
import '../model/wishlist.dart';

class ViewedProdProvider with ChangeNotifier {
  Map<String, ViewedProd> _viewedItems = {};

  List<ViewedProd> get getWishlistItems {
    return _viewedItems.values.toList();
  }

  void addProductToHistory({
    required int productId,
  }) {
      _viewedItems.putIfAbsent(productId.toString(), () => ViewedProd(productId: productId));
    notifyListeners();
  }

  void removeItem(int productId) {
    _viewedItems.remove("$productId");
    notifyListeners();
  }

  void removeAllItems() {
    _viewedItems.clear();
    notifyListeners();
  }

  bool isItemInHistory(int productId){
    return _viewedItems.containsKey(productId.toString());
  }
}
