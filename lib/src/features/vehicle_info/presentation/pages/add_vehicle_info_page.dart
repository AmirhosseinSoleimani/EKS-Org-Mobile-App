import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/params/create_or_edit_vehicle_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/cubit/vehicle_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/vehicle_info_form/vehicle_info_form_scaffold.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/vehicle_info_form/vehicle_info_form_sections.dart';
import 'package:eks_sana_plus_org/src/shared/input_formatter/persian_arabic_digits_to_english_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddVehicleInfoPage extends StatelessWidget {
  const AddVehicleInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<VehicleInfoCubit>()..loadLookups(onlyActive: true),
      child: const _AddVehicleInfoView(),
    );
  }
}

class _AddVehicleInfoView extends StatefulWidget {
  const _AddVehicleInfoView();

  @override
  State<_AddVehicleInfoView> createState() => _AddVehicleInfoViewState();
}

class _AddVehicleInfoViewState extends State<_AddVehicleInfoView> {
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
    return WillPopScope(
      onWillPop: () async {
        context.pop();
        return false;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocConsumer<VehicleInfoCubit, VehicleInfoState>(
          listener: _listenToState,
          builder: (context, state) {
            final data = state.data;
            final isReady = data.vehicleModels.isNotEmpty;
            final isInitialIdle = state.when(
              idle: (_) => true,
              loading: (_) => false,
              loaded: (_) => false,
              success: (_) => false,
              failure: (_) => false,
              connectionError: (_) => false,
            );
            final isLoading = !isReady && (isInitialIdle || data.isLookupsLoading);
            final isFailed = !data.isLookupsLoading && !isReady;

            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              body: SafeArea(
                child: Column(
                  children: [
                    VehicleInfoFormHeader(
                      title: 'افزودن خودروی جدید',
                      onClose: () => context.pop(),
                    ),
                    Expanded(
                      child: _buildBody(
                        context: context,
                        state: state,
                        isLoading: isLoading,
                        isFailed: isFailed,
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: isReady
                  ? VehicleInfoFormActions(
                      submitTitle: 'افزودن',
                      isSubmitting: data.isSubmitting,
                      onCancel: () => context.pop(),
                      onSubmit: () => _submit(context.read<VehicleInfoCubit>()),
                    )
                  : null,
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody({
    required BuildContext context,
    required VehicleInfoState state,
    required bool isLoading,
    required bool isFailed,
  }) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (isFailed) {
      return VehicleInfoFormLoadError(
        onRetry: () => context.read<VehicleInfoCubit>().loadLookups(
              onlyActive: true,
            ),
      );
    }

    final vehicleModels = state.data.vehicleModels;
    final selectedModel = _selectedModel(vehicleModels);

    return Form(
      key: _formKey,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(
            AppPadding.p16,
            AppPadding.p16,
            AppPadding.p16,
            AppPadding.p24,
          ),
          child: Column(
            children: [
              VehicleMainInfoSection(
                vehicleModels: vehicleModels,
                selectedVehicleModelTitle: selectedVehicleModelTitle(
                  selectedModel,
                ),
                onVehicleModelChanged: (value) {
                  setState(() {
                    _vehicleModelId = _vehicleModelIdByTitle(
                      vehicleModels,
                      value,
                    );
                    _isDepotEnabled = false;
                    _tashimType = null;
                  });
                },
                chassisController: _chassisController,
                engineController: _engineController,
                productYearController: _productYearController,
                statusTitle: _isActive ? 'فعال' : 'غیرفعال',
                onStatusChanged: (value) {
                  setState(() {
                    _isActive = value != 'غیرفعال';
                  });
                },
                requiredValidator: _requiredValidator,
              ),
              Space.h8,
              VehicleSimCardSection(
                imeiController: _imeiIdController,
                installDateController: _installDateController,
                requiredValidator: _requiredValidator,
                numberFormatters: _numberFormatters,
              ),
              Space.h8,
              VehiclePlateOptionsSection(
                plateController: _plateController,
                hasTroubleShooter: _isTroubleShooter,
                onTroubleShooterChanged: (value) {
                  setState(() => _isTroubleShooter = value);
                },
                hasDepot: selectedModel?.hasDepot == true,
                isDepotEnabled: _isDepotEnabled,
                onDepotEnabledChanged: (value) {
                  setState(() {
                    _isDepotEnabled = value;
                    if (!value) _tashimType = null;
                  });
                },
                tashimTitle: _tashimTitle(_tashimType),
                onTashimChanged: (value) {
                  setState(() => _tashimType = _tashimTypeByTitle(value));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _listenToState(BuildContext context, VehicleInfoState state) {
    final data = state.data;

    final errorMessage = data.errorMessage;
    if (errorMessage?.isNotEmpty == true) {
      _showError(context, errorMessage!);
      return;
    }

    final successMessage = data.successMessage;
    if (successMessage?.isNotEmpty == true) {
      context.pop(successMessage);
    }
  }

  VehicleModelEntity? _selectedModel(List<VehicleModelEntity> models) {
    for (final model in models) {
      if (model.id == _vehicleModelId) return model;
    }
    return null;
  }

  int? _vehicleModelIdByTitle(
    List<VehicleModelEntity> models,
    String title,
  ) {
    if (title == 'انتخاب کنید') return null;

    for (final model in models) {
      if (model.title == title) return model.id;
    }
    return null;
  }

  String _tashimTitle(int? value) {
    if (value == 1) return 'براساس نمایندگی';
    if (value == 2) return 'براساس خودرو';
    return 'انتخاب کنید';
  }

  int? _tashimTypeByTitle(String title) {
    if (title == 'براساس نمایندگی') return 1;
    if (title == 'براساس خودرو') return 2;
    return null;
  }

  String? _requiredValidator(String label, String? value) {
    if (value == null || value.trim().isEmpty) {
      return '$label را وارد کنید';
    }
    return null;
  }

  void _submit(VehicleInfoCubit cubit) {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      _showError(context, 'لطفا فیلدهای اجباری را تکمیل کنید.');
      return;
    }

    if (_vehicleModelId == null) {
      _showError(context, 'نوع خودرو را انتخاب کنید.');
      return;
    }

    if (_isDepotEnabled && _tashimType == null) {
      _showError(context, 'مدل تسهیم انبارک را انتخاب کنید.');
      return;
    }

    final imeiId = int.tryParse(_imeiIdController.text.trim());
    if (imeiId == null) {
      _showError(context, 'IMEI صحیح نیست.');
      return;
    }

    cubit.save(
      CreateOrEditVehicleParamEntity(
        imeiId: imeiId,
        licensePlate: _plateController.text.trim(),
        chassisNumber: _chassisController.text.trim(),
        engineNumber: _engineController.text.trim(),
        isActive: _isActive,
        productYear: _productYearController.text.trim(),
        vehicleModelId: _vehicleModelId!,
        installTypeDate: _installDateController.text.trim(),
        isTroubleShooter: _isTroubleShooter,
        isDepotEnabled: _isDepotEnabled,
        tashimType: _isDepotEnabled ? _tashimType : 2,
      ),
    );
  }

  void _showError(BuildContext context, String message) {
    BottomSheetMessage.showError(
      context: context,
      data: BottomSheetMessageModel(
        title: 'خطا',
        message: message.trim().isEmpty ? 'عملیات با خطا مواجه شد.' : message,
      ),
      onButtonTap: () => context.pop(),
    );
  }

  List<TextInputFormatter> get _numberFormatters {
    return [
      PersianArabicDigitsToEnglishFormatter(),
      FilteringTextInputFormatter.digitsOnly,
    ];
  }
}
