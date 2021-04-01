import 'package:flutter/material.dart';
import 'package:jkdairies/utils/constants.dart';
import 'package:intl/intl.dart';

class ProductDetailScreen extends StatefulWidget {
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int deliverySchedule = 0;
  String currentTime = '';
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
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            color: kItemDetailTopColor,
            child: Center(
              child: Image.asset(
                'assets/temp_trans.png',
                height: MediaQuery.of(context).size.height * 0.22,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: ListView(
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
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void onScheduleSelection(int i) {
    setState(() {
      deliverySchedule = i;
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
              width: 20,
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
