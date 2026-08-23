import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_form_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_navgan_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/cubit/vehicle_model_cubit.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/cubit/vehicle_model_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/overlay_dropdown_form_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/sticky_form_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/app_checkbox_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
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
  late bool _hasDepot;

  @override
  void initState() {
    super.initState();
    final item = widget.item;
    _codeController = TextEditingController(text: item?.code);
    _nameController = TextEditingController(text: item?.name);
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
            context.read<VehicleModelCubit>().clearErrorMessage();
          }
        },
        builder: (context, state) {
          _selectedNavgan ??= _initialNavgan(state.navgans);
          return Scaffold(
            backgroundColor: theme.colorScheme.surface,
            appBar: SimpleAppBar(
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
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.all(AppPadding.p16),
                    child: FormSectionContainer(
                      padding: const EdgeInsets.all(AppPadding.p16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.directions_car_outlined,
                                color: theme.colorScheme.primary,
                              ),
                              Space.w8,
                              BodyMediumText(
                                text: 'اطلاعات نوع خودرو',
                                color: theme.colorScheme.onSurface,
                                fontWeight: FontWeight.w800,
                                fontSize: AppSize.s16,
                              ),
                            ],
                          ),
                          Space.h20,
                          TextFormFieldWidget(
                            controller: _codeController,
                            labelText: 'کد',
                            mandatory: true,
                            validator: _required,
                          ),
                          Space.h16,
                          TextFormFieldWidget(
                            controller: _nameController,
                            labelText: 'عنوان',
                            mandatory: true,
                            validator: _required,
                          ),
                          Space.h16,
                          OverlayDropdownFormField<VehicleNavganEntity>(
                            key: ValueKey(
                              'form-navgan-${_selectedNavgan?.id}-${state.navgans.length}',
                            ),
                            labelText: 'نوع ناوگان',
                            mandatory: true,
                            items: state.navgans,
                            value: _selectedNavgan,
                            enabled: state.navgans.isNotEmpty,
                            hintText: state.isNavgansLoading
                                ? 'در حال دریافت...'
                                : 'انتخاب کنید',
                            validator: (item) =>
                                item == null ? 'این فیلد الزامی است.' : null,
                            onChanged: (item) =>
                                setState(() => _selectedNavgan = item),
                          ),
                          Space.h16,
                          AppCheckboxWidget(
                            title: 'مجهز به انبارک',
                            value: _hasDepot,
                            onChanged: (value) =>
                                setState(() => _hasDepot = value),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: StickyFormActionBar(
              submitTitle: isEdit ? 'ثبت ویرایش' : 'ثبت نوع خودرو',
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
            isActive: widget.item?.isActive ?? true,
            hasDepot: _hasDepot,
          ),
        );
    if (context.mounted && success) context.pop(true);
  }
}
