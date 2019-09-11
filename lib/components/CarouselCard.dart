import 'package:flipping_carousel/card_data.dart';
import 'package:flutter/material.dart';

class CarouselCard extends StatelessWidget {

  final CardViewModel viewModel;
  final double parallaxPercent;

  CarouselCard({this.viewModel,this.parallaxPercent});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: FractionalTranslation(
            translation: Offset(parallaxPercent*2,0.0),
            child: OverflowBox(
              maxWidth: double.infinity,
              child: Image.asset(
                viewModel.backdropAssetPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:30.0,left:20.0,right: 20.0),
              child: Text(
                '${viewModel.address}'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontFamily: 'petita',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0
                ),
              ),
            ),
            Expanded(child: Container(),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${viewModel.minHeightInFeet} - ${viewModel.maxHeightInFeet}'.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 140.0,
                      fontFamily: 'petita',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:30.0,left: 10.0),
                  child: Text(
                    'Ft'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontFamily: 'petita',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.wb_sunny,color: Colors.white,),
                Padding(
                  padding: const EdgeInsets.only(left:10.0),
                  child: Text(
                    '${viewModel.tempInDegrees}°'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontFamily: 'petita',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0
                    ),
                  ),
                ),
              ],
            ),
            Expanded(child: Container(),),
            Padding(
              padding: const EdgeInsets.only(top:50,bottom: 50.0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(color: Colors.white,width: 1.5)
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${viewModel.weatherType}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: 'petita',
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10,right: 10.0),
                      child: Icon(Icons.wb_cloudy,color: Colors.white,),
                    ),
                    Text(
                      '${viewModel.windSpeedInMph}mph ${viewModel.cardinalDirection}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontFamily: 'petita',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
