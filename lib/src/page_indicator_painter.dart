import 'package:flutter/material.dart';

class PageIndicatorPainter extends CustomPainter {
  PageIndicatorPainter({
    required this.pageCount,
    required this.dotRadius,
    required this.dotOutlineThickness,
    required this.spacing,
    this.scrollPosition = 0.0,
    required Color dotFillColor,
    required Color dotOutlineColor,
    required Color indicatorColor,
  })  : dotFillPaint = Paint()..color = dotFillColor,
        dotOutlinePaint = Paint()..color = dotOutlineColor,
        indicatorPaint = Paint()..color = indicatorColor,
        assert(pageCount > 1),
        assert(scrollPosition >= 0.0),
        assert(scrollPosition <= (1.0 * pageCount));

  final int pageCount;
  final double dotRadius;
  final double dotOutlineThickness;
  final double spacing;
  final double scrollPosition;
  final Paint dotFillPaint;
  final Paint dotOutlinePaint;
  final Paint indicatorPaint;

  @override
  void paint(Canvas canvas, Size size) {
    // Center point for all calculations
    final Offset center = size.center(Offset.zero);

    // Total width of all points and spaces between them
    final double totalWidth =
        (pageCount * (2 * dotRadius)) + ((pageCount - 1) * spacing);

    _drawDots(canvas, center, totalWidth);

    _drawPageIndicator(canvas, center, totalWidth);
  }

  void _drawPageIndicator(Canvas canvas, Offset center, double totalWidth) {
    final int pageIndexToLeft = scrollPosition.floor();
    final double leftDotX = (center.dx - (totalWidth / 2)) +
        (pageIndexToLeft * ((dotRadius * 2) + spacing));
    final double transitionPercent = scrollPosition - pageIndexToLeft;

    final double indicatorLeftX =
        leftDotX + (transitionPercent * ((dotRadius * 2) + spacing));

    final double indicatorRightX = indicatorLeftX + (dotRadius * 2);

    canvas.drawRRect(
      RRect.fromLTRBR(
        indicatorLeftX,
        -dotRadius,
        indicatorRightX,
        dotRadius,
        Radius.circular(dotRadius),
      ),
      indicatorPaint,
    );
  }

  void _drawDots(Canvas canvas, Offset center, double totalWidth) {
    // Center of the point to be drawn
    Offset dotCenter = center.translate((-totalWidth / 2) + dotRadius, 0);

    for (int i = 0; i < pageCount; i++) {
      _drawDot(canvas, dotCenter);

      // Adding offset points
      dotCenter = dotCenter.translate((dotRadius * 2) + spacing, 0);
    }
  }

  void _drawDot(Canvas canvas, Offset dotCenter) {
    canvas.drawCircle(
      dotCenter,
      dotRadius - dotOutlineThickness,
      dotFillPaint,
    );

    final Path outlinePath = Path()
      ..addOval(Rect.fromCircle(
        center: dotCenter,
        radius: dotRadius,
      ))
      ..addOval(Rect.fromCircle(
        center: dotCenter,
        radius: dotRadius - dotOutlineThickness,
      ))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(outlinePath, dotOutlinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
