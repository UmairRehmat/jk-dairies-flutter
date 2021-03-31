import 'package:flutter/material.dart';
import 'package:jkdairies/utils/constants.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Center(
        child: Text("Cart"),
      ),
    );
  }
}
