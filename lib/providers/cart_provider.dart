import '../models/cart.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items => _items;

  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items[productId]!.quantity++;
    } else {
      _items[productId] = CartItem(id: productId, title: title, price: price);
    }
    notifyListeners();
  }

  double get totalPrice => _items.values
      .fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
