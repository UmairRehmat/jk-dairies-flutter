import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jkdairies/models/CategoryModel.dart';
import 'package:jkdairies/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

class ProductDetailScreen extends StatefulWidget {
  Products item;
  int index;
  ProductDetailScreen(this.item, this.index);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ScrollController _controller = ScrollController();
  int deliverySchedule = 0;
  String currentTime = '';
  List<DateTime> rangeDate = [];
  var currentDate = (new DateTime.now()).add(Duration(days: 1));
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kItemDetailTopColor,
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
      bottomNavigationBar: BottomAppBar(
          color: kBackgroundColor,
          elevation: 0,
          child: Container(
            height: 70,
            // margin: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Color(0xFFECEFFE),
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0),
              ),
            ),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rs. 110x",
                    style: kMediumBoldTextStyle,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        textStyle: kNormalCardTextStyle,
                        primary: kPrimaryColor,
                        onPrimary: Colors.white),
                    onPressed: () {},
                    child: Text(
                      "Add To Cart",
                    ),
                  )
                ],
              ),
            )),
          )),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            color: kItemDetailTopColor,
            child: Center(
              child: Hero(
                tag: "MainImage${widget.index}",
                child: Image(
                  image: AssetImage('assets/temp_trans.png'),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding:
                  EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
              decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: ListView(
                controller: _controller,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Jk Milk",
                              style: kMediumBoldTextStyle,
                            ),
                            Text(
                              "Rs. 110x",
                              style: kMediumTextStyle,
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              iconSize: 20,
                              icon: Icon(
                                Icons.exposure_minus_1,
                                color: Colors.black,
                              ),
                              onPressed: null),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: new BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFF2D51DB),
                                    Color(0xFF1A3083),
                                  ],
                                ),
                                borderRadius:
                                    new BorderRadius.all(Radius.circular(5.0))),
                            child: Center(
                              child: Text(
                                "1",
                                style: kCardNameTextStyle,
                              ),
                            ),
                          ),
                          IconButton(
                              iconSize: 20,
                              icon: Icon(
                                Icons.plus_one,
                                color: Colors.black,
                              ),
                              onPressed: null)
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consetetur sipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata",
                    style: kDescriptionText,
                  ),
                  divider(),
                  Text(
                    "Choose Time",
                    style: kNormalBoldTextStyle.copyWith(color: Colors.black),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        showTimeDialog();
                      },
                      child: SelectionItem(
                        text: currentTime.length == 0 ? "10:00AM" : currentTime,
                        icon: Icons.watch_later,
                        isSelected: currentTime.length == 0 ? false : true,
                      ),
                    ),
                  ),
                  divider(),
                  Text(
                    "Delivery Schedule",
                    style: kNormalBoldTextStyle.copyWith(color: Colors.black),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          onScheduleSelection(0);
                        },
                        child: SelectionItem(
                          text: "One Time",
                          isSelected: deliverySchedule == 0 ? true : false,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          onScheduleSelection(1);
                        },
                        child: SelectionItem(
                          text: "Week",
                          isSelected: deliverySchedule == 1 ? true : false,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          onScheduleSelection(2);
                        },
                        child: SelectionItem(
                          text: "Month",
                          isSelected: deliverySchedule == 2 ? true : false,
                        ),
                      ),
                    ],
                  ),
                  if (deliverySchedule > 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 14,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Start Date",
                                    style: kNormalBoldTextStyle.copyWith(
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      dataRangePickerDialog();
                                    },
                                    child: SelectionItem(
                                      text: DateFormat("dd-MM-yyyy").format(
                                          rangeDate.length > 0
                                              ? rangeDate[0]
                                              : currentDate),
                                      icon: Icons.date_range,
                                      isSelected:
                                          rangeDate.length > 0 ? true : false,
                                    ),
                                  ),
                                ],
                              )),
                          Expanded(flex: 1, child: SizedBox()),
                          if (rangeDate.length > 0)
                            Expanded(
                                flex: 14,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "End Date",
                                      style: kNormalBoldTextStyle.copyWith(
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SelectionItem(
                                      text: DateFormat("dd-MM-yyyy").format(
                                          rangeDate.length > 0
                                              ? rangeDate[1]
                                              : currentDate),
                                      icon: Icons.date_range,
                                      isSelected:
                                          rangeDate.length > 0 ? true : false,
                                    ),
                                  ],
                                )),
                        ],
                      ),
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void onScheduleSelection(int i) async {
    setState(() {
      deliverySchedule = i;
      rangeDate = [];
    });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  void showTimeDialog() async {
    TimeOfDay selectedTime = await showTimePicker(
      initialTime: TimeOfDay(hour: 10, minute: 00),
      context: context,
    );
    print("time here");
    setState(() {
      currentTime = formatTimeOfDay(selectedTime);
    });
  }

  void dataRangePickerDialog() async {
    final List<DateTime> picked = await DateRangePicker.showDatePicker(
        context: context,
        initialFirstDate: currentDate,
        initialLastDate: (currentDate)
            .add(new Duration(days: deliverySchedule == 1 ? 7 : 30)),
        firstDate: new DateTime(2020),
        lastDate: new DateTime(DateTime.now().year + 2));
    if (picked != null && picked.length == 2) {
      print("these pickes");
      picked.removeAt(1);
      picked.add(
          (picked[0]).add(new Duration(days: deliverySchedule == 1 ? 7 : 30)));
      print(picked);
    }
    if (picked != null && picked.length == 1) {
      print("single selected");
      picked.add(
          (picked[0]).add(new Duration(days: deliverySchedule == 1 ? 7 : 30)));
      print(picked);
    }
    setState(() {
      rangeDate = picked;
    });
  }
}

String formatTimeOfDay(TimeOfDay tod) {
  final now = new DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  final format = DateFormat.jm(); //"6:00 AM"
  return format.format(dt);
}

class SelectionItem extends StatelessWidget {
  final text;
  final isSelected;
  final icon;

  const SelectionItem(
      {Key key, @required this.text, @required this.isSelected, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: new BoxDecoration(
          border: Border.all(
              width: 2, color: isSelected ? kPrimaryColor : Color(0xFFCDD1DE)),
          borderRadius: new BorderRadius.all(Radius.circular(10.0))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: kNormalTextStyle,
          ),
          if (icon != null)
            SizedBox(
              width: 15,
            ),
          if (icon != null)
            Icon(
              icon,
              color: isSelected ? kPrimaryColor : Color(0xFFCDD1DE),
            ),
        ],
      ),
    );
  }
}

class divider extends StatelessWidget {
  const divider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Container(
        height: 2,
        width: double.infinity,
        color: Color(0xFFD3D3D3),
      ),
    );
  }
}
