import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/lookup_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/change_emdad_unit_location_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/cubit/emdad_unit_cubit.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/widgets/emdad_unit_summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/marker_style.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/single_location_map_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
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
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSize.s16),
                bottomLeft: Radius.circular(AppSize.s16),
              )),
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: InkwellButtonWidget(
              title: 'بستن',
              backgroundColor: theme.colorScheme.onPrimary,
              borderWidth: 2,
              borderColor: theme.colorScheme.outline.withOpacity(0.65),
              titleColor: theme.colorScheme.onSurface,
              onTap: () => context.pop(false),
            ),
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
          TitleLargeText(text: 'موقعیت و آدرس', fontSize: 16),
          Space.h20,
          SingleLocationMapWidget(
            latitude: latitude,
            longitude: longitude,
            markerStyle: MarkerStyle(iconPath: SvgManager.location),
            height: AppSize.s300,
            initialZoom: 14,
            onMapTap: onMapTap,
          ),
          Space.h24,
          AbsorbPointer(
            absorbing: isSubmitting,
            child: Opacity(
              opacity: isSubmitting ? 0.6 : 1,
              child: FilterButton(
                title: _getSelectedLocationTitle(
                  locations: locations,
                  locationId: locationId,
                ),
                label: 'محل استقرار',
                hasFloatingLabel: true,
                expand: true,
                overlayBuilder: (context,
                    position,
                    width,
                    dismiss,) {
                  return OverlayDropdownMenu<LookupEntity>(
                    position: position,
                    width: width,
                    items: locations,
                    onDismiss: dismiss,
                    onSelect: (item) {
                      onLocationChanged(item.id);
                      dismiss();
                    },
                  );
                },
              ),
            ),
          ),
          Space.h16,
          AbsorbPointer(
            absorbing: isSubmitting,
            child: Opacity(
              opacity: isSubmitting ? 0.6 : 1,
              child: TextFormFieldWidget(
                labelText: 'آدرس',
                controller: addressController,
                autofocus: false,
                textInputType: TextInputType.streetAddress,
                textAlign: TextAlign.start,
                textInputAction: TextInputAction.done,
                maxLines: 3,
              ),
            ),
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

  String _getSelectedLocationTitle({
    required List<LookupEntity> locations,
    required int? locationId,
  }) {
    if (locationId == null) {
      return 'انتخاب محل استقرار';
    }

    final selectedLocation = locations
        .where((item) => item.id == locationId)
        .firstOrNull;

    return selectedLocation?.title ?? 'انتخاب محل استقرار';
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
