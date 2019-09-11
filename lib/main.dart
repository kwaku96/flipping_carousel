import 'package:flipping_carousel/card_data.dart';
import 'package:flipping_carousel/components/CardFlipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/BottomBar.dart';
import 'components/CarouselCard.dart';

void main(){
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carousel',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double scrollPercent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(height: 20.0),
          Expanded(
            child: CardFlipper(
              cards:demoCards,
              onScroll: (double scrollPercent){
                setState(() {
                  this.scrollPercent = scrollPercent;
                });
              }
            ),
          ),
          BottomBar(
            cardCount: demoCards.length,
            scrollPercent: scrollPercent,
          )
        ],
      ),
    );
  }
}
