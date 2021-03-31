import 'package:flutter/material.dart';

class TransitionEffect extends PageRouteBuilder {
  final Widget widget;
  final Alignment alignment;
  final int durationAnimation;
  TransitionEffect(
      {this.durationAnimation = 450,
      this.widget,
      this.alignment = Alignment.topRight})
      : super(
            transitionDuration: Duration(milliseconds: durationAnimation),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.easeIn);
              return ScaleTransition(
                scale: animation,
                child: child,
                alignment: alignment,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimatio) {
              return widget;
            });
}
