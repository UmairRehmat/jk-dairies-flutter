import 'package:flutter/material.dart';
import 'package:jkdairies/models/cart_item.dart';
import 'package:jkdairies/providers/cart_provider.dart';
import 'package:jkdairies/screens/checkout_screen.dart';
import 'package:jkdairies/utils/constants.dart';
import 'package:jkdairies/utils/transition_animation.dart';
import 'package:provider/provider.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  var totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    totalPrice = 0;
    cartProvider.cartItems.forEach((element) {
      totalPrice = totalPrice + (element.price * element.quantity);
    });
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        child: cartProvider.cartItems.length > 0
            ? ListView(
                shrinkWrap: true,
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cartProvider.cartItems.length,
                    itemBuilder: (context, index) {
                      CartItem currentItem = cartProvider.cartItems[index];
                      return cartItemRender(currentItem, cartProvider, index);
                    },
                  ),
                  SizedBox(
                    height: cartProvider.cartItems.length < 4 ? 42 : 22,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          TransitionEffect(
                            widget: CheckOutScreen(totalPrice),
                            alignment: Alignment.center,
                          ),
                        ).then((value) {
                          setState(() {});
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          textStyle: kNormalCardTextStyle,
                          primary: kPrimaryColor,
                          padding: EdgeInsets.all(16),
                          onPrimary: Colors.white),
                      child: Text("Proceed to checkout(Rs.$totalPrice)"),
                    ),
                  )
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('assets/no_cart_item.png')),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "No Item in the Cart",
                      style: kMediumBoldTextStyle,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Text(
                        "Please Select items from home and add into cart and came back to proceed",
                        style: kNormalTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Container cartItemRender(
      CartItem currentItem, CartProvider cartProvider, int index) {
    return Container(
        margin: EdgeInsets.only(left: 12, right: 12, top: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(3, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Image(
                  height: 110,
                  fit: BoxFit.cover,
                  image: NetworkImage(currentItem.item.picture),
                  // AssetImage(
                  //     'assets/temp_trans.png'),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: SizedBox(
                  child: Container(
                    height: 110,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentItem.item.name,
                          overflow: TextOverflow.ellipsis,
                          style: kMediumBoldTextStyle.copyWith(
                              fontSize: 20, color: Colors.black),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Text(
                          'Time - ${currentItem.deliveryTime}',
                          style: kNormalTextStyle.copyWith(
                              color: Colors.grey.shade500),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        if (currentItem.type == 0)
                          Text(
                            'Data: ${currentItem.startDate}',
                            style: kNormalTextStyle,
                          ),
                        if (currentItem.type > 0)
                          Text(
                            'From: ${currentItem.startDate}',
                            style: kNormalTextStyle,
                          ),
                        if (currentItem.type > 0)
                          Text(
                            'To:     ${currentItem.endDate}',
                            style: kNormalTextStyle,
                          ),
                      ],
                    ),
                  ),
                ),
                flex: 6,
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if (currentItem.quantity == 1) return;
                              _decreaseQuantity(cartProvider, index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "-",
                                style: kMediumBoldTextStyle,
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: new BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius:
                                    new BorderRadius.all(Radius.circular(4.0))),
                            child: Center(
                              child: Text(
                                currentItem.quantity.toString(),
                                style: kNormalTextStyle,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _increaseQuantity(cartProvider, index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "+",
                                style: kMediumBoldTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Rs: ${currentItem.price * currentItem.quantity}',
                        style: kNormalTextStyle,
                      ),
                    ],
                  ),
                ),
                flex: 3,
              )
            ],
          ),
        ));
  }

  void _increaseQuantity(CartProvider provider, int index) {
    totalPrice = 0;
    setState(() {
      provider.cartItems[index].quantity++;
    });
  }

  void _decreaseQuantity(CartProvider provider, int index) {
    totalPrice = 0;
    setState(() {
      provider.cartItems[index].quantity--;
    });
  }
}
