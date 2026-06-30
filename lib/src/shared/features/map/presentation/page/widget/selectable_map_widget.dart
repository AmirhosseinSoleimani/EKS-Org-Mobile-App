import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/cubit/map_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/cubit/map_state.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/map_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectableMapWidget extends StatelessWidget {
  final void Function(double lat, double lng)? onLocationSelected;

  const SelectableMapWidget({super.key, this.onLocationSelected});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MapCubit>()..init(),
      child: const _SelectableMapView(),
    );
  }
}

class _SelectableMapView extends StatefulWidget {
  const _SelectableMapView();

  @override
  State<_SelectableMapView> createState() => _SelectableMapViewState();
}

class _SelectableMapViewState extends State<_SelectableMapView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        return const Stack(children: [_MapCanvas(), _CenterMarker()]);
      },
    );
  }
}

class _MapCanvas extends StatelessWidget {
  const _MapCanvas();

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
      child: RepaintBoundary(
        child: MapWidget(key: ValueKey('selectable_map_widget')),
      ),
    );
  }
}

class _CenterMarker extends StatelessWidget {
  const _CenterMarker();

  @override
  Widget build(BuildContext context) {
    return const IgnorePointer(
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: SvgWidget(
            src: SvgAsset(SvgManager.homeServiceLocation),
            width: AppSize.s60,
            height: AppSize.s60,
          ),
        ),
      ),
    );
  }
}
