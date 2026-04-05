import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

import 'dart:ui' show lerpDouble;


class ThreeDotFadeLoading extends StatefulWidget {
  const ThreeDotFadeLoading({
    super.key,
    this.size,
    this.spacing,
    this.duration = DurationConstant.d1000,
    this.baseColor,
    this.activeColor,
    this.minOpacity,
    this.curve,
    this.semanticLabel = 'loading',
  });
  final double? size;
  final double? spacing;
  final Duration? duration;
  final Color? baseColor;
  final Color? activeColor;
  final double? minOpacity;
  final Curve? curve;
  final String semanticLabel;

  @override
  State<ThreeDotFadeLoading> createState() => _ThreeDotFadeLoadingState();
}

class _ThreeDotFadeLoadingState extends State<ThreeDotFadeLoading> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: widget.duration ?? DurationConstant.d1000)..repeat();

  @override
  void didUpdateWidget(covariant ThreeDotFadeLoading oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
      _controller..reset()..repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _intensity(double t, int i) {
    final phase = (t + i / 3.0) % 1.0;
    var tri = 1.0 - ( (phase * 2.0 - 1.0).abs() );
    tri = (widget.curve ?? Curves.easeInOut).transform(tri.clamp(0.0, 1.0));
    return tri;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticLabel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final t = _controller.value;
          final dots = List<Widget>.generate(3, (i) {
            final k = _intensity(t, i);
            final color = Color.lerp(widget.baseColor ?? Theme.of(context).colorScheme.onSecondary, widget.activeColor ?? Theme.of(context).colorScheme.onTertiary, k)!;
            final opacity =
            lerpDouble(widget.minOpacity ?? 0.35, 1.0, k)!.clamp(0.0, 1.0);
            final dot = Opacity(
              opacity: opacity,
              child: Container(
                width: widget.size ?? AppSize.s8,
                height: widget.size ?? AppSize.s8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            );
            if (i == 2) return dot;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [dot, SizedBox(width: widget.spacing ?? AppSize.s8)],
            );
          });
          return Row(mainAxisSize: MainAxisSize.min, children: dots);
        },
      ),
    );
  }
}