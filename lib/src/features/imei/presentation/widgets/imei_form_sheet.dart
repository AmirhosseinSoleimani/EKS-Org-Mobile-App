import 'package:eks_sana_plus_org/src/features/imei/domain/entities/device_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/presentation/cubit/imei_cubit.dart';
import 'package:eks_sana_plus_org/src/features/imei/presentation/cubit/imei_state.dart';
import 'package:eks_sana_plus_org/src/shared/input_formatter/persian_arabic_digits_to_english_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/full_screen_bottom_sheet_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/overlay_dropdown_form_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/sticky_form_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImeiFormSheet extends StatelessWidget {
  const ImeiFormSheet({
    super.key,
    required this.isEdit,
  });

  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ImeiCubit>();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<ImeiCubit, ImeiState>(
        listenWhen: (previous, current) =>
            previous.isSubmitting != current.isSubmitting ||
            previous.successMessage != current.successMessage,
        listener: (context, state) {
          if (!state.isSubmitting &&
              state.successMessage?.trim().isNotEmpty == true) {
            Navigator.of(context).pop(true);
          }
        },
        builder: (context, state) {
          final theme = Theme.of(context);

          return Scaffold(
            backgroundColor: theme.colorScheme.surface,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: FullScreenBottomSheetAppBar(
                title: isEdit ? 'ویرایش IMEI' : 'ثبت IMEI جدید',
                onClose: () => Navigator.of(context).pop(false),
              ),
            ),
            body: SafeArea(
              top: false,
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.all(AppPadding.p16),
                child: Form(
                  key: cubit.formKey,
                  child: FormSectionContainer(
                    padding: const EdgeInsets.all(AppPadding.p16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.router_outlined,
                              color: theme.colorScheme.primary,
                            ),
                            Space.w8,
                            BodyMediumText(
                              text: 'اطلاعات دستگاه',
                              color: theme.colorScheme.onSurface,
                              fontWeight: FontWeight.w800,
                              fontSize: AppSize.s16,
                            ),
                          ],
                        ),
                        Space.h20,
                        OverlayDropdownFormField<DeviceInfoEntity>(
                          key: ValueKey(
                            'form-device-${cubit.selectedFormDevice?.id}',
                          ),
                          labelText: 'نوع دستگاه',
                          mandatory: true,
                          items: state.deviceTypes,
                          value: cubit.selectedFormDevice,
                          validator: (item) =>
                              item == null ? 'این فیلد اجباری است' : null,
                          onChanged: cubit.setFormDevice,
                        ),
                        Space.h16,
                        TextFormFieldWidget(
                          controller: cubit.simNumberController,
                          labelText: 'شماره سیم کارت',
                          mandatory: true,
                          validator: cubit.validateRequired,
                          textInputType: TextInputType.phone,
                          textInputFormatter: [
                            PersianArabicDigitsToEnglishFormatter(),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                        Space.h16,
                        TextFormFieldWidget(
                          controller: cubit.avlSerialController,
                          labelText: 'سریال دستگاه',
                          mandatory: true,
                          validator: cubit.validateRequired,
                        ),
                        Space.h16,
                        TextFormFieldWidget(
                          controller: cubit.imeiController,
                          labelText: 'IMEI',
                          mandatory: true,
                          validator: cubit.validateRequired,
                          textInputType: TextInputType.number,
                          textInputFormatter: [
                            PersianArabicDigitsToEnglishFormatter(),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                        Space.h16,
                        OverlayDropdownFormField<SimpleDropdownItem<bool>>(
                          key: ValueKey(
                            'form-status-${cubit.selectedFormStatus}',
                          ),
                          labelText: 'وضعیت',
                          mandatory: true,
                          items: _statusItems,
                          value: _selectedStatusItem(cubit.selectedFormStatus),
                          onChanged: (item) {
                            if (item != null) {
                              cubit.setFormStatus(item.value);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: StickyFormActionBar(
              submitTitle: 'ثبت',
              cancelTitle: 'انصراف',
              isSubmitting: state.isSubmitting,
              onCancel: () => Navigator.of(context).pop(false),
              onSubmit: () => cubit.submitForm(isEdit: isEdit),
            ),
          );
        },
      ),
    );
  }

  SimpleDropdownItem<bool> _selectedStatusItem(bool value) {
    return _statusItems.firstWhere(
      (item) => item.value == value,
      orElse: () => _statusItems.first,
    );
  }

  static const _statusItems = [
    SimpleDropdownItem<bool>(value: true, label: 'فعال'),
    SimpleDropdownItem<bool>(value: false, label: 'غیرفعال'),
  ];
}
