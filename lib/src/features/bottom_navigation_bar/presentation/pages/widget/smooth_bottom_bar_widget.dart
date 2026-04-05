import 'package:flutter/material.dart';


class SmoothBottomBarWidget extends StatelessWidget {
  const SmoothBottomBarWidget({
    super.key,
    this.height = 74,
    this.backgroundColor,
    this.cornerRadius = 12,
    this.bumpWidth = 88,
    this.bumpHeight = 12,
    this.borderColor,
    this.borderWidth = 1.0,
    this.softness = 0.42,
  });

  final double height;
  final Color? backgroundColor;
  final double cornerRadius;
  final double bumpWidth;
  final double bumpHeight;
  final Color? borderColor;
  final double borderWidth;
  final double softness;

  @override
  Widget build(BuildContext context) {
    final fill = backgroundColor ?? Theme.of(context).colorScheme.onPrimary;
    final stroke = borderColor ?? Theme.of(context).colorScheme.onTertiary;
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _TopPainterWidget(
          fillColor: fill,
          strokeColor: stroke,
          strokeWidth: borderWidth,
          cornerRadius: cornerRadius,
          bumpWidth: bumpWidth,
          bumpHeight: bumpHeight,
          softness: softness,
        ),
      ),
    );
  }
}

class _TopPainterWidget extends CustomPainter {
  _TopPainterWidget({
    required this.fillColor,
    required this.strokeColor,
    required this.strokeWidth,
    required this.cornerRadius,
    required this.bumpWidth,
    required this.bumpHeight,
    required this.softness,
  });

  final Color fillColor;
  final Color strokeColor;
  final double strokeWidth;
  final double cornerRadius;
  final double bumpWidth;
  final double bumpHeight;
  final double softness;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final r = cornerRadius.clamp(0.0, 48.0);
    final cx = w / 2.0;
    const double top = 0.0;
    final double halfW = (bumpWidth / 2.0).clamp(10.0, w / 2.0 - 16.0);
    final double H = bumpHeight.clamp(2.0, 28.0);

    final double xL = cx - halfW;
    final double xR = cx + halfW;
    final double yPeak = top - H;
    final double d1 = halfW * softness;
    final double d2 = halfW * (1.0 - softness);
    final path = Path();
    path.moveTo(0, r);
    path.quadraticBezierTo(0, 0, r, 0);
    path.lineTo(xL, top);
    path.cubicTo(
      xL + d1,
      top,
      cx - d2,
      yPeak,
      cx,
      yPeak,
    );
    path.cubicTo(
      cx + d2,
      yPeak,
      xR - d1,
      top,
      xR,
      top,
    );
    path.lineTo(w - r, top);
    path.quadraticBezierTo(w, 0, w, r);
    path.lineTo(w, h - r);
    path.quadraticBezierTo(w, h, w - r, h);
    path.lineTo(r, h);
    path.quadraticBezierTo(0, h, 0, h - r);
    path.close();
    final fill = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fill);
    if (strokeWidth > 0) {
      final stroke = Paint()
        ..color = strokeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;
      canvas.drawPath(path, stroke);
    }
  }

  @override
  bool shouldRepaint(covariant _TopPainterWidget old) {
    return fillColor != old.fillColor ||
        strokeColor != old.strokeColor ||
        strokeWidth != old.strokeWidth ||
        cornerRadius != old.cornerRadius ||
        bumpWidth != old.bumpWidth ||
        bumpHeight != old.bumpHeight ||
        softness != old.softness;
  }
}