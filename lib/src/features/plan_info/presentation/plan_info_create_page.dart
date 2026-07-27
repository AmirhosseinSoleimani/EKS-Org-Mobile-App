import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_lookup_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/cubit/plan_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/cubit/plan_info_state.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/cubit/map_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/marker_style.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/map_widget.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/single_location_map_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/date_picker_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/overlay_dropdown_form_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/sticky_form_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/app_checkbox_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class PlanInfoCreatePage extends StatelessWidget {
  static const path = '/plan-info-create';
  static const name = 'plan-info-create';

  const PlanInfoCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PlanInfoCubit>()..initCreatePage(),
      child: const _PlanInfoCreateView(),
    );
  }
}

class _PlanInfoCreateView extends StatefulWidget {
  const _PlanInfoCreateView();

  @override
  State<_PlanInfoCreateView> createState() => _PlanInfoCreateViewState();
}

class _PlanInfoCreateViewState extends State<_PlanInfoCreateView> {
  final _formKey = GlobalKey<FormState>();
  final _fromDateController = TextEditingController();
  final _toDateController = TextEditingController();
  final _addressController = TextEditingController();

  PlanLookupEntity? _emdadUnit;
  PlanLookupEntity? _shift;
  PlanLookupEntity? _specialPlan;
  PlanLookupEntity? _seatType;
  PlanLookupEntity? _location;
  bool _hasSpecialPlan = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<PlanInfoCubit, PlanInfoState>(
        listenWhen: (previous, current) => previous.message != current.message,
        listener: (context, state) {
          final message = state.message;
          if (message?.trim().isNotEmpty != true) return;
          if (state.status == PlanInfoStatus.error) {
            SnakeBarWidget.showError(context: context, message: message!);
          } else {
            SnakeBarWidget.showSuccess(context: context, message: message!);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: theme.colorScheme.surface,
            appBar: const SimpleActionBar(title: 'ثبت برنامه ریزی جدید'),
            body: state.status == PlanInfoStatus.loading &&
                    state.emdadUnits.isEmpty &&
                    state.locations.isEmpty
                ? const Center(child: LoadingWidget())
                : SafeArea(
                    top: false,
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.all(AppPadding.p16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _PlanFormSection(
                              title: 'اطلاعات برنامه ریزی',
                              icon: Icons.calendar_month_outlined,
                              child: _PlanBaseFields(
                                state: state,
                                emdadUnit: _emdadUnit,
                                shift: _shift,
                                fromDateController: _fromDateController,
                                toDateController: _toDateController,
                                onEmdadUnitChanged: (value) {
                                  setState(() => _emdadUnit = value);
                                },
                                onShiftChanged: (value) {
                                  setState(() => _shift = value);
                                },
                              ),
                            ),
                            Space.h16,
                            _PlanFormSection(
                              title: 'طرح و نوع مقر',
                              icon: Icons.assignment_outlined,
                              child: _PlanTypeFields(
                                state: state,
                                hasSpecialPlan: _hasSpecialPlan,
                                specialPlan: _specialPlan,
                                seatType: _seatType,
                                onSpecialPlanSwitchChanged: (value) {
                                  setState(() {
                                    _hasSpecialPlan = value;
                                    if (!value) _specialPlan = null;
                                  });
                                },
                                onSpecialPlanChanged: (value) {
                                  setState(() => _specialPlan = value);
                                },
                                onSeatTypeChanged: (value) {
                                  setState(() => _seatType = value);
                                },
                              ),
                            ),
                            Space.h16,
                            _PlanFormSection(
                              title: 'موقعیت و آدرس',
                              icon: Icons.location_on_outlined,
                              child: _PlanLocationFields(
                                locations: state.locations,
                                location: _location,
                                addressController: _addressController,
                                onLocationChanged: (value) {
                                  setState(() {
                                    _location = value;
                                    _addressController.text =
                                        value?.address ?? '';
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            bottomNavigationBar: StickyFormActionBar(
              submitTitle: 'ثبت',
              cancelTitle: 'انصراف',
              isSubmitting: state.isSubmitting,
              onCancel: () => context.pop(false),
              onSubmit: state.isSubmitting ? null : _submit,
            ),
          );
        },
      ),
    );
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() != true) return;

    final saved = await context.read<PlanInfoCubit>().savePlan(
          isEdit: false,
          isCopy: false,
          emdadUnitId: _emdadUnit?.resolvedId,
          shiftId: _shift?.resolvedId,
          fromDate: _fromDateController.text,
          toDate: _toDateController.text,
          hasSpecialPlan: _hasSpecialPlan,
          specialPlanId: _specialPlan?.resolvedId,
          seatType: _seatType?.resolvedId,
          locationId: _location?.resolvedId,
          refreshAfterSuccess: false,
        );

    if (saved && mounted) {
      context.pop(true);
    }
  }

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}

class _PlanFormSection extends StatelessWidget {
  const _PlanFormSection({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FormSectionContainer(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, color: theme.colorScheme.primary),
              Space.w8,
              TitleLargeText(
                text: title,
                color: theme.colorScheme.onSurface,
                fontSize: AppSize.s16,
              ),
            ],
          ),
          Space.h20,
          child,
        ],
      ),
    );
  }
}

