import 'package:eks_sana_plus_org/src/features/imei/domain/entities/device_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/presentation/cubit/imei_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/input_formatter/persian_arabic_digits_to_english_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ImeiFilterSheet extends StatelessWidget {
  const ImeiFilterSheet({super.key, required this.cubit});

  final ImeiCubit cubit;

  @override
  Widget build(BuildContext context) {
    final devices = cubit.state.deviceTypes;
    final deviceItems = <String>['همه', ...devices.map((item) => item.label)];

    return FilterBottomSheetScaffold(
      title: 'فیلترها',
      onApply: () => _apply(context),
      onClear: () => _clear(context),
      child: Column(
        children: [
          EkDropDown(
            deviceItems,
            label: 'نوع دستگاه',
            selectedItem: cubit.selectedFilterDevice?.label ?? 'همه',
            onItemValue: (value) {
              cubit.setFilterDevice(
                value == 'همه' ? null : _findDevice(devices, value),
              );
            },
          ),
          FilterBottomSheetScaffold.fieldGap,
          TextFormFieldWidget(
            controller: cubit.filterSimNumberController,
            labelText: 'شماره سیم کارت',
            textInputType: TextInputType.phone,
            textInputFormatter: [
              PersianArabicDigitsToEnglishFormatter(),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          FilterBottomSheetScaffold.fieldGap,
          TextFormFieldWidget(
            controller: cubit.filterAvlSerialController,
            labelText: 'سریال دستگاه',
          ),
          FilterBottomSheetScaffold.fieldGap,
          TextFormFieldWidget(
            controller: cubit.filterImeiController,
            labelText: 'IMEI',
            textInputType: TextInputType.number,
            textInputFormatter: [
              PersianArabicDigitsToEnglishFormatter(),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          FilterBottomSheetScaffold.fieldGap,
          EkDropDown(
            const ['همه', 'فعال', 'غیرفعال'],
            label: 'وضعیت',
            selectedItem: _statusTitle(cubit.selectedFilterStatus),
            onItemValue: (value) => cubit.setFilterStatus(_statusValue(value)),
          ),
        ],
      ),
    );
  }

  Future<void> _apply(BuildContext context) async {
    await cubit.applyFilters();
    if (context.mounted) context.pop();
  }

  Future<void> _clear(BuildContext context) async {
    await cubit.clearFilters();
    if (context.mounted) context.pop();
  }

  DeviceInfoEntity? _findDevice(List<DeviceInfoEntity> items, String label) {
    for (final item in items) {
      if (item.label == label) return item;
    }
    return null;
  }

  String _statusTitle(bool? value) {
    if (value == true) return 'فعال';
    if (value == false) return 'غیرفعال';
    return 'همه';
  }

  bool? _statusValue(String value) {
    if (value == 'فعال') return true;
    if (value == 'غیرفعال') return false;
    return null;
  }
}
