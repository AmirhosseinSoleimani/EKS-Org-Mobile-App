import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/cubit/assign_and_cancel_emdadgar_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/map_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart' as lat_lng;

class AidPersonMapWidget extends StatefulWidget {
  final List<EmdadgarEntity> emdadgars;
  final double customerLatitude;
  final double customerLongitude;
  final double initialZoom;
  final double height;
  final void Function(EmdadgarEntity emdadgar)? onEmdadgarTap;
  final VoidCallback? onCurrentLocationTap;
  final bool isFullScreen;

  const AidPersonMapWidget({
    super.key,
    required this.emdadgars,
    required this.customerLatitude,
    required this.customerLongitude,
    this.initialZoom = 12,
    this.height = 420,
    this.onEmdadgarTap,
    this.onCurrentLocationTap,
    this.isFullScreen = false,
  });

  @override
  State<AidPersonMapWidget> createState() => _AidPersonMapWidgetState();
}

class _AidPersonMapWidgetState extends State<AidPersonMapWidget> {
  int? _selectedLoadingEmdadgarId;
  final MapController _mapController = MapController();

  late final lat_lng.LatLng _customerPoint = lat_lng.LatLng(
    widget.customerLatitude,
    widget.customerLongitude,
  );

  static const Color _purple = Color(0xff6C35D4);
  static const Color _orange = Color(0xffF59E0B);
  static const Color _green = Color(0xff22C55E);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          children: [
            BlocConsumer<
              AssignAndCancelEmdadgarCubit,
              AssignAndCancelEmdadgarState
            >(
              listenWhen: (previous, current) {
                final previousLoading = previous.maybeWhen(
                  checkDepotLoading: (emdadgarId) => true,
                  orElse: () => false,
                );

                final currentLoading = current.maybeWhen(
                  checkDepotLoading: (emdadgarId) => true,
                  orElse: () => false,
                );

                return previousLoading != currentLoading;
              },
              listener: (context, state) {
                final isMapLoading = state.maybeWhen(
                  checkDepotLoading: (emdadgarId) => true,
                  orElse: () => false,
                );

                if (!isMapLoading) {
                  setState(() {
                    _selectedLoadingEmdadgarId = null;
                  });
                }
              },
              builder: (context, state) {
                final bool isMapLoading = state.maybeWhen(
                  checkDepotLoading: (emdadgarId) => true,
                  orElse: () => false,
                );

                return AbsorbPointer(
                  absorbing: isMapLoading,
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: _customerPoint,
                      initialZoom: widget.initialZoom,
                      interactionOptions: const InteractionOptions(
                        flags:
                            InteractiveFlag.drag |
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
                            child: _MapPinMarker(
                              iconPath: ImageManager.customerMarker,
                            ),
                          ),

                          ...widget.emdadgars
                              .where(
                                (e) =>
                                    e.lastLocationLatitude != null &&
                                    e.lastLocationLongitude != null,
                              )
                              .map((emdadgar) {
                                final bool isThisMarkerLoading =
                                    isMapLoading &&
                                    _selectedLoadingEmdadgarId == emdadgar.id;

                                return Marker(
                                  width: AppSize.s48,
                                  height: AppSize.s48,
                                  point: lat_lng.LatLng(
                                    emdadgar.lastLocationLatitude!,
                                    emdadgar.lastLocationLongitude!,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedLoadingEmdadgarId =
                                            emdadgar.id;
                                      });

                                      widget.onEmdadgarTap?.call(emdadgar);
                                    },
                                    child: _MapPinMarker(
                                      iconPath: _getEmdadgarNavganIcon(
                                        emdadgar,
                                      ),
                                      isLoading: isThisMarkerLoading,
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
            PositionedDirectional(
              top: 16,
              end: 16,
              child: Column(
                children: [
                  _CircleMapButton(
                    icon: Icons.add,
                    onTap: () {
                      final camera = _mapController.camera;
                      _mapController.move(camera.center, camera.zoom + 1);
                    },
                  ),
                  const SizedBox(height: 10),
                  _CircleMapButton(
                    icon: Icons.remove,
                    onTap: () {
                      final camera = _mapController.camera;
                      _mapController.move(camera.center, camera.zoom - 1);
                    },
                  ),
                  const SizedBox(height: 10),
                  _CircleMapButton(
                    icon: widget.isFullScreen
                        ? Icons.fullscreen_exit
                        : Icons.fullscreen,
                    onTap: widget.isFullScreen
                        ? context.pop
                        : _openFullScreenMap,
                  ),
                  const SizedBox(height: 10),
                  _CircleMapButton(
                    icon: Icons.my_location,
                    onTap:
                        widget.onCurrentLocationTap ??
                        () {
                          _mapController.move(
                            _customerPoint,
                            widget.initialZoom,
                          );
                        },
                  ),
                ],
              ),
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
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
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
          ],
        ),
      ),
    );
  }

  void _openFullScreenMap() {
    final assignAndCancelEmdadgarCubit = context
        .read<AssignAndCancelEmdadgarCubit>();

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
            child: AidPersonMapWidget(
              emdadgars: widget.emdadgars,
              customerLatitude: widget.customerLatitude,
              customerLongitude: widget.customerLongitude,
              initialZoom: _mapController.camera.zoom,
              height: MediaQuery.of(context).size.height,
              onEmdadgarTap: widget.onEmdadgarTap,
              isFullScreen: true,
            ),
          ),
        );
      },
    );
  }

  Color _getEmdadgarStatusColor(EmdadgarEntity emdadgar) {
    final statusTitle = emdadgar.statusTitle ?? emdadgar.statusName ?? '';

    if (statusTitle.contains('خدمت')) {
      return _orange;
    }

    if (statusTitle.contains('ماموریت') || statusTitle.contains('ماموريت')) {
      return _green;
    }

    return _green;
  }

  String _getEmdadgarNavganIcon(EmdadgarEntity emdadgar) {
    return ImageManager.onMissionEmpty;
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
          width: 44,
          height: 44,
          child: Icon(icon, color: Color(0xff6C35D4), size: 24),
        ),
      ),
    );
  }
}

class _MapPinMarker extends StatelessWidget {
  final String iconPath;
  final bool isLoading;

  const _MapPinMarker({required this.iconPath, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          iconPath,
          width: AppSize.s48,
          height: AppSize.s48,
        ),

        if (isLoading)
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: const SizedBox(
              width: AppSize.s18,
              height: AppSize.s18,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
      ],
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
        Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
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
