import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_lookup_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/cubit/plan_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/cubit/plan_info_state.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/cubit/map_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/map_widget.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/marker_style.dart';
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
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class PlanInfoCreatePage extends StatelessWidget {
  static const path = '/plan-info-create';
  static const name = 'plan-info-create';

  final PlanInfoCreateMode mode;
  final PlanInfoEntity? initialPlan;

  const PlanInfoCreatePage({
    super.key,
    this.mode = PlanInfoCreateMode.create,
    this.initialPlan,
  });

  @override
  Widget build(BuildContext context) {
    final planId = initialPlan?.resolvedId;

    return BlocProvider(
      create: (_) => getIt<PlanInfoCubit>()..initCreatePage(planId: planId),
      child: _PlanInfoCreateView(
        mode: mode,
        initialPlan: initialPlan,
      ),
    );
  }
}

enum PlanInfoCreateMode {
  create,
  edit,
  copy;

  bool get isEdit => this == PlanInfoCreateMode.edit;

  bool get isCopy => this == PlanInfoCreateMode.copy;
}

class PlanInfoCreateArgs {
  final PlanInfoCreateMode mode;
  final PlanInfoEntity plan;

  const PlanInfoCreateArgs({
    required this.mode,
    required this.plan,
  });
}

class _PlanInfoCreateView extends StatefulWidget {
  const _PlanInfoCreateView({
    required this.mode,
    this.initialPlan,
  });

