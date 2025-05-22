import '../models/cart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items => _items;

  CartProvider() {
    loadCart();
  }

  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items[productId]!.quantity++;
    } else {
      _items[productId] = CartItem(id: productId, title: title, price: price);
    }
    notifyListeners();
    saveCart();
  }

  double get totalPrice => _items.values
      .fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  void clearCart() {
    _items.clear();
    notifyListeners();
    saveCart();
  }

  // Save cart to SharedPreferences
  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = _items.map((key, item) => MapEntry(key, {
          'id': item.id,
          'title': item.title,
          'price': item.price,
          'quantity': item.quantity,
        }));
    prefs.setString('cart', jsonEncode(cartData));
  }

  // Load cart from SharedPreferences
  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = prefs.getString('cart');
    if (cartString != null) {
      final Map<String, dynamic> decoded = jsonDecode(cartString);
      _items = decoded.map((key, value) => MapEntry(
          key,
          CartItem(
            id: value['id'],
            title: value['title'],
            price: value['price'],
            quantity: value['quantity'],
          )));
      notifyListeners();
    }
  }
}
