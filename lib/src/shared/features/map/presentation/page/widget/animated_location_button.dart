
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/cubit/map_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimatedLocationButton extends StatelessWidget {
  final Color? loadingColor;

  const AnimatedLocationButton({super.key, this.loadingColor});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MapCubit>();

    return ValueListenableBuilder<bool>(
      valueListenable: cubit.findCurrentLocationLoading,
      builder: (context, loading, _) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          width: loading ? 56 : 160,
          height: 56,
          alignment: Alignment.centerLeft,
          child: ClipRect(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              child: loading
                  ? _LoadingFab(
                      key: const ValueKey('loading'),
                      loadingColor: loadingColor,
                    )
                  : const MapActions(key: ValueKey('action')),
            ),
          ),
        );
      },
    );
  }
}

class _LoadingFab extends StatelessWidget {
  final Color? loadingColor;

  const _LoadingFab({super.key, this.loadingColor});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MapCubit>();
    final colorScheme = Theme.of(context).colorScheme;
    return FloatingActionButton(
      elevation: 0,
      highlightElevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      onPressed: () {
        if (cubit.findCurrentLocationLoading.value) return;
        cubit.ensureAndCenterOnUser();
      },
      backgroundColor: colorScheme.onPrimary,
      child: CircularProgressIndicator(
        color: loadingColor ?? colorScheme.primary,
      ),
    );
  }
}
