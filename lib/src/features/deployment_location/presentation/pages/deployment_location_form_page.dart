import 'dart:ui';

import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/params/deployment_location_form_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/presentation/cubit/deployment_location_cubit.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/presentation/cubit/deployment_location_state.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/presentation/widgets/deployment_location_area_fields.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/presentation/widgets/deployment_location_area_utils.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/presentation/widgets/deployment_location_form_app_bar.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/presentation/widgets/deployment_location_map_selector.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/address_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/bottom_sheet/selectable_map_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/overlay_dropdown_form_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/sticky_form_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DeploymentLocationFormPageArgs {
  const DeploymentLocationFormPageArgs({this.id});

  final int? id;
}

class DeploymentLocationFormPage extends StatelessWidget {
  static const path = '/deployment-location-form-page';
  static const name = 'deployment-location-form-page';

  const DeploymentLocationFormPage({super.key, this.locationId});

  final int? locationId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DeploymentLocationCubit>()
        ..initializeForm(id: locationId),
      child: _DeploymentLocationFormView(locationId: locationId),
    );
  }
}

class _DeploymentLocationFormView extends StatefulWidget {
  const _DeploymentLocationFormView({this.locationId});

  final int? locationId;

  @override
  State<_DeploymentLocationFormView> createState() =>
      _DeploymentLocationFormViewState();
}

