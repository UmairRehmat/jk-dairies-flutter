import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jkdairies/providers/Products_provider.dart';
import 'package:jkdairies/providers/cart_provider.dart';
import 'package:jkdairies/screens/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ProductsProvider()),
    ChangeNotifierProvider(create: (_) => CartProvider())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JK Dairies',
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            labelStyle: TextStyle(color: Colors.black),
            suffixStyle: TextStyle(color: Colors.black)),
        fontFamily: 'Nunito',
        textTheme: TextTheme(
          button: TextStyle(fontSize: 20.0, color: Colors.black),
        ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
      ),
      home: Splash(),
    );
  }
}