class _PlanBaseFields extends StatelessWidget {
  const _PlanBaseFields({
    required this.state,
    required this.emdadUnit,
    required this.shift,
    required this.fromDateController,
    required this.toDateController,
    required this.onEmdadUnitChanged,
    required this.onShiftChanged,
  });

  final PlanInfoState state;
  final PlanLookupEntity? emdadUnit;
  final PlanLookupEntity? shift;
  final TextEditingController fromDateController;
  final TextEditingController toDateController;
  final ValueChanged<PlanLookupEntity?> onEmdadUnitChanged;
  final ValueChanged<PlanLookupEntity?> onShiftChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OverlayDropdownFormField<PlanLookupEntity>(
          key: ValueKey(
            'emdad-unit-${emdadUnit?.resolvedId}-${state.emdadUnits.length}',
          ),
          labelText: 'واحد امدادی',
          mandatory: true,
          items: state.emdadUnits,
          value: emdadUnit,
          itemTitleBuilder: (item) => item.displayTitle,
          validator: _requiredLookup,
          onChanged: onEmdadUnitChanged,
        ),
        Space.h16,
        OverlayDropdownFormField<PlanLookupEntity>(
          key: ValueKey('shift-${shift?.resolvedId}-${state.shifts.length}'),
          labelText: 'شیفت',
          mandatory: true,
          items: state.shifts,
          value: shift,
          itemTitleBuilder: (item) => item.displayTitle,
          validator: _requiredLookup,
          onChanged: onShiftChanged,
        ),
        Space.h16,
        DatePickerWidget(
          controller: fromDateController,
          labelText: 'تاریخ شروع',
          hintText: 'انتخاب تاریخ',
          mandatory: true,
          lastDate: Jalali(1500, 12, 29),
          validator: _requiredText,
        ),
        Space.h16,
        DatePickerWidget(
          controller: toDateController,
          labelText: 'تاریخ پایان',
          hintText: 'انتخاب تاریخ',
          mandatory: true,
          lastDate: Jalali(1500, 12, 29),
          validator: _requiredText,
        ),
      ],
    );
  }
}

class _PlanTypeFields extends StatelessWidget {
  const _PlanTypeFields({
    required this.state,
    required this.hasSpecialPlan,
    required this.specialPlan,
    required this.seatType,
    required this.onSpecialPlanSwitchChanged,
    required this.onSpecialPlanChanged,
    required this.onSeatTypeChanged,
  });

