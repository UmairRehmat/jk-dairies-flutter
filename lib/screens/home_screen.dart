import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jkdairies/providers/Products_provider.dart';
import 'package:jkdairies/screens/productDetails.dart';
import 'package:jkdairies/utils/constants.dart';
import 'package:jkdairies/utils/transition_animation.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _contrller = ScrollController();
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);

    return Container(
      color: kBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, right: 12.0, left: 12.0),
        child: Column(
          children: [
            Expanded(flex: 2, child: topBanner()),
            Expanded(
                flex: 8,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    getHorizontalList(_contrller, productsProvider),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: productsProvider
                                .products[productsProvider.selectedIndex]
                                .products
                                .length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, index) {
                              var item = productsProvider
                                  .products[productsProvider.selectedIndex]
                                  .products[index];
                              int itemPrice = double.parse(item.price).round();
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      TransitionEffect(
                                          widget: ProductDetailScreen(),
                                          alignment: Alignment.centerLeft));
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 15, bottom: 10),
                                  decoration: new BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xFF2D51DB),
                                          Color(0xFF1A3083),
                                        ],
                                      ),
                                      borderRadius: new BorderRadius.all(
                                          Radius.circular(20.0))),
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Image(
                                          image: AssetImage(
                                              'assets/temp_trans.png'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        item.name,
                                        style: kCardNameTextStyle,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          style: kNormalCardTextStyle,
                                          children: [
                                            TextSpan(
                                              text: 'Rs. $itemPrice',
                                            ),
                                            TextSpan(
                                                text: '/${item.unit}',
                                                style: kNormalCardTextStyle
                                                    .copyWith(fontSize: 8))
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget topBanner() {
    return Image.asset('assets/banner.png');
    // return Container(
    //     decoration: BoxDecoration(
    //   gradient: LinearGradient(
    //     begin: Alignment.topRight,
    //     end: Alignment.bottomLeft,
    //     colors: [
    //       Color(0xFFB4E2F9),
    //       Color(0xFF4098B8),
    //     ],
    //   ),
    // ));
  }

  Widget getHorizontalList(
      ScrollController contrller, ProductsProvider productsProvider) {
    return Container(
      height: 40, // I just set these values
      child: ListView.builder(
          controller: contrller,
          scrollDirection: Axis.horizontal,
          itemCount: productsProvider.products.length,
          itemBuilder: (context, i) {
            var item = productsProvider.products[i];
            return productsProvider.selectedIndex == i
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(
                      vertical: 10, // Space between underline and text
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: kPrimaryColor,
                      width: 3.0, // Underline thickness
                    ))),
                    child: Text(
                      item.name,
                      style: kNormalBoldTextStyle,
                    ),
                  )
                : InkWell(
                    onTap: () {
                      _onItemPressed(productsProvider, i);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Center(
                        child: Text(
                          item.name,
                          style: kNormalTextStyle,
                        ),
                      ),
                    ),
                  );
          }),
    );
  }

  void _onItemPressed(ProductsProvider productsProvider, int index) {
    productsProvider.selectedIndex = index;
    setState(() {});
  }
}