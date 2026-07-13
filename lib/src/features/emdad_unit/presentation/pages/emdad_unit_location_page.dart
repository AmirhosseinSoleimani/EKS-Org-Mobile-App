import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/lookup_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/change_emdad_unit_location_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/cubit/emdad_unit_cubit.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/widgets/emdad_unit_summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

class EmdadUnitLocationPage extends StatelessWidget {
  static const path = '/emdad-unit-location-page';
  static const name = 'emdad-unit-location-page';

  const EmdadUnitLocationPage({super.key, required this.item});

  final EmdadUnitEntity item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EmdadUnitCubit>()..loadLookups(),
      child: _EmdadUnitLocationView(item: item),
    );
  }
}

class _EmdadUnitLocationView extends StatefulWidget {
  const _EmdadUnitLocationView({required this.item});

  final EmdadUnitEntity item;

  @override
  State<_EmdadUnitLocationView> createState() => _EmdadUnitLocationViewState();
}

class _EmdadUnitLocationViewState extends State<_EmdadUnitLocationView> {
  final _addressController = TextEditingController();
  final _mapController = MapController();
  int? _locationId;
  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    super.initState();
    _locationId = widget.item.locationId;
    _latitude = _validCoordinate(widget.item.latitude) ? widget.item.latitude : null;
    _longitude = _validCoordinate(widget.item.longitude) ? widget.item.longitude : null;
    _addressController.text = widget.item.address ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EmdadUnitCubit>();
    final theme = Theme.of(context);

