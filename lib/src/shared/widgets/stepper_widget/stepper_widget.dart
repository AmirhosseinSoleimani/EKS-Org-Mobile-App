import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

enum _StepState { done, current, upcoming }


class StepItem {
  final IconData icon;
  final String label;
  const StepItem({
    required this.icon,
    required this.label,
  });
}

class StepTimeline extends StatelessWidget {
  final List<StepItem> steps;
  final int currentIndex;
  final int completedUntil;
  final Color? filledColor;
  final Color? outlineColor;
  final Color? mutedColor;
  final Color? lineColor;
  final Color? filledIconColor;
  final Color? outlineIconColor;

  const StepTimeline({
    super.key,
    required this.steps,
    required this.currentIndex,
    this.completedUntil = -1,
    this.filledColor,
    this.outlineColor,
    this.mutedColor,
    this.lineColor,
    this.filledIconColor,
    this.outlineIconColor,

  });

  @override
  Widget build(BuildContext context) {
    assert(steps.isNotEmpty, 'steps must not be empty');
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return LayoutBuilder(
      builder: (context, c) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              textDirection: TextDirection.rtl,
              children: List.generate(steps.length * 2 - 1, (i) {
                final isConnector = i.isOdd;
                if (isConnector) {
                  final connectorIndex = i ~/ 2;
                  final state = _connectorState(connectorIndex);
                  final color = _colorForState(state, context);
                  return Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: AppSize.s1,
                          margin: const EdgeInsets.symmetric(horizontal: AppPadding.p2),
                          color: color,
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: AppPadding.p2),
                            width: AppSize.s6,
                            height: AppSize.s6,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                final stepIndex = i ~/ 2;
                return _StepDot(
                  item: steps[stepIndex],
                  state: _stateFor(stepIndex),
                  filledColor: filledColor ?? colorScheme.onPrimaryFixed,
                  outlineColor: outlineColor ?? Theme.of(context).colorScheme.onPrimaryFixed,
                  mutedColor: mutedColor ?? Theme.of(context).colorScheme.inverseSurface,
                  filledIconColor: filledIconColor ?? Theme.of(context).colorScheme.onPrimaryFixed.withOpacity(0.9),
                  outlineIconColor: outlineIconColor ?? colorScheme.onPrimaryFixed,
                );
              }),
            ),
            Space.h4,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.rtl,
              children: List.generate(steps.length * 2 - 1, (i) {
                if (i.isOdd) {
                  return const Expanded(flex: 1, child: SizedBox.shrink());
                }
                final stepIndex = i ~/ 2;
                final state = _stateFor(stepIndex);
                final isMuted = state == _StepState.upcoming;
                return Expanded(
                  flex: 2,
                  child: SizedBox(
                    child: _LabelCell(
                      text: steps[stepIndex].label,
                      style: textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppSize.s14,
                        color: isMuted ? colorScheme.inverseSurface : colorScheme.onSurface,
                      ),
                    ),
                  ),
                );
              }),
            )
          ],
        );
      },
    );
  }

  _StepState _stateFor(int index) {
    if (index <= completedUntil) return _StepState.done;
    if (index == currentIndex) return _StepState.current;
    return _StepState.upcoming;
  }
  _StepState _connectorState(int connectorIndex) {
    if (connectorIndex <= completedUntil) return _StepState.done;
    if (connectorIndex < currentIndex) return _StepState.done;
    if (connectorIndex == currentIndex) return _StepState.current;
    return _StepState.upcoming;
  }
  Color _colorForState(_StepState s, BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final Color doneColor     = filledColor ?? cs.onPrimaryFixed;
    final Color currentColor  = mutedColor ?? cs.inverseSurface;
    final Color upcomingColor = mutedColor ?? cs.inverseSurface;

    switch (s) {
      case _StepState.done:     return doneColor;
      case _StepState.current:  return currentColor;
      case _StepState.upcoming: return upcomingColor;
    }
  }
}

class _StepDot extends StatelessWidget {
  final StepItem item;
  final _StepState state;
  final Color filledColor;
  final Color filledIconColor;
  final Color outlineColor;
  final Color outlineIconColor;
  final Color mutedColor;

  const _StepDot({
    required this.item,
    required this.state,
    required this.filledColor,
    required this.outlineColor,
    required this.mutedColor,
    required this.filledIconColor,
    required this.outlineIconColor,
  });

  @override
  Widget build(BuildContext context) {
    const double size = AppSize.s48;
    switch (state) {
      case _StepState.done:
        return _circle(
          size: size,
          background: filledColor,
          border: Border.all(color: filledColor, width: AppSize.s2),
          child: Icon(item.icon, color: filledIconColor, size: AppSize.s28),
        );
      case _StepState.current:
        return _circle(
          size: size,
          background: Theme.of(context).colorScheme.onPrimary,
          border: Border.all(color: outlineIconColor, width: AppSize.s2),
          child: Icon(item.icon, color: outlineIconColor, size: AppSize.s28),
        );
      case _StepState.upcoming:
        return _circle(
          size: size,
          background: Theme.of(context).colorScheme.onPrimary,
          border: Border.all(color: mutedColor, width: AppSize.s2),
          child: Icon(item.icon, color: mutedColor, size: AppSize.s28),
        );
    }
  }

  Widget _circle({
    required double size,
    required Widget child,
    Color? background,
    BoxBorder? border,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: border,
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}

class _LabelCell extends StatelessWidget {
  final String text;
  final TextStyle style;
  const _LabelCell({
    required this.text,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text, style: style, maxLines: 2, textAlign: TextAlign.center,));
  }
}