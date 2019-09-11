import 'package:flutter/material.dart';

class ScrollIndicator extends StatelessWidget {

  final int cardCount;
  final double scrollPercent;

  ScrollIndicator({this.scrollPercent,this.cardCount});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ScrollIndicatorPainter(
        cardCount: cardCount,
        scrollPercent: scrollPercent
      ),
    );
  }
}

class ScrollIndicatorPainter extends CustomPainter {

  final int cardCount;
  final double scrollPercent;
  final Paint trackPaint;
  final Paint thumbPaint;

  ScrollIndicatorPainter({
    this.scrollPercent,
    this.cardCount
  }): trackPaint = Paint()
    ..color = Color(0xFF444444)
    ..style = PaintingStyle.fill,
      thumbPaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill
  ;

  @override
  void paint(Canvas canvas, Size size) {
    var trackRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(0, 0, size.width, size.height),
      topLeft: Radius.circular(3.0),
      topRight: Radius.circular(3.0),
      bottomLeft: Radius.circular(3.0),
      bottomRight: Radius.circular(3.0)
    );
    canvas.drawRRect(trackRect, trackPaint);


    final thumbWidth = size.width/cardCount;
    final thumbLeft = scrollPercent * size.width;

    var thumbRect = RRect.fromRectAndCorners(
        Rect.fromLTWH(thumbLeft, 0, thumbWidth, size.height),
        topLeft: Radius.circular(3.0),
        topRight: Radius.circular(3.0),
        bottomLeft: Radius.circular(3.0),
        bottomRight: Radius.circular(3.0)
    );
    canvas.drawRRect(thumbRect, thumbPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}



