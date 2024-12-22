import 'package:flutter/material.dart';

class VerticalDashedDivider extends StatelessWidget {
  final double height;
  final double dashHeight;
  final double dashWidth;
  final double spacing;
  final Color color;

  const VerticalDashedDivider({
    super.key,
    this.height = 100.0,
    this.dashHeight = 5.0,
    this.dashWidth = 2.0,
    this.spacing = 3.0,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _VerticalDashedDividerPainter(
          dashHeight: dashHeight,
          dashWidth: dashWidth,
          spacing: spacing,
          color: color,
        ),
      ),
    );
  }
}

class _VerticalDashedDividerPainter extends CustomPainter {
  final double dashHeight;
  final double dashWidth;
  final double spacing;
  final Color color;

  _VerticalDashedDividerPainter({
    required this.dashHeight,
    required this.dashWidth,
    required this.spacing,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = dashWidth
      ..style = PaintingStyle.stroke;

    double y = 0;
    while (y < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, y),
        Offset(size.width / 2, y + dashHeight),
        paint,
      );
      y += dashHeight + spacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
