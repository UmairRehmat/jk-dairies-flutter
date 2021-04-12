import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jkdairies/models/CategoryModel.dart';
import 'package:jkdairies/models/bannerResponse.dart';
import 'package:jkdairies/providers/Products_provider.dart';
import 'package:jkdairies/screens/bottom_navigation.dart';
import 'package:jkdairies/utils/constants.dart';
import 'package:jkdairies/utils/transition_animation.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  Animation animation;
  Animation textAnimation;
  AnimationController animationController;
  bool first = true;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn),
    );
    textAnimation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn),
    );
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ProductsProvider>(context);
    if (first) {
      first = false;
      moveToNextScreen(_provider);
    }
    final double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
            backgroundColor: kBackgroundColor,
            body: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform(
                      transform: Matrix4.translationValues(
                          textAnimation.value * height, 0.0, 0.0),
                      child: Center(
                        child: Image(
                          height: 220,
                          width: 220,
                          image: AssetImage('assets/logo_main.png'),
                        ),
                      ),
                    ),
                    Transform(
                      transform: Matrix4.translationValues(
                          animation.value * height, 0.0, 0.0),
                      child: Center(
                          child: Text(
                        "JK Dairies",
                        style: kMediumBoldTextStyle.copyWith(
                            letterSpacing: 2.0, color: kPrimaryColor),
                      )),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  void moveToNextScreen(ProductsProvider provider) async {
    loadBanners(provider);
    Future.delayed(const Duration(milliseconds: 2000), () async {
      CategoryModel categoryModel = await provider.getProducts();
      if (categoryModel.success)
        Navigator.pushAndRemoveUntil(
            context,
            TransitionEffect(
                widget: BottomNavigation(),
                alignment: Alignment.centerLeft,
                durationAnimation: 650),
            (route) => false);
    });
  }

  void loadBanners(ProductsProvider provider) async {
    BannerResponse bannerResponse = await provider.getBanners();
  }
}
