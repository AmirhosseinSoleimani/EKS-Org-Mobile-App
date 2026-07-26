import 'package:eks_sana_plus_org/src/features/imei/domain/entities/device_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/presentation/cubit/imei_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/input_formatter/persian_arabic_digits_to_english_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/overlay_dropdown_form_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ImeiFilterSheet extends StatelessWidget {
  const ImeiFilterSheet({super.key, required this.cubit});

  final ImeiCubit cubit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final devices = cubit.state.deviceTypes;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.only(
          left: AppPadding.p16,
          right: AppPadding.p16,
          top: AppPadding.p8,
          bottom: MediaQuery.of(context).viewInsets.bottom + AppPadding.p16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TitleLargeText(
              text: 'فیلترها',
              color: theme.colorScheme.onSurface,
              fontSize: AppSize.s18,
            ),
            Space.h16,
            OverlayDropdownFormField<DeviceInfoEntity>(
              key: ValueKey('filter-device-${cubit.selectedFilterDevice?.id}'),
              labelText: 'نوع دستگاه',
              items: devices,
              value: cubit.selectedFilterDevice,
              onChanged: cubit.setFilterDevice,
            ),
            Space.h16,
            TextFormFieldWidget(
              controller: cubit.filterSimNumberController,
              labelText: 'شماره سیم کارت',
              textInputType: TextInputType.phone,
              textInputFormatter: [
                PersianArabicDigitsToEnglishFormatter(),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            Space.h16,
            TextFormFieldWidget(
              controller: cubit.filterAvlSerialController,
              labelText: 'سریال دستگاه',
            ),
            Space.h16,
            TextFormFieldWidget(
              controller: cubit.filterImeiController,
              labelText: 'IMEI',
              textInputType: TextInputType.number,
              textInputFormatter: [
                PersianArabicDigitsToEnglishFormatter(),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            Space.h16,
            OverlayDropdownFormField<SimpleDropdownItem<bool>>(
              key: ValueKey('filter-status-${cubit.selectedFilterStatus}'),
              labelText: 'وضعیت',
              items: _statusItems,
              value: _selectedStatusItem(cubit.selectedFilterStatus),
              onChanged: (item) => cubit.setFilterStatus(item?.value),
            ),
            Space.h20,
            Row(
              children: [
                Expanded(
                  child: InkwellButtonWidget(
                    title: 'فیلتر',
                    onTap: () async {
                      await cubit.applyFilters();
                      if (context.mounted) context.pop();
                    },
                  ),
                ),
                Space.w12,
                Expanded(
                  child: InkwellButtonWidget(
                    title: 'پاک کردن همه فیلترها',
                    backgroundColor: theme.colorScheme.onPrimary,
                    titleColor: theme.colorScheme.onSurface,
                    borderColor: theme.colorScheme.outline,
                    onTap: () async {
                      await cubit.clearFilters();
                      if (context.mounted) context.pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SimpleDropdownItem<bool>? _selectedStatusItem(bool? value) {
    if (value == null) return null;
    for (final item in _statusItems) {
      if (item.value == value) return item;
    }
    return null;
  }

  static const _statusItems = [
    SimpleDropdownItem<bool>(value: true, label: 'فعال'),
    SimpleDropdownItem<bool>(value: false, label: 'غیرفعال'),
  ];
}
