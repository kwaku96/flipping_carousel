import 'dart:math';
import 'dart:ui';

import 'package:flipping_carousel/card_data.dart';
import 'package:flipping_carousel/components/CarouselCard.dart';
import 'package:flutter/material.dart';

class CardFlipper extends StatefulWidget {
  final List<CardViewModel> cards;
  final Function(double scrollPercent) onScroll;

  CardFlipper({this.cards,this.onScroll});

  @override
  _CardFlipperState createState() => _CardFlipperState();
}

class _CardFlipperState extends State<CardFlipper> with TickerProviderStateMixin {

  double scrollPercent = 0.0;
  Offset startDrag;
  double startDragPercentScroll;
  double finishScrollStart;
  double finishScrollEnd;

  AnimationController finishScrollController;

  @override
  void initState() {
    super.initState();
    finishScrollController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150)
    )
    ..addListener((){
      setState(() {
        scrollPercent = lerpDouble(
          finishScrollStart, finishScrollEnd, finishScrollController.value
        );

        if(widget.onScroll != null){
          widget.onScroll(scrollPercent);
        }
      });
    })
    ;
  }

  @override
  void dispose() {
    super.dispose();
    finishScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onHorizontalDragStart,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: _buildCards(),
      ),
    );
  }

  List<Widget> _buildCards(){
    int index = -1;
    return widget.cards.map((cardViewModel){
      ++index;
      return _buildCard(cardViewModel,index,widget.cards.length,scrollPercent);
    }).toList();
  }

  Widget _buildCard(CardViewModel viewModel,int cardIndex,int cardCount,double scrollPercent){

    final cardScrollPercent = scrollPercent/(1/cardCount);
    final parallax = scrollPercent - (cardIndex/cardCount);

    return FractionalTranslation(
      translation: Offset(cardIndex-cardScrollPercent,0.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Transform(
          transform: _buildCardProjection(cardScrollPercent-cardIndex),
          child: CarouselCard(
            viewModel: viewModel,
            parallaxPercent:parallax
          ),
        ),
      )
    );
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    startDrag = details.globalPosition;
    startDragPercentScroll = scrollPercent;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final currDrag = details.globalPosition;
    final dragDistance = currDrag.dx - startDrag.dx;
    final singleCardDragPercent = dragDistance/context.size.width;

    setState(() {
      scrollPercent = (
        startDragPercentScroll + (-singleCardDragPercent/3)).clamp(0.0, 1.0-(1/widget.cards.length)
      );

      if(widget.onScroll != null){
        widget.onScroll(scrollPercent);
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final numCards = widget.cards.length;

    finishScrollStart = scrollPercent;
    finishScrollEnd = (scrollPercent * numCards).round()/numCards;

    finishScrollController.forward(from: 0.0);

    setState(() {
      startDrag = null;
      startDragPercentScroll = null;
    });
  }

  _buildCardProjection(double scrollPercent) {
    final perspective = 0.002;
    final radius = 1.0;
    final angle = scrollPercent * pi / 8;
    final horizontalTranslation = 0.0;
    Matrix4 projection = new Matrix4.identity()
      ..setEntry(0, 0, 1 / radius)
      ..setEntry(1, 1, 1 / radius)
      ..setEntry(3, 2, -perspective)
      ..setEntry(2, 3, -radius)
      ..setEntry(3, 3, perspective * radius + 1.0);

    // Model matrix by first translating the object from the origin of the world
    // by radius in the z axis and then rotating against the world.
    final rotationPointMultiplier = angle > 0.0 ? angle / angle.abs() : 1.0;
    print('Angle: $angle');
    projection *= new Matrix4.translationValues(
        horizontalTranslation + (rotationPointMultiplier * 300.0), 0.0, 0.0) *
        new Matrix4.rotationY(angle) *
        new Matrix4.translationValues(0.0, 0.0, radius) *
        new Matrix4.translationValues(-rotationPointMultiplier * 300.0, 0.0, 0.0);

    return projection;
  }
}
