import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/params/create_or_edit_vehicle_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/cubit/vehicle_info_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/car_license_plate_widget/car_license_plate_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VehicleInfoFormPage extends StatelessWidget {
  static const path = '/vehicle-info-form-page';
  static const name = 'vehicle-info-form-page';

  const VehicleInfoFormPage({super.key, this.id});

  final int? id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<VehicleInfoCubit>()..loadLookups(onlyActive: true);
        if (id != null) cubit.loadDetail(id!);
        return cubit;
      },
      child: _VehicleInfoFormView(id: id),
    );
  }
}

class _VehicleInfoFormView extends StatefulWidget {
  const _VehicleInfoFormView({this.id});
  final int? id;

  @override
  State<_VehicleInfoFormView> createState() => _VehicleInfoFormViewState();
}

class _VehicleInfoFormViewState extends State<_VehicleInfoFormView> {
  final _formKey = GlobalKey<FormState>();
  final _plateController = TextEditingController();
  final _chassisController = TextEditingController();
  final _engineController = TextEditingController();
  final _productYearController = TextEditingController();
  final _imeiIdController = TextEditingController();
  final _installDateController = TextEditingController();
  int? _vehicleModelId;
  bool _isActive = true;
  bool _isTroubleShooter = false;
  bool _isDepotEnabled = false;
  int? _tashimType;
  bool _patched = false;

  @override
  void dispose() {
    _plateController.dispose();
    _chassisController.dispose();
    _engineController.dispose();
    _productYearController.dispose();
    _imeiIdController.dispose();
    _installDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VehicleInfoCubit>();

    return BlocListener<VehicleInfoCubit, VehicleInfoState>(
      listener: (context, state) {
        final data = state.data;
        if (!_patched && data.selectedItem != null) {
          _patched = true;
          final item = data.selectedItem!;
          _vehicleModelId = item.vehicleModelId;
          _plateController.text = item.licensePlate ?? '';
          _chassisController.text = item.chassisNumber ?? '';
          _engineController.text = item.engineNumber ?? '';
          _productYearController.text = item.productYear ?? '';
          _imeiIdController.text = item.imeiId?.toString() ?? '';
          _installDateController.text = item.installTypeDate ?? '';
          _isActive = item.isActive ?? true;
          _isTroubleShooter = item.isTroubleShooter ?? false;
          _isDepotEnabled = item.isDepotEnabled ?? false;
          _tashimType = item.tashimType;
        }
        if (data.errorMessage?.isNotEmpty == true) {
          SnakeBarWidget.showError(context: context, message: data.errorMessage!);
        }
        if (data.successMessage?.isNotEmpty == true) {
          SnakeBarWidget.showSuccess(context: context, message: data.successMessage!);
          context.pop(true);
        }
      },
      child: Scaffold(
        appBar: SimpleAppBar(title: widget.id == null ? 'ثبت خودرو جدید' : 'ویرایش خودرو'),
        bottomNavigationBar: BlocBuilder<VehicleInfoCubit, VehicleInfoState>(
          builder: (context, state) {
            return SafeArea(
              minimum: const EdgeInsets.all(AppPadding.p16),
              child: InkwellButtonWidget(
                title: widget.id == null ? 'ثبت' : 'ویرایش',
                showLoading: state.data.isSubmitting,
                onTap: () => _submit(cubit),
              ),
            );
          },
        ),
        body: BlocBuilder<VehicleInfoCubit, VehicleInfoState>(
          builder: (context, state) {
            if (state.data.loadingDetailId != null || (state.data.isLookupsLoading && state.data.vehicleModels.isEmpty)) {
              return const Center(child: CircularProgressIndicator());
            }
            final selectedModel = _selectedModel(state.data.vehicleModels);
            final hasDepot = selectedModel?.hasDepot == true;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    DropdownButtonFormField<int>(
                      value: _vehicleModelId,
                      isExpanded: true,
                      decoration: const InputDecoration(labelText: 'نوع خودرو'),
                      validator: (value) => value == null ? 'انتخاب نوع خودرو اجباری است' : null,
                      items: state.data.vehicleModels
                          .map((item) => DropdownMenuItem(value: item.id, child: Text(item.title)))
                          .toList(),
                      onChanged: (value) => setState(() {
                        _vehicleModelId = value;
                        _isDepotEnabled = false;
                        _tashimType = null;
                      }),
                    ),
                    TextFormField(controller: _chassisController, decoration: const InputDecoration(labelText: 'شاسی'), validator: _required),
                    TextFormField(controller: _engineController, decoration: const InputDecoration(labelText: 'شماره موتور'), validator: _required),
                    TextFormField(controller: _productYearController, decoration: const InputDecoration(labelText: 'سال ساخت'), validator: _required),
                    TextFormField(controller: _imeiIdController, decoration: const InputDecoration(labelText: 'شناسه IMEI'), keyboardType: TextInputType.number, validator: _required),
                    TextFormField(controller: _installDateController, decoration: const InputDecoration(labelText: 'تاریخ نصب IMEI'), validator: _required),
                    Space.h16,
                    LicensePlateTextFormFieldWidget(controller: _plateController, mandatory: true),
                    SwitchListTile(
                      value: _isActive,
                      title: const Text('فعال'),
                      onChanged: (value) => setState(() => _isActive = value),
                    ),
                    SwitchListTile(
                      value: _isTroubleShooter,
                      title: const Text('دستگاه عیب یاب دارد'),
                      onChanged: (value) => setState(() => _isTroubleShooter = value),
                    ),
                    if (hasDepot)
                      SwitchListTile(
                        value: _isDepotEnabled,
                        title: const Text('انبارک فعال است'),
                        onChanged: (value) => setState(() => _isDepotEnabled = value),
                      ),
                    if (hasDepot && _isDepotEnabled)
                      DropdownButtonFormField<int>(
                        value: _tashimType,
                        decoration: const InputDecoration(labelText: 'مدل تسهیم انبارک'),
                        validator: (value) => value == null || value == 0 ? 'مدل تسهیم انبارک اجباری است' : null,
                        items: const [
                          DropdownMenuItem(value: 1, child: Text('براساس نمایندگی')),
                          DropdownMenuItem(value: 2, child: Text('براساس خودرو')),
                        ],
                        onChanged: (value) => setState(() => _tashimType = value),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  VehicleModelEntity? _selectedModel(List<VehicleModelEntity> models) {
    for (final model in models) {
      if (model.id == _vehicleModelId) return model;
    }
    return null;
  }

  String? _required(String? value) => value?.trim().isNotEmpty == true ? null : 'پر کردن این فیلد الزامی است';

  void _submit(VehicleInfoCubit cubit) {
    if (_formKey.currentState?.validate() != true || _vehicleModelId == null) return;
    final imeiId = int.tryParse(_imeiIdController.text.trim());
    if (imeiId == null) {
      SnakeBarWidget.showError(context: context, message: 'شناسه IMEI صحیح نیست');
      return;
    }
    cubit.save(CreateOrEditVehicleParamEntity(
      id: widget.id,
      imeiId: imeiId,
      licensePlate: _plateController.text,
      chassisNumber: _chassisController.text,
      engineNumber: _engineController.text,
      isActive: _isActive,
      productYear: _productYearController.text,
      vehicleModelId: _vehicleModelId!,
      installTypeDate: _installDateController.text,
      isTroubleShooter: _isTroubleShooter,
      isDepotEnabled: _isDepotEnabled,
      tashimType: _isDepotEnabled ? _tashimType : 2,
    ));
  }
}
