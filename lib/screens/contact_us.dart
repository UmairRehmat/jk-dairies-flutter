import 'package:flutter/material.dart';
import 'package:jkdairies/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  double _size = 50.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/contact-us.png')),
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              child: Text(
                "Get Touch if you need help or query",
                style: kMediumBoldTextStyle,
                textAlign: TextAlign.center,
              ),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: _onCallClick,
                    child: Image.asset(
                      'assets/phone-call.png',
                      height: _size,
                      width: _size,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.07,
                  ),
                  InkWell(
                    onTap: _onFaceBookClik,
                    child: Image.asset(
                      'assets/facebook-logo.png',
                      height: _size,
                      width: _size,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.07,
                  ),
                  InkWell(
                    onTap: _onWhatsappClick,
                    child: Image.asset(
                      'assets/whatsapp.png',
                      height: _size,
                      width: _size,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onCallClick() async {
    launch("tel:03007860278");
  }

  void _onWhatsappClick() async {
    await launch("https://wa.me/923126039558?text=Hello");
  }

  void _onFaceBookClik() async {
    await launch(
        "fb://facewebmodal/f?href=https://www.facebook.com/CheeziousPattoki",
        universalLinksOnly: true);
  }
}
