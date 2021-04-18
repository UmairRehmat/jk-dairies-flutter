import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const userToken = "userToken";
const kAppbarTextStyleLogged =
    TextStyle(fontSize: 26.0, fontWeight: FontWeight.w700, color: Colors.white);
const kMediumTextStyle = TextStyle(fontSize: 18.0, color: Colors.black);
const kMediumBoldTextStyle =
    TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w700);
const kNormalTextStyle = TextStyle(fontSize: 16.0, color: Colors.black);
const kNormalTextStylePrimaryColor =
    TextStyle(fontSize: 14.0, color: kPrimaryColor);
const kAppBarTextStyle = TextStyle(fontSize: 22.0, color: Colors.black);
const kNormalBoldTextStyle = TextStyle(
    fontSize: 16.0, color: kPrimaryColor, fontWeight: FontWeight.bold);
enum DeliveryConstants { NewAssigned, Accepted, Rejected, PickedUp, Delivered }
const kCardNameTextStyle = TextStyle(
    fontSize: 18.0,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5);
const kNormalCardTextStyle =
    TextStyle(fontSize: 14.0, color: Colors.white, letterSpacing: 1.5);
const kDescriptionText =
    TextStyle(fontSize: 14.0, color: Color(0xFFB1AFAF), letterSpacing: 1.5);
const Color kSecondaryColor = Colors.indigo;
const Color kPrimaryColor = Color(0xFF2D51DB);
const Color kBackgroundColor = Color(0XFFF5F5F7);
const Color kTempBackgroundColor = Color(0XFFbebcbf);
const Color kItemDetailTopColor = Color(0XFFECEFFE);
