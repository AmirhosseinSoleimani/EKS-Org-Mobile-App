import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_form_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_navgan_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/cubit/vehicle_model_cubit.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/cubit/vehicle_model_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/app_checkbox_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VehicleModelFormPageArgs {
  const VehicleModelFormPageArgs({this.item});

  final VehicleModelEntity? item;
}

class VehicleModelFormPage extends StatelessWidget {
  static const path = '/vehicle-model-form-page';
  static const name = 'vehicle-model-form-page';

  const VehicleModelFormPage({super.key, this.item});

  final VehicleModelEntity? item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<VehicleModelCubit>()..fetchNavgans(),
      child: _VehicleModelFormView(item: item),
    );
  }
}

class _VehicleModelFormView extends StatefulWidget {
  const _VehicleModelFormView({this.item});

  final VehicleModelEntity? item;

  @override
  State<_VehicleModelFormView> createState() => _VehicleModelFormViewState();
}

class _VehicleModelFormViewState extends State<_VehicleModelFormView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _codeController;
  late final TextEditingController _nameController;
  VehicleNavganEntity? _selectedNavgan;
  late bool _isActive;
  late bool _hasDepot;

  @override
  void initState() {
    super.initState();
    final item = widget.item;
    _codeController = TextEditingController(text: item?.code);
    _nameController = TextEditingController(text: item?.name);
    _isActive = item?.isActive ?? true;
    _hasDepot = item?.hasDepot ?? false;
  }

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEdit = widget.item != null;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<VehicleModelCubit, VehicleModelState>(
        listener: (context, state) {
          final error = state.errorMessage;
          if (error?.trim().isNotEmpty == true) {
            SnakeBarWidget.showError(context: context, message: error!);
          }
          final success = state.successMessage;
          if (success?.trim().isNotEmpty == true) {
            SnakeBarWidget.showSuccess(context: context, message: success!);
          }
        },
        builder: (context, state) {
          _selectedNavgan ??= _initialNavgan(state.navgans);
          return Scaffold(
            backgroundColor: theme.colorScheme.surface,
            appBar: SimpleActionBar(
              title: isEdit ? 'ویرایش نوع خودرو' : 'نوع خودرو جدید',
            ),
            body: SafeArea(
              top: false,
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(AppPadding.p16),
                    children: [
                      TextFormFieldWidget(
                        controller: _codeController,
                        labelText: 'کد',
                        mandatory: true,
                        validator: _required,
                      ),
                      Space.h16,
                      TextFormFieldWidget(
                        controller: _nameController,
                        labelText: 'نام',
                        mandatory: true,
                        validator: _required,
                      ),
                      Space.h16,
                      EkDropDown(
                        _navganTitles(state.navgans),
                        label: 'نوع ناوگان',
                        mandatory: true,
                        selectedItem: _selectedNavgan?.title,
                        onItemValue: (value) => setState(() {
                          _selectedNavgan = state.navgans.firstWhere(
                            (item) => item.title == value,
                            orElse: () => const VehicleNavganEntity(),
                          );
                        }),
                      ),
                      Space.h16,
                      AppCheckboxWidget(
                        title: 'فعال',
                        value: _isActive,
                        onChanged: (value) => setState(() => _isActive = value),
                      ),
                      AppCheckboxWidget(
                        title: 'دپو دارد',
                        value: _hasDepot,
                        onChanged: (value) => setState(() => _hasDepot = value),
                      ),
                      Space.h32,
                      InkwellButtonWidget(
                        title: isEdit ? 'ثبت ویرایش' : 'ثبت نوع خودرو',
                        showLoading: state.isFormSubmitting,
                        onTap: state.isFormSubmitting ? null : () => _submit(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<String> _navganTitles(List<VehicleNavganEntity> items) {
    final titles = items
        .map((item) => item.title ?? '')
        .where((item) => item.trim().isNotEmpty)
        .toList();
    return titles.isEmpty ? const ['انتخاب کنید'] : titles;
  }

  VehicleNavganEntity? _initialNavgan(List<VehicleNavganEntity> navgans) {
    final id = widget.item?.navganTypeId;
    if (id == null) return navgans.isEmpty ? null : navgans.first;
    for (final navgan in navgans) {
      if (navgan.id == id) return navgan;
    }
    return navgans.isEmpty ? null : navgans.first;
  }

  String? _required(String? value) {
    return value?.trim().isEmpty ?? true ? 'این فیلد الزامی است.' : null;
  }

  Future<void> _submit(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final navganId = _selectedNavgan?.id;
    if (navganId == null) {
      SnakeBarWidget.showError(
        context: context,
        message: 'نوع ناوگان را انتخاب کنید.',
      );
      return;
    }

    final success = await context.read<VehicleModelCubit>().submitForm(
          VehicleModelFormParamEntity(
            id: widget.item?.id,
            code: _codeController.text.trim(),
            name: _nameController.text.trim(),
            navganTypeId: navganId,
            isActive: _isActive,
            hasDepot: _hasDepot,
          ),
        );
    if (context.mounted && success) context.pop(true);
  }
}
