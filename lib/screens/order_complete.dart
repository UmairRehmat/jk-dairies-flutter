import 'package:flutter/material.dart';
import 'package:jkdairies/utils/constants.dart';

class OrderCompleted extends StatefulWidget {
  @override
  _OrderCompletedState createState() => _OrderCompletedState();
}

class _OrderCompletedState extends State<OrderCompleted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kBackgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/order-confirm.png')),
              SizedBox(
                height: 30,
              ),
              Text(
                "Thank you! Order Confirmed",
                style: kMediumBoldTextStyle,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Text(
                  "Your Order has been placed our team will call you for confirmation ",
                  style: kNormalTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                child: ElevatedButton(
                  onPressed: _onOkClicked,
                  style: ElevatedButton.styleFrom(
                      textStyle: kNormalCardTextStyle,
                      primary: kPrimaryColor,
                      padding: EdgeInsets.all(16),
                      onPrimary: Colors.white),
                  child: Text("OK"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onOkClicked() {
    Navigator.pop(context);
  }
}
