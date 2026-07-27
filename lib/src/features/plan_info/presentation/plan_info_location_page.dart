import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_lookup_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/cubit/plan_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/cubit/plan_info_state.dart';
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
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

class PlanInfoLocationPage extends StatelessWidget {
  static const path = '/plan-info-location-page';
  static const name = 'plan-info-location-page';

  const PlanInfoLocationPage({super.key, required this.item});

  final PlanInfoEntity item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PlanInfoCubit>()..initLocationPage(),
      child: _PlanInfoLocationView(item: item),
    );
  }
}

class _PlanInfoLocationView extends StatefulWidget {
  const _PlanInfoLocationView({required this.item});

  final PlanInfoEntity item;

  @override
  State<_PlanInfoLocationView> createState() => _PlanInfoLocationViewState();
}

class _PlanInfoLocationViewState extends State<_PlanInfoLocationView> {
  final TextEditingController _addressController = TextEditingController();
  int? _locationId;
  double? _latitude;
  double? _longitude;
  bool _changeLocationRequested = false;

  @override
  void initState() {
    super.initState();
    _locationId = widget.item.locationId;
    _latitude = _validCoordinate(widget.item.latitude)
        ? widget.item.latitude
        : null;
    _longitude = _validCoordinate(widget.item.longitude)
        ? widget.item.longitude
        : null;
    _addressController.text = widget.item.address ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<PlanInfoCubit, PlanInfoState>(
      listener: _stateListener,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: const SimpleAppBar(title: 'تغییر محل استقرار'),
        bottomNavigationBar: BlocBuilder<PlanInfoCubit, PlanInfoState>(
  builder: (context, state) {
    final isSubmitting = state.status == PlanInfoStatus.submitting;
    return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.s16),
              bottomLeft: Radius.circular(AppSize.s16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: InkwellButtonWidget(
              title: 'ثبت تغییرات',
              showLoading: isSubmitting,
              onTap: isSubmitting ? (){} :()=>  _submit(cubit: context.read<PlanInfoCubit>()),
            ),
          ),
        );
  },
),
        body: BlocBuilder<PlanInfoCubit, PlanInfoState>(
          builder: (context, state) {
            if (state.status == PlanInfoStatus.loading &&
                state.locations.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == PlanInfoStatus.connectionError &&
                state.locations.isEmpty) {
              return _PageMessage(
                message: 'خطا در برقراری ارتباط با سرور',
                onRetry: () {
                  context.read<PlanInfoCubit>().initLocationPage();
                },
              );
            }
            if (state.status == PlanInfoStatus.error &&
                state.locations.isEmpty) {
              return _PageMessage(
                message:
                    state.message ?? 'دریافت محل‌های استقرار با خطا مواجه شد',
                onRetry: () {
                  context.read<PlanInfoCubit>().initLocationPage();
                },
              );
            }
            return ListView(
              padding: const EdgeInsets.all(AppPadding.p16),
              children: [
                _PlanInfoSummaryCard(item: widget.item),
                Space.h16,
                _LocationCard(
                  latitude: _latitude,
                  longitude: _longitude,
                  locationId: _locationId,
                  locations: state.locations,
                  addressController: _addressController,
                  isSubmitting: state.status == PlanInfoStatus.submitting,
                  onMapTap: _setPoint,
                  onLocationChanged: (value) {
                    _selectLocation(locations: state.locations, value: value);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _stateListener(BuildContext context, PlanInfoState state) {
    if (!_changeLocationRequested) {
      return;
    }
    if (state.status == PlanInfoStatus.submitting) {
      return;
    }
    if (state.status == PlanInfoStatus.error) {
      _changeLocationRequested = false;
      SnakeBarWidget.showError(
        context: context,
        message: state.message ?? 'تغییر محل استقرار با خطا مواجه شد',
      );
      return;
    }
    if (state.status == PlanInfoStatus.connectionError) {
      _changeLocationRequested = false;
      SnakeBarWidget.showError(
        context: context,
        message: 'خطا در برقراری ارتباط با سرور',
      );
      return;
    }
    if (state.status == PlanInfoStatus.loaded) {
      _changeLocationRequested = false;
      SnakeBarWidget.showSuccess(
        context: context,
        message: state.message ?? 'محل استقرار با موفقیت تغییر کرد',
      );
      context.pop(true);
    }
  }

  void _selectLocation({
    required List<PlanLookupEntity> locations,
    required int? value,
  }) {
    final selectedLocation = locations.firstWhereOrNull(
      (item) => item.resolvedId == value,
    );
    setState(() {
      _locationId = value;
      _latitude = selectedLocation?.latitude ?? _latitude;
      _longitude = selectedLocation?.longitude ?? _longitude;
      _addressController.text =
          selectedLocation?.address ?? _addressController.text;
    });
  }

  void _setPoint(LatLng point) {
    setState(() {
      _latitude = point.latitude;
      _longitude = point.longitude;
    });
  }

  void _submit({required PlanInfoCubit cubit}) {
    FocusScope.of(context).unfocus();
    final planId = widget.item.resolvedId;
    final emdadUnitId = widget.item.emdadUnitId;
    if (planId == null || planId <= 0) {
      SnakeBarWidget.showError(
        context: context,
        message: 'شناسه برنامه‌ریزی معتبر نیست.',
      );
      return;
    }
    if (emdadUnitId == null || emdadUnitId <= 0) {
      SnakeBarWidget.showError(
        context: context,
        message: 'شناسه واحد امدادی معتبر نیست.',
      );
      return;
    }
    if (_locationId == null || _locationId! <= 0) {
      SnakeBarWidget.showError(
        context: context,
        message: 'انتخاب محل استقرار اجباری می‌باشد.',
      );
      return;
    }
    if (_latitude == null || _longitude == null) {
      SnakeBarWidget.showError(
        context: context,
        message: 'مختصات محل استقرار مشخص نشده است.',
      );
      return;
    }
    _changeLocationRequested = true;
    cubit.changeLocation(
      planId: planId,
      emdadUnitId: emdadUnitId,
      locationId: _locationId!,
      latitude: _latitude!,
      longitude: _longitude!,
      address: _addressController.text.trim(),
    );
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

class _PlanInfoSummaryCard extends StatelessWidget {
  const _PlanInfoSummaryCard({
    required this.item,
  });

  final PlanInfoEntity item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.06),
            blurRadius: AppSize.s16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PlanInfoIcon(
                color: theme.colorScheme.primary,
              ),
              Space.w12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _buildTitle(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: AppSize.s14,
                      ),
                    ),
                    Space.h4,
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline_rounded,
                          size: AppSize.s16,
                          color:
                          theme.colorScheme.onSurfaceVariant,
                        ),
                        Space.w4,
                        Expanded(
                          child: Text(
                            _dash(item.personsText),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                            theme.textTheme.bodySmall?.copyWith(
                              color: theme
                                  .colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Space.h14,
          const Divider(
            height: AppSize.s1,
            color: Color(0xFFE9E8E7),
          ),
          Space.h12,
          Row(
            children: [
              Expanded(
                child: _PlanInfoPill(
                  icon: Icons.timer_outlined,
                  value: _dash(item.shiftTitle),
                ),
              ),
              Space.w8,
              Expanded(
                child: _PlanInfoPill(
                  icon: Icons.location_on_outlined,
                  value: _dash(item.locationTitle),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _buildTitle() {
    final values = [
      item.emdadUnitName,
      item.seatTypeTitle,
    ]
        .whereType<String>()
        .map((value) => value.trim())
        .where((value) => value.isNotEmpty)
        .toList();

    return values.isEmpty
        ? '---'
        : values.join('، ');
  }

  static String _dash(String? value) {
    return value?.trim().isNotEmpty == true
        ? value!.trim()
        : '---';
  }
}

class _PlanInfoIcon extends StatelessWidget {
  const _PlanInfoIcon({
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.s48,
      height: AppSize.s48,
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.calendar_month_outlined,
        color: color,
        size: AppSize.s24,
      ),
    );
  }
}

class _PlanInfoPill extends StatelessWidget {
  const _PlanInfoPill({
    required this.icon,
    required this.value,
  });

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: AppSize.s32,
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p10,
        vertical: AppPadding.p8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3F3),
        borderRadius: BorderRadius.circular(AppSize.s6),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: AppSize.s16,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          Space.w4,
          Expanded(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard({
    required this.latitude,
    required this.longitude,
    required this.locationId,
    required this.locations,
    required this.addressController,
    required this.isSubmitting,
    required this.onMapTap,
    required this.onLocationChanged,
  });

  final double? latitude;
  final double? longitude;
  final int? locationId;
  final List<PlanLookupEntity> locations;
  final TextEditingController addressController;
  final bool isSubmitting;
  final ValueChanged<LatLng> onMapTap;
  final ValueChanged<int?> onLocationChanged;

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
          const TitleLargeText(text: 'موقعیت و آدرس', fontSize: 16),
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
                title: _getSelectedLocationTitle(),
                label: 'محل استقرار',
                hasFloatingLabel: true,
                expand: true,
                overlayBuilder: (context, position, width, dismiss) {
                  return OverlayDropdownMenu<PlanLookupEntity>(
                    position: position,
                    width: width,
                    items: locations,
                    onDismiss: dismiss,
                    onSelect: (item) {
                      onLocationChanged(item.resolvedId);
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
          Space.h16,
        ],
      ),
    );
  }

  String _getSelectedLocationTitle() {
    if (locationId == null) {
      return 'انتخاب محل استقرار';
    }
    final selectedLocation = locations.firstWhereOrNull(
      (item) => item.resolvedId == locationId,
    );
    return selectedLocation?.displayTitle ?? 'انتخاب محل استقرار';
  }
}

class _PageMessage extends StatelessWidget {
  const _PageMessage({required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.info_outline_rounded,
              size: AppSize.s48,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            Space.h12,
            Text(message, textAlign: TextAlign.center),
            if (onRetry != null) ...[
              Space.h16,
              InkwellButtonWidget(title: 'تلاش مجدد', onTap: onRetry),
            ],
          ],
        ),
      ),
    );
  }
}

extension _FirstWhereOrNull<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T item) test) {
    for (final item in this) {
      if (test(item)) {
        return item;
      }
    }
    return null;
  }
}
