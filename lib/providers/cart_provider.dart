import 'package:flutter/foundation.dart';
import 'package:jkdairies/models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> cartItems = [];

  int existedItemIndex(int id) {
    int i = -1;
    if (cartItems.length == 0) return i;
    for (int j = 0; j < cartItems.length; j++) {
      if (cartItems[j].productId == id) i = j;
    }
    return i;
  }
}
