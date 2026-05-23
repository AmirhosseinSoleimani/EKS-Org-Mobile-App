import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/cubit/assign_and_cancel_emdadgar_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/map/emdadgar_marker_style_resolver.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/map/map_control_buttons.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/map/map_pin_marker.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/map_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart' as lat_lng;

class ServiceAssignmentMapWidget extends StatelessWidget {
  final List<EmdadgarEntity> emdadgars;
  final double customerLatitude;
  final double customerLongitude;
  final double initialZoom;
  final double height;
  final void Function(EmdadgarEntity emdadgar)? onEmdadgarTap;
  final VoidCallback? onCurrentLocationTap;
  final bool isFullScreen;

  ServiceAssignmentMapWidget({
    super.key,
    required this.emdadgars,
    required this.customerLatitude,
    required this.customerLongitude,
    this.initialZoom = 12,
    this.height = 520,
    this.onEmdadgarTap,
    this.onCurrentLocationTap,
    this.isFullScreen = false,
  });

  final MapController _mapController = MapController();

  static const Color _purple = Color(0xff6C35D4);
  static const Color _orange = Color(0xffF59E0B);
  static const Color _green = Color(0xff22C55E);

  lat_lng.LatLng get _customerPoint =>
      lat_lng.LatLng(
        customerLatitude,
        customerLongitude,
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          children: [
            BlocBuilder<AssignAndCancelEmdadgarCubit,
                AssignAndCancelEmdadgarState>(
              builder: (context, state) {
                final int? loadingEmdadgarId = state.maybeWhen(
                  checkDepotLoading: (emdadgarId) => emdadgarId,
                  orElse: () => null,
                );

                final bool isMapLoading = loadingEmdadgarId != null;

                const markerStyleResolver = EmdadgarMarkerStyleResolver();
                final customerMarkerStyle =
                markerStyleResolver.resolveCustomer();

                return AbsorbPointer(
                  absorbing: isMapLoading,
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: _customerPoint,
                      initialZoom: initialZoom,
                      interactionOptions: const InteractionOptions(
                        flags: InteractiveFlag.drag |
                        InteractiveFlag.pinchZoom |
                        InteractiveFlag.doubleTapZoom |
                        InteractiveFlag.flingAnimation |
                        InteractiveFlag.scrollWheelZoom,
                      ),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: AppConstants.parsiMapUrlTemplate,
                        tileProvider: NonCachingNetworkTileProvider(
                          urlTemplate: AppConstants.parsiMapUrlTemplate,
                        ),
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: AppSize.s42,
                            height: AppSize.s42,
                            point: _customerPoint,
                            child: MapPinMarker(
                              iconPath: customerMarkerStyle.iconPath,
                              color: customerMarkerStyle.color,
                            ),
                          ),
                          ...emdadgars
                              .where(
                                (e) =>
                                e.lastLocationLatitude != null &&
                                    e.lastLocationLongitude != null,
                          )
                              .map((emdadgar) {
                            final markerStyle =
                            markerStyleResolver.resolve(emdadgar);

                            final bool isThisMarkerLoading =
                                loadingEmdadgarId == emdadgar.id;

                            return Marker(
                              width: AppSize.s48,
                              height: AppSize.s48,
                              point: lat_lng.LatLng(
                                emdadgar.lastLocationLatitude!,
                                emdadgar.lastLocationLongitude!,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  onEmdadgarTap?.call(emdadgar);
                                },
                                child: MapPinMarker(
                                  iconPath: markerStyle.iconPath,
                                  color: markerStyle.color,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),

            MapControlButtons(
              mapController: _mapController,
              defaultCenter: _customerPoint,
              defaultZoom: initialZoom,
              isFullScreen: isFullScreen,
              onFullScreenTap: () => _openFullScreenMap(context),
              onCurrentLocationTap: onCurrentLocationTap,
            ),

            PositionedDirectional(
              start: 16,
              end: 16,
              bottom: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(100),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _LegendItem(color: _purple, title: 'مشتری'),
                      _DividerText(),
                      _LegendItem(color: _orange, title: 'درحال خدمت'),
                      _DividerText(),
                      _LegendItem(color: _green, title: 'درحال ماموریت'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openFullScreenMap(BuildContext context) {
    final assignAndCancelEmdadgarCubit =
    context.read<AssignAndCancelEmdadgarCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: assignAndCancelEmdadgarCubit,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ServiceAssignmentMapWidget(
              emdadgars: emdadgars,
              customerLatitude: customerLatitude,
              customerLongitude: customerLongitude,
              initialZoom: _mapController.camera.zoom,
              height: MediaQuery.of(context).size.height,
              onEmdadgarTap: onEmdadgarTap,
              onCurrentLocationTap: onCurrentLocationTap,
              isFullScreen: true,
            ),
          ),
        );
      },
    );
  }
}

class _CircleMapButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _CircleMapButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 3,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: AppSize.s40,
          height: AppSize.s40,
          child: Icon(icon, color: Color(0xff6C35D4), size: 24),
        ),
      ),
    );
  }
}


class _LegendItem extends StatelessWidget {
  final Color color;
  final String title;

  const _LegendItem({required this.color, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on, color: color, size: 20),
        const SizedBox(width: 4),
        BodyMediumText(text:
        title,
            fontSize: 12, fontWeight: FontWeight.w600

        ),
      ],
    );
  }
}

class _DividerText extends StatelessWidget {
  const _DividerText();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        '|',
        style: TextStyle(
          color: Colors.grey.shade400,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
