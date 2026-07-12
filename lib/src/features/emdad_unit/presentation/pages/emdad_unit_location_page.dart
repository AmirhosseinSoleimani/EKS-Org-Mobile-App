import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/lookup_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/change_emdad_unit_location_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/cubit/emdad_unit_cubit.dart';
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
  int? _locationId;
  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    super.initState();
    _locationId = widget.item.locationId;
    _latitude = widget.item.latitude;
    _longitude = widget.item.longitude;
    _addressController.text = widget.item.address ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EmdadUnitCubit>();
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
        appBar: const SimpleAppBar(title: 'تغییر محل استقرار'),
        bottomNavigationBar: BlocBuilder<EmdadUnitCubit, EmdadUnitState>(
          builder: (context, state) => Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: InkwellButtonWidget(
              title: 'ثبت تغییر مکان',
              showLoading: state.status == EmdadUnitViewStatus.submitting,
              onTap: () => _submit(cubit),
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
                Text(widget.item.name ?? '', style: Theme.of(context).textTheme.titleSmall),
                Space.h16,
                DropdownButtonFormField<int>(
                  value: _locationId,
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'محل استقرار'),
                  items: state.locations
                      .map((item) => DropdownMenuItem<int>(
                            value: item.id,
                            child: Text(item.title, overflow: TextOverflow.ellipsis),
                          ))
                      .toList(),
                  onChanged: (value) => _selectLocation(state.locations, value),
                ),
                Space.h12,
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'آدرس'),
                  minLines: 2,
                  maxLines: 4,
                ),
                Space.h16,
                _LocationMap(
                  latitude: _latitude,
                  longitude: _longitude,
                  onTap: (point) {
                    setState(() {
                      _latitude = point.latitude;
                      _longitude = point.longitude;
                    });
                  },
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

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }
}

class _LocationMap extends StatelessWidget {
  const _LocationMap({
    required this.latitude,
    required this.longitude,
    required this.onTap,
  });

  final double? latitude;
  final double? longitude;
  final ValueChanged<LatLng> onTap;

  @override
  Widget build(BuildContext context) {
    final point = LatLng(latitude ?? 35.6892, longitude ?? 51.3890);
    return SizedBox(
      height: AppSize.s320,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSize.s8),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: point,
            initialZoom: latitude == null ? 8 : 13,
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
                  width: AppSize.s48,
                  height: AppSize.s48,
                  child: Icon(
                    Icons.location_on_rounded,
                    color: Theme.of(context).colorScheme.error,
                    size: AppSize.s40,
                  ),
                ),
              ],
            ),
          ],
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
