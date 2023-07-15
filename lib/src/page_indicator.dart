import 'package:flutter/material.dart';
import 'package:page_indicator/src/page_indicator_painter.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.controller,
    required this.count,
    required this.dotRadius,
    required this.spacing,
    required this.dotOutlineThickness,
    required this.dotFillColor,
    required this.dotOutlineColor,
    required this.indicatorColor,
  });

  final PageController controller;
  final int count;
  final double dotRadius;
  final double spacing;
  final double dotOutlineThickness;
  final Color dotFillColor;
  final Color dotOutlineColor;
  final Color indicatorColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) => CustomPaint(
        painter: PageIndicatorPainter(
          pageCount: count,
          dotRadius: dotRadius,
          spacing: spacing,
          scrollPosition: controller.hasClients && controller.page != null
              ? controller.page ?? 0.0
              : 0.0,
          dotOutlineThickness: dotOutlineThickness,
          dotFillColor: dotFillColor,
          dotOutlineColor: dotOutlineColor,
          indicatorColor: indicatorColor,
        ),
      ),
    );
  }
}
