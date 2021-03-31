import 'package:flutter/material.dart';
import 'package:jkdairies/utils/constants.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Center(
        child: Text("Contact Us"),
      ),
    );
  }
}
