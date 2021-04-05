import 'package:flutter/material.dart';
import 'package:jkdairies/providers/cart_provider.dart';
import 'package:jkdairies/utils/constants.dart';
import 'package:provider/provider.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
      color: kBackgroundColor,
      child: Center(
        child: Text("Cart ${cartProvider.cartItems.length}"),
      ),
    );
  }
}