class _DeploymentLocationFormViewState
    extends State<_DeploymentLocationFormView> {
  static const _statusItems = <SimpleDropdownItem<bool>>[
    SimpleDropdownItem<bool>(value: true, label: 'فعال'),
    SimpleDropdownItem<bool>(value: false, label: 'غیرفعال'),
  ];

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _addressController;
  ProvinceEntity? _selectedProvince;
  ProvinceEntity? _selectedCity;
  bool _isActive = true;
  double? _latitude;
  double? _longitude;
  bool _hasSelectedLocation = false;
  bool _didInitialize = false;

  bool get _isEdit => widget.locationId != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _addressController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<DeploymentLocationCubit, DeploymentLocationState>(
        listener: (context, state) {
          final error = state.errorMessage;
          if (error?.trim().isNotEmpty == true) {
            SnakeBarWidget.showError(context: context, message: error!);
            context.read<DeploymentLocationCubit>().clearErrorMessage();
          }
        },
        builder: (context, state) {
          _syncInitialValues(state);
          final selectedStatus = _statusItems.firstWhere(
            (item) => item.value == _isActive,
          );

          return Scaffold(
            backgroundColor: theme.colorScheme.surface,
            appBar: DeploymentLocationFormAppBar(
              title: _isEdit
                  ? 'ویرایش محل استقرار'
                  : 'محل استقرار جدید',
              onClose: () {
                if (state.isFormSubmitting) return;
                context.pop(false);
              },
            ),
            body: _buildBody(context, state, selectedStatus),
            bottomNavigationBar:
                state.isFormLoading || state.formLoadFailed
                    ? null
                    : StickyFormActionBar(
                        submitTitle: 'ثبت',
                        cancelTitle: 'انصراف',
                        isSubmitting: state.isFormSubmitting,
                        onCancel: () {
                          if (state.isFormSubmitting) return;
                          context.pop(false);
                        },
                        onSubmit: () {
                          if (state.isFormSubmitting) return;
                          _submit(context);
                        },
                      ),
          );
        },
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    DeploymentLocationState state,
    SimpleDropdownItem<bool> selectedStatus,
  ) {
    if (state.isFormLoading) {
      return const Center(child: LoadingWidget());
    }

    if (state.formLoadFailed) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const EmptyListWidget(),
            Space.h12,
            SizedBox(
              width: AppSize.s150,
              child: InkwellButtonWidget(
                title: 'تلاش مجدد',
                onTap: () {
                  context.read<DeploymentLocationCubit>().initializeForm(
                    id: widget.locationId,
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    return SafeArea(
      top: false,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.stylus,
          },
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(AppPadding.p16),
            child: FormSectionContainer(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormFieldWidget(
                    controller: _titleController,
                    labelText: 'عنوان',
                    hintText: 'عنوان محل استقرار را وارد کنید',
                    mandatory: true,
                    validator: _required,
                  ),
                  Space.h16,
                  DeploymentLocationAreaFields(
                    provinceCities: state.provinceCities,
                    selectedProvince: _selectedProvince,
                    selectedCity: _selectedCity,
                    isLoading: state.isAreasLoading,
                    onProvinceChanged: (item) {
                      setState(() {
                        _selectedProvince = item;
                        _selectedCity = null;
                      });
                    },
                    onCityChanged: (item) {
                      setState(() {
                        _selectedCity = item;
                        if (!_hasSelectedLocation && item != null) {
                          _latitude = item.latitude ?? _latitude;
                          _longitude = item.longitude ?? _longitude;
                        }
                      });
                    },
                  ),
                  Space.h16,
                  TextFormFieldWidget(
                    controller: _addressController,
                    labelText: 'آدرس',
                    mandatory: true,
                    maxLines: 4,
                    validator: _required,
                  ),
                  Space.h16,
                  OverlayDropdownFormField<SimpleDropdownItem<bool>>(
                    key: ValueKey('location-status-$_isActive'),
                    labelText: 'وضعیت',
                    mandatory: true,
                    items: _statusItems,
                    value: selectedStatus,
                    onChanged: (item) {
                      if (item == null) return;
                      setState(() => _isActive = item.value);
                    },
                  ),
                  Space.h20,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: AppSize.s18,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      Space.w8,
                      const Expanded(
                        child: BodySmallText(
                          text: 'برای انتخاب موقعیت مکانی روی نقشه بزنید.',
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  Space.h12,
                  DeploymentLocationMapSelector(
                    latitude: _latitude,
                    longitude: _longitude,
                    hasSelectedLocation: _hasSelectedLocation,
                    onTap: () => _selectLocation(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _syncInitialValues(DeploymentLocationState state) {
    if (_didInitialize || state.isFormLoading) return;
    if (_isEdit && state.formLocation == null) return;

    final item = state.formLocation;
    _titleController.text = item?.title ?? '';
    _addressController.text = item?.address ?? '';
    _selectedProvince = findDeploymentLocationProvince(
      items: state.provinceCities,
      provinceId: item?.provinceId,
      provinceTitle: item?.provinceTitle,
    );
    _selectedCity = findDeploymentLocationCity(
      items: state.provinceCities,
      cityId: item?.cityId,
      cityTitle: item?.cityTitle,
    );
    _isActive = item?.isActive ?? true;
    _latitude = item?.latitude;
    _longitude = item?.longitude;
    _hasSelectedLocation = item?.hasCoordinates ?? false;
    _didInitialize = true;
  }

  String? _required(String? value) {
    return value?.trim().isEmpty ?? true ? 'این فیلد الزامی است.' : null;
  }

  Future<void> _selectLocation(BuildContext context) async {
    final initialLocation = _latitude != null && _longitude != null
        ? AddressInfoEntity(
            latitude: _latitude,
            longitude: _longitude,
            address: _addressController.text.trim(),
          )
        : null;

    final result = await SelectableMapBottomSheet.show(
      context: context,
      serviceType: ServiceType.reliefService,
      initialLocation: initialLocation,
    );
    if (!mounted || result == null) return;

    setState(() {
      _latitude = result.latitude;
      _longitude = result.longitude;
      _hasSelectedLocation =
          result.latitude != null && result.longitude != null;
      final selectedAddress = result.address?.trim();
      if (selectedAddress?.isNotEmpty == true) {
        _addressController.text = selectedAddress!;
      }
    });
  }

  Future<void> _submit(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final cityId = _selectedCity?.cityId;
    if (cityId == null) {
      SnakeBarWidget.showError(
        context: context,
        message: 'شهر را انتخاب کنید.',
      );
      return;
    }

    if (!_hasSelectedLocation || _latitude == null || _longitude == null) {
      SnakeBarWidget.showError(
        context: context,
        message: 'موقعیت محل استقرار را روی نقشه انتخاب کنید.',
      );
      return;
    }

    final success = await context.read<DeploymentLocationCubit>().submitForm(
          DeploymentLocationFormParamEntity(
            id: widget.locationId,
            title: _titleController.text.trim(),
            address: _addressController.text.trim(),
            latitude: _latitude!,
            longitude: _longitude!,
            cityId: cityId,
            isActive: _isActive,
          ),
        );

    if (context.mounted && success) context.pop(true);
  }
}
