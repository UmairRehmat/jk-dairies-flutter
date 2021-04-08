import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jkdairies/models/districts_response.dart';
import 'package:jkdairies/providers/cart_provider.dart';
import 'package:jkdairies/providers/checkout_provider.dart';
import 'package:jkdairies/providers/district_provider.dart';
import 'package:jkdairies/screens/order_complete.dart';
import 'package:jkdairies/utils/app_widgets.dart';
import 'package:jkdairies/utils/constants.dart';
import 'package:jkdairies/utils/transition_animation.dart';
import 'package:provider/provider.dart';

class CheckOutScreen extends StatefulWidget {
  int totalPrice;
  CheckOutScreen(this.totalPrice);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final _userNameController = TextEditingController();
  String _userNameInvalid;
  final _phoneNumberController = TextEditingController();
  String _phoneNumberInvalid;
  final _addressController = TextEditingController();
  String _addressInvalid;
  bool loading = true;
  List<DistrictItem> districts;
  DistrictItem currentDistrict;
  Cities currentCities;
  @override
  void initState() {
    super.initState();
    getDistrictsData();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: kItemDetailTopColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.14,
              color: kItemDetailTopColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Checkout",
                    style: kAppBarTextStyle,
                  ),
                ),
              )),
          loading
              ? Expanded(
                  child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        currentDistrict != null
                            ? "Placing Order..."
                            : "Loading available areas...",
                        style: kNormalTextStyle,
                      ),
                    ],
                  ),
                ))
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        TextInput(
                          controller: _userNameController,
                          error: _userNameInvalid,
                          onChange: (text) {
                            setState(() {
                              _userNameInvalid = null;
                            });
                          },
                          label: "Name",
                          hint: "Name",
                          icon: Icons.person,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextInput(
                          controller: _phoneNumberController,
                          error: _phoneNumberInvalid,
                          onChange: (text) {
                            setState(() {
                              _phoneNumberInvalid = null;
                            });
                          },
                          inputType: TextInputType.number,
                          label: "Phone Number",
                          hint: "Phone Number",
                          icon: Icons.phone,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextInput(
                          controller: _addressController,
                          error: _addressInvalid,
                          onChange: (text) {
                            setState(() {
                              _addressInvalid = null;
                            });
                          },
                          label: "Delivery Address",
                          hint: "Delivery Address",
                          icon: Icons.location_on,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: SelectionItem(
                                    text: DropdownButtonHideUnderline(
                                      child: DropdownButton<DistrictItem>(
                                        hint: Text("Select District"),
                                        value: currentDistrict,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 15),
                                        onChanged: (DistrictItem Value) {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          setState(() {
                                            print("district here");
                                            currentDistrict = Value;
                                          });
                                        },
                                        items:
                                            districts.map((DistrictItem user) {
                                          return DropdownMenuItem<DistrictItem>(
                                            value: user,
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  user.name,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    isSelected: currentDistrict != null),
                              ),
                            ),
                            SizedBox(width: 20),
                            if (currentDistrict != null)
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: SelectionItem(
                                      text: DropdownButtonHideUnderline(
                                        child: DropdownButton<Cities>(
                                          hint: Text("Select City"),
                                          value: currentCities,
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 15),
                                          onChanged: (Cities Value) {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            setState(() {
                                              print("district here");
                                              currentCities = Value;
                                            });
                                          },
                                          items: currentDistrict.cities
                                              .map((Cities user) {
                                            return DropdownMenuItem<Cities>(
                                              value: user,
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    user.name,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      isSelected: currentCities != null),
                                ),
                              )
                          ],
                        ),
                        divider(
                          color: Colors.black45,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total - ",
                              style: kNormalTextStyle,
                            ),
                            Text(
                              "Rs. ${widget.totalPrice}",
                              style: kNormalTextStyle,
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _orderNowClicked(cartProvider);
                          },
                          style: ElevatedButton.styleFrom(
                              textStyle: kNormalCardTextStyle,
                              primary: kPrimaryColor,
                              padding: EdgeInsets.all(16),
                              onPrimary: Colors.white),
                          child: Text("Order Now"),
                        )
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }

  void getDistrictsData() async {
    List<DistrictItem> districtsList = await DistrictProvider().getDistricts();
    setState(() {
      loading = false;
      districts = districtsList;
    });
  }

  void _orderNowClicked(CartProvider cartProvider) {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_userNameController.text.trim().isEmpty) {
      setState(() {
        _userNameInvalid = "Enter Name";
      });
      return;
    }
    if (_userNameController.text.trim().length < 4) {
      setState(() {
        _userNameInvalid = "Enter valid UserName";
      });

      return;
    }
    if (_phoneNumberController.text.trim().isEmpty) {
      setState(() {
        _phoneNumberInvalid = "Enter phone number";
      });
      return;
    }
    if (_phoneNumberController.text.trim().length != 11 ||
        !_phoneNumberController.text.startsWith("03")) {
      setState(() {
        _phoneNumberInvalid = "Enter valid Number 03XXXXXXXXX";
      });
      return;
    }
    if (_addressController.text.trim().isEmpty) {
      setState(() {
        _addressInvalid = "Enter Address";
      });
      return;
    }
    if (currentCities == null || currentDistrict == null) {
      showIncompleteInformation(
          context, "Please Select district and city properly, thanks.");
      return;
    }
    _placeOrder(cartProvider);
  }

  void showIncompleteInformation(BuildContext context, String text,
      {String titleString = 'Incomplete Information'}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(titleString),
        content: Text(text),
        actions: <Widget>[
          FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Dismiss',
                style: kNormalTextStylePrimaryColor,
              ))
        ],
      ),
    );
  }

  void _placeOrder(CartProvider cartProvider) async {
    setState(() {
      loading = true;
    });
    var apiData = {
      "total_price": widget.totalPrice,
      "name": _userNameController.text.trim(),
      "phone": _phoneNumberController.text.trim(),
      "address": _addressController.text.trim(),
      "district_id": currentDistrict.id,
      "city_id": currentCities.id,
      "orderitems":
          json.encode(cartProvider.cartItems.map((e) => e.toJson()).toList()),
    };
    print("place order api data");
    print(apiData);
    bool orderPlaced = await CheckoutProvider().placeOrder(apiData);
    if (orderPlaced) {
      cartProvider.cartItems = [];
      Navigator.pushReplacement(
        context,
        TransitionEffect(
          widget: OrderCompleted(),
          alignment: Alignment.center,
        ),
      );
    } else {
      setState(() {
        loading = false;
        showIncompleteInformation(context, "Something Went Wrong",
            titleString: "Error");
      });
    }
  }
}