  final PlanInfoCreateMode mode;
  final PlanInfoEntity? initialPlan;

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
  PlanLookupEntity? _seatType;
  PlanLookupEntity? _specialPlan;
  PlanLookupEntity? _location;
  bool _hasSpecialPlan = false;
  bool _didApplyInitialPlan = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<PlanInfoCubit, PlanInfoState>(
        listenWhen: (previous, current) => previous.message != current.message,
        listener: _listenToState,
        builder: (context, state) {
          _applyInitialPlan(state);

          return Scaffold(
            backgroundColor: colorScheme.surface,
            appBar: SimpleActionBar(title: _pageTitle),
            body: _isInitialLoading(state)
                ? const Center(child: LoadingWidget())
                : SafeArea(
                    top: false,
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.fromLTRB(
                        AppPadding.p16,
                        AppPadding.p16,
                        AppPadding.p16,
                        AppPadding.p24,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _PlanFormSection(
                              title: 'اطلاعات برنامه ریزی',
                              icon: Icons.assignment_outlined,
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
                              title: 'نوع مقر',
                              icon: Icons.grid_on_outlined,
                              child: _PlanTypeFields(
                                state: state,
                                seatType: _seatType,
                                specialPlan: _specialPlan,
                                hasSpecialPlan: _hasSpecialPlan,
                                onSeatTypeChanged: (value) {
                                  setState(() => _seatType = value);
                                },
                                onSpecialPlanChanged: (value) {
                                  setState(() => _specialPlan = value);
                                },
                                onHasSpecialPlanChanged: (value) {
                                  setState(() {
                                    _hasSpecialPlan = value;
                                    if (!value) {
                                      _specialPlan = null;
                                    }
                                  });
                                },
                              ),
                            ),
                            Space.h16,
                            _PlanFormSection(
                              title: 'محل استقرار',
                              icon: Icons.location_on_outlined,
                              child: _PlanLocationFields(
                                locations: state.locations,
                                location: _location,
                                addressController: _addressController,
                                onLocationChanged: _onLocationChanged,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            bottomNavigationBar: StickyFormActionBar(
              submitTitle: _submitTitle,
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

  void _listenToState(BuildContext context, PlanInfoState state) {
    final message = state.message?.trim();
    if (message == null || message.isEmpty) {
      return;
    }

    if (state.status == PlanInfoStatus.error ||
        state.status == PlanInfoStatus.connectionError ||
        state.status == PlanInfoStatus.loading) {
      SnakeBarWidget.showError(context: context, message: message);
      return;
    }

    return;
  }

  bool _isInitialLoading(PlanInfoState state) {
    return state.status == PlanInfoStatus.loading &&
        state.emdadUnits.isEmpty &&
        state.shifts.isEmpty &&
        state.locations.isEmpty;
  }

  String get _pageTitle {
    return switch (widget.mode) {
      PlanInfoCreateMode.create => 'ثبت برنامه ریزی جدید',
      PlanInfoCreateMode.edit => 'ویرایش برنامه ریزی',
      PlanInfoCreateMode.copy => 'کپی برنامه ریزی',
    };
  }

  String get _submitTitle {
    return switch (widget.mode) {
      PlanInfoCreateMode.create => 'ثبت',
      PlanInfoCreateMode.edit => 'ویرایش',
      PlanInfoCreateMode.copy => 'ثبت کپی',
    };
  }

  void _onLocationChanged(PlanLookupEntity? value) {
    setState(() {
      _location = value;
      _addressController.text = value?.address?.trim() ?? '';
    });
  }

  void _applyInitialPlan(PlanInfoState state) {
    if (_didApplyInitialPlan || widget.mode == PlanInfoCreateMode.create) {
      return;
    }

    if (state.emdadUnits.isEmpty ||
        state.shifts.isEmpty ||
        state.locations.isEmpty) {
      return;
    }

    final plan = state.selectedPlan ?? widget.initialPlan;
    if (plan == null) {
      return;
    }

    _didApplyInitialPlan = true;
    _emdadUnit = _findLookup(state.emdadUnits, plan.emdadUnitId);
    _shift = _findLookup(state.shifts, plan.shiftId);
    _seatType = _findLookup(state.seatTypes, plan.seatType);
    _specialPlan = _findLookup(state.specialPlans, plan.specialPlanId);
    _location = _findLookup(state.locations, plan.locationId);
    _hasSpecialPlan = plan.specialPlanId != null;
    _fromDateController.text = plan.fromDateJalali ?? plan.fromDate ?? '';
    _toDateController.text = plan.toDateJalali ?? plan.toDate ?? '';
    _addressController.text =
        _location?.address?.trim() ?? plan.address?.trim() ?? '';
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    final isEdit = widget.mode.isEdit;
    final isCopy = widget.mode.isCopy;
    final planId =
        context.read<PlanInfoCubit>().state.selectedPlan?.resolvedId ??
            widget.initialPlan?.resolvedId;

    final saved = await context.read<PlanInfoCubit>().savePlan(
          id: planId,
          isEdit: isEdit,
          isCopy: isCopy,
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
    final colorScheme = Theme.of(context).colorScheme;

    return FormSectionContainer(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: AppSize.s22,
                color: colorScheme.primary,
              ),
              Space.w8,
              Expanded(
                child: TitleLargeText(
                  text: title,
                  color: colorScheme.onSurface,
                  fontSize: AppSize.s16,
                ),
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
        _PlanLookupDropdown(
          key: ValueKey(
            'emdad-unit-${emdadUnit?.resolvedId}-${state.emdadUnits.length}',
          ),
          labelText: 'واحد امدادی',
          items: state.emdadUnits,
          value: emdadUnit,
          onChanged: onEmdadUnitChanged,
        ),
        Space.h16,
        _PlanLookupDropdown(
          key: ValueKey(
            'shift-${shift?.resolvedId}-${state.shifts.length}',
          ),
          labelText: 'شیفت',
          items: state.shifts,
          value: shift,
          onChanged: onShiftChanged,
        ),
        Space.h16,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DatePickerWidget(
                controller: fromDateController,
                labelText: 'تاریخ شروع',
                hintText: 'انتخاب تاریخ',
                mandatory: true,
                lastDate: Jalali(1500, 12, 29),
                validator: _requiredText,
              ),
            ),
            Space.w8,
            Expanded(
              child: DatePickerWidget(
                controller: toDateController,
                labelText: 'تاریخ پایان',
                hintText: 'انتخاب تاریخ',
                mandatory: true,
                lastDate: Jalali(1500, 12, 29),
                validator: _requiredText,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PlanTypeFields extends StatelessWidget {
  const _PlanTypeFields({
    required this.state,
    required this.seatType,
    required this.specialPlan,
    required this.hasSpecialPlan,
    required this.onSeatTypeChanged,
    required this.onSpecialPlanChanged,
    required this.onHasSpecialPlanChanged,
  });

  final PlanInfoState state;
  final PlanLookupEntity? seatType;
  final PlanLookupEntity? specialPlan;
  final bool hasSpecialPlan;
  final ValueChanged<PlanLookupEntity?> onSeatTypeChanged;
  final ValueChanged<PlanLookupEntity?> onSpecialPlanChanged;
  final ValueChanged<bool> onHasSpecialPlanChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PlanLookupDropdown(
          key: ValueKey(
            'seat-type-${seatType?.resolvedId}-${state.seatTypes.length}',
          ),
          labelText: 'نوع مقر',
          items: state.seatTypes,
          value: seatType,
          onChanged: onSeatTypeChanged,
        ),
        Space.h12,
        AppCheckboxWidget(
          title: 'دارای طرح',
          value: hasSpecialPlan,
          padding: EdgeInsets.zero,
          onChanged: onHasSpecialPlanChanged,
        ),
        if (hasSpecialPlan) ...[
          Space.h16,
          _PlanLookupDropdown(
            key: ValueKey(
              'special-plan-${specialPlan?.resolvedId}-${state.specialPlans.length}',
            ),
            labelText: 'طرح ویژه',
            items: state.specialPlans,
            value: specialPlan,
            onChanged: onSpecialPlanChanged,
          ),
        ],
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _PlanLookupDropdown(
          key: ValueKey(
            'location-${location?.resolvedId}-${locations.length}',
          ),
          labelText: 'محل استقرار',
          items: locations,
          value: location,
          onChanged: onLocationChanged,
        ),
        Space.h16,
        AbsorbPointer(
          child: TextFormFieldWidget(
            controller: addressController,
            labelText: 'آدرس محل استقرار',
            hintText: 'پس از انتخاب محل استقرار نمایش داده می شود',
            readOnly: true,
            maxLines: 3,
            backgroundColor: colorScheme.surfaceContainerHighest,
            borderColor: colorScheme.outlineVariant,
          ),
        ),
        Space.h16,
        _PlanLocationMap(
          latitude: location?.latitude,
          longitude: location?.longitude,
        ),
      ],
    );
  }
}

class _PlanLookupDropdown extends StatelessWidget {
  const _PlanLookupDropdown({
    super.key,
    required this.labelText,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  final String labelText;
  final List<PlanLookupEntity> items;
  final PlanLookupEntity? value;
  final ValueChanged<PlanLookupEntity?> onChanged;

  @override
  Widget build(BuildContext context) {
    return OverlayDropdownFormField<PlanLookupEntity>(
      labelText: labelText,
      mandatory: true,
      items: items,
      value: value,
      enabled: items.isNotEmpty,
      hintText: items.isEmpty ? 'در حال دریافت...' : 'انتخاب کنید',
      itemTitleBuilder: (item) => item.displayTitle,
      validator: _requiredLookup,
      onChanged: onChanged,
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
    if (_hasValidCoordinates) {
      return SingleLocationMapWidget(
        key: ValueKey('plan-location-map-$latitude-$longitude'),
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
          child: const MapWidget(
            key: ValueKey('plan-default-tehran-map'),
          ),
        ),
      ),
    );
  }

  bool get _hasValidCoordinates {
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

PlanLookupEntity? _findLookup(List<PlanLookupEntity> items, int? id) {
  if (id == null) return null;
  for (final item in items) {
    if (item.resolvedId == id) return item;
  }
  return null;
}
