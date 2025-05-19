import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              cartProvider.clearCart();
            },
          ),
        ],
      ),
      body: cartProvider.items.isEmpty
          ? const Center(child: Text('Your cart is empty!'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.items.length,
                    itemBuilder: (context, index) {
                      final cartItem =
                          cartProvider.items.values.toList()[index];
                      return ListTile(
                        title: Text(cartItem.title),
                        subtitle:
                            Text('\$${cartItem.price} x ${cartItem.quantity}'),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Total Price: \$${cartProvider.totalPrice}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
    );
  }
}