    return BlocListener<EmdadUnitCubit, EmdadUnitState>(
      listener: (context, state) {
        if (state.status == EmdadUnitViewStatus.failure && state.message != null) {
          SnakeBarWidget.showError(context: context, message: state.message!);
        }
        if (state.status == EmdadUnitViewStatus.success) {
          SnakeBarWidget.showSuccess(context: context, message: state.message ?? '');
          context.pop(true);
        }
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: const SimpleAppBar(title: 'تغییر محل استقرار'),
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.all(AppPadding.p16),
          child: InkwellButtonWidget(
            title: 'بستن',
            backgroundColor: theme.colorScheme.onPrimary,
            borderColor: theme.colorScheme.outline.withOpacity(0.65),
            titleColor: theme.colorScheme.onSurface,
            onTap: () => context.pop(false),
          ),
        ),
        body: BlocBuilder<EmdadUnitCubit, EmdadUnitState>(
          builder: (context, state) {
            if (state.isLookupsLoading && state.locations.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              padding: const EdgeInsets.all(AppPadding.p16),
              children: [
                EmdadUnitSummaryCard(item: widget.item),
                Space.h16,
                _LocationCard(
                  mapController: _mapController,
                  latitude: _latitude,
                  longitude: _longitude,
                  locationId: _locationId,
                  locations: state.locations,
                  addressController: _addressController,
                  isSubmitting: state.status == EmdadUnitViewStatus.submitting,
                  onMapTap: _setPoint,
                  onLocationChanged: (value) => _selectLocation(state.locations, value),
                  onSubmit: () => _submit(cubit),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _selectLocation(List<LookupEntity> locations, int? value) {
    final location = locations.firstWhereOrNull((item) => item.id == value);
    setState(() {
      _locationId = value;
      _latitude = location?.latitude ?? _latitude;
      _longitude = location?.longitude ?? _longitude;
      _addressController.text = location?.address ?? _addressController.text;
    });
    if (_latitude != null && _longitude != null) {
      _mapController.move(LatLng(_latitude!, _longitude!), 14);
    }
  }

  void _setPoint(LatLng point) {
    setState(() {
      _latitude = point.latitude;
      _longitude = point.longitude;
    });
  }

  void _submit(EmdadUnitCubit cubit) {
    final id = widget.item.id;
    final personId = widget.item.agencyPersonId;
    final vehicleId = widget.item.agencyVehicleId;
    if (id == null || personId == null || vehicleId == null) {
      SnakeBarWidget.showError(context: context, message: 'اطلاعات واحد امدادی کامل نیست.');
      return;
    }
    if (_locationId == null || _latitude == null || _longitude == null) {
      SnakeBarWidget.showError(context: context, message: 'انتخاب محل استقرار اجباری می باشد');
      return;
    }
    cubit.changeLocation(ChangeEmdadUnitLocationParamEntity(
      emdadUnitId: id,
      agencyPersonId: personId,
      agencyVehicleId: vehicleId,
      locationId: _locationId!,
      latitude: _latitude!,
      longitude: _longitude!,
      address: _addressController.text.trim(),
    ));
  }

  bool _validCoordinate(double? value) {
    return value != null && value.abs() > 0.000001;
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard({
    required this.mapController,
    required this.latitude,
    required this.longitude,
    required this.locationId,
    required this.locations,
    required this.addressController,
    required this.isSubmitting,
    required this.onMapTap,
    required this.onLocationChanged,
    required this.onSubmit,
  });

  final MapController mapController;
  final double? latitude;
  final double? longitude;
  final int? locationId;
  final List<LookupEntity> locations;
  final TextEditingController addressController;
  final bool isSubmitting;
  final ValueChanged<LatLng> onMapTap;
  final ValueChanged<int?> onLocationChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'موقعیت و آدرس',
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          Space.h20,
          _LocationMap(
            controller: mapController,
            latitude: latitude,
            longitude: longitude,
            onTap: onMapTap,
          ),
          Space.h24,
          DropdownButtonFormField<int>(
            value: locationId,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'محل استقرار'),
            items: locations
                .map(
                  (item) => DropdownMenuItem<int>(
                    value: item.id,
                    child: Text(item.title, overflow: TextOverflow.ellipsis),
                  ),
                )
                .toList(),
            onChanged: isSubmitting ? null : onLocationChanged,
          ),
          Space.h16,
          TextFormField(
            controller: addressController,
            decoration: const InputDecoration(labelText: 'آدرس'),
            minLines: 2,
            maxLines: 4,
            enabled: !isSubmitting,
          ),
          Space.h24,
          InkwellButtonWidget(
            title: 'ثبت تغییرات',
            showLoading: isSubmitting,
            onTap: isSubmitting ? null : onSubmit,
          ),
        ],
      ),
    );
  }
}

class _LocationMap extends StatelessWidget {
  const _LocationMap({
    required this.controller,
    required this.latitude,
    required this.longitude,
    required this.onTap,
  });

  final MapController controller;
  final double? latitude;
  final double? longitude;
  final ValueChanged<LatLng> onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasPoint = latitude != null && longitude != null;
    final point = LatLng(latitude ?? 35.6892, longitude ?? 51.3890);

    return SizedBox(
      height: AppSize.s300,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSize.s8),
        child: Stack(
          children: [
            FlutterMap(
              mapController: controller,
              options: MapOptions(
                initialCenter: point,
                initialZoom: hasPoint ? 14 : 10,
                onTap: (_, point) => onTap(point),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'eks_sana_plus_org',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: point,
                      width: AppSize.s64,
                      height: AppSize.s64,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: AppSize.s42,
                            height: AppSize.s42,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colorScheme.primary.withOpacity(0.22),
                                  blurRadius: AppSize.s16,
                                  spreadRadius: AppSize.s10,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.circle,
                              color: theme.colorScheme.onPrimary,
                              size: AppSize.s12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: AppPadding.p16,
              left: AppPadding.p16,
              child: Column(
                children: [
                  _MapButton(
                    icon: Icons.add_rounded,
                    onTap: () => controller.move(point, controller.camera.zoom + 1),
                  ),
                  Space.h8,
                  _MapButton(
                    icon: Icons.remove_rounded,
                    onTap: () => controller.move(point, controller.camera.zoom - 1),
                  ),
                  Space.h8,
                  _MapButton(
                    icon: Icons.my_location_rounded,
                    onTap: () => controller.move(point, 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapButton extends StatelessWidget {
  const _MapButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.onPrimary,
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: AppSize.s32,
          height: AppSize.s32,
          child: Icon(icon, size: AppSize.s20),
        ),
      ),
    );
  }
}

extension _FirstWhereOrNull<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T item) test) {
    for (final item in this) {
      if (test(item)) return item;
    }
    return null;
  }
}
