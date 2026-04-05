import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';


enum PageTransitionType {
  fade,
  slideFromRight,
  slideFromLeft,
  slideFromBottom,
  scale,
  rotate,
  flip,
}

class AnimatedPageTransitions {
  static Page getPage({
    required Widget child,
    required GoRouterState state,
    required PageTransitionType transitionType,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      opaque: false,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return _buildTransition(child, animation, transitionType);
      },
    );
  }

  static Widget _buildTransition(
      Widget child, Animation<double> animation, PageTransitionType transitionType) {
    switch (transitionType) {
      case PageTransitionType.fade:
        return child
            .animate()
            .fadeIn(duration: 400.ms, curve: Curves.easeInOut);
      case PageTransitionType.slideFromRight:
        return child.animate().slide(
          begin: const Offset(1, 0),
          end: Offset.zero,
          duration: 400.ms,
          curve: Curves.easeInOut,
        );
      case PageTransitionType.slideFromLeft:
        return child.animate().slide(
          begin: const Offset(-1, 0),
          end: Offset.zero,
          duration: 400.ms,
          curve: Curves.easeInOut,
        );
      case PageTransitionType.slideFromBottom:
        return child.animate().slide(
          begin: const Offset(0, 1),
          end: Offset.zero,
          duration: 400.ms,
          curve: Curves.easeInOut,
        );
      case PageTransitionType.scale:
        return child.animate().scaleXY(
          begin: 0.8,
          end: 1.0,
          duration: 400.ms,
          curve: Curves.easeInOut,
        );
      case PageTransitionType.rotate:
        return child.animate().rotate(
          begin: 0,
          end: 1,
          duration: 400.ms,
          curve: Curves.easeInOut,
        );
      case PageTransitionType.flip:
        return _buildFlipAnimation(child);
      default:
        return child;
    }
  }
  static Widget _buildFlipAnimation(Widget child) {
    return child.animate().custom(
      duration: 400.ms,
      builder: (context, value, child) {
        final angle = value * 3.1416;
        return Transform(
          transform: Matrix4.rotationY(angle),
          alignment: Alignment.center,
          child: child,
        );
      },
    );
  }
}