  final PlanInfoState state;
  final bool hasSpecialPlan;
  final PlanLookupEntity? specialPlan;
  final PlanLookupEntity? seatType;
  final ValueChanged<bool> onSpecialPlanSwitchChanged;
  final ValueChanged<PlanLookupEntity?> onSpecialPlanChanged;
  final ValueChanged<PlanLookupEntity?> onSeatTypeChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppCheckboxWidget(
          title: 'دارای طرح ویژه',
          value: hasSpecialPlan,
          onChanged: onSpecialPlanSwitchChanged,
          padding: EdgeInsets.zero,
        ),
        if (hasSpecialPlan) ...[
          Space.h16,
          OverlayDropdownFormField<PlanLookupEntity>(
            key: ValueKey(
              'special-plan-${specialPlan?.resolvedId}-${state.specialPlans.length}',
            ),
            labelText: 'طرح',
            mandatory: true,
            items: state.specialPlans,
            value: specialPlan,
            itemTitleBuilder: (item) => item.displayTitle,
            validator: _requiredLookup,
            onChanged: onSpecialPlanChanged,
          ),
        ],
        Space.h16,
        OverlayDropdownFormField<PlanLookupEntity>(
          key: ValueKey(
            'seat-type-${seatType?.resolvedId}-${state.seatTypes.length}',
          ),
          labelText: 'نوع مقر',
          mandatory: true,
          items: state.seatTypes,
          value: seatType,
          itemTitleBuilder: (item) => item.displayTitle,
          validator: _requiredLookup,
          onChanged: onSeatTypeChanged,
        ),
      ],
    );
  }
}

class _PlanLocationFields extends StatelessWidget {
  const _PlanLocationFields({
    required this.locations,
    required this.location,
    required this.addressController,
    required this.onLocationChanged,
  });

  final List<PlanLookupEntity> locations;
  final PlanLookupEntity? location;
  final TextEditingController addressController;
  final ValueChanged<PlanLookupEntity?> onLocationChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final latitude = location?.latitude;
    final longitude = location?.longitude;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OverlayDropdownFormField<PlanLookupEntity>(
          key: ValueKey('location-${location?.resolvedId}-${locations.length}'),
          labelText: 'محل استقرار',
          mandatory: true,
          items: locations,
          value: location,
          itemTitleBuilder: (item) => item.displayTitle,
          validator: _requiredLookup,
          onChanged: onLocationChanged,
        ),
        Space.h16,
        AbsorbPointer(
          child: TextFormFieldWidget(
            controller: addressController,
            labelText: 'آدرس',
            readOnly: true,
            maxLines: 2,
            hintText: 'پس از انتخاب محل استقرار نمایش داده می‌شود',
            backgroundColor: colorScheme.surfaceContainerHighest,
            borderColor: colorScheme.outlineVariant,
          ),
        ),
        Space.h16,
        _PlanLocationMap(
          latitude: latitude,
          longitude: longitude,
        ),
        if (latitude != null && longitude != null) ...[
          Space.h12,
          BodySmallText(
            text: 'عرض: $latitude   طول: $longitude',
            color: colorScheme.onSurfaceVariant,
          ),
        ],
      ],
    );
  }
}

class _PlanLocationMap extends StatelessWidget {
  const _PlanLocationMap({
    required this.latitude,
    required this.longitude,
  });

  final double? latitude;
  final double? longitude;

  @override
  Widget build(BuildContext context) {
    if (_hasValidLocation) {
      return SingleLocationMapWidget(
        latitude: latitude,
        longitude: longitude,
        markerStyle: MarkerStyle(iconPath: SvgManager.location),
        height: AppSize.s220,
        initialZoom: 14,
      );
    }

    return SizedBox(
      height: AppSize.s220,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSize.s8),
        child: BlocProvider(
          create: (_) => getIt<MapCubit>()..init(),
          child: const MapWidget(),
        ),
      ),
    );
  }

  bool get _hasValidLocation {
    final lat = latitude;
    final lng = longitude;
    return lat != null &&
        lng != null &&
        lat.isFinite &&
        lng.isFinite &&
        lat >= -90 &&
        lat <= 90 &&
        lng >= -180 &&
        lng <= 180;
  }
}

String? _requiredText(String? value) {
  return value?.trim().isNotEmpty == true ? null : 'این فیلد اجباری است';
}

String? _requiredLookup(PlanLookupEntity? value) {
  return value?.resolvedId != null ? null : 'این فیلد اجباری است';
}
