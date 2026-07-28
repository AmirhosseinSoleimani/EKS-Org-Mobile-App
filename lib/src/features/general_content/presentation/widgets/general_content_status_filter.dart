import 'package:eks_sana_plus_org/src/features/general_content/presentation/cubit/general_content_state.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:flutter/material.dart';

class GeneralContentStatusFilterDropDown extends StatelessWidget {
  const GeneralContentStatusFilterDropDown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final GeneralContentStatusFilter value;
  final ValueChanged<GeneralContentStatusFilter> onChanged;

  static const _all = 'وضعیت';
  static const _active = 'فعال';
  static const _inactive = 'غیرفعال';

  @override
  Widget build(BuildContext context) {
    return EkDropDown(
      const [_all, _active, _inactive],
      label: '',
      selectedItem: _title(value),
      fillColor: Theme.of(context).colorScheme.onPrimary,
      onItemValue: (item) => onChanged(_value(item)),
    );
  }

  String _title(GeneralContentStatusFilter value) {
    switch (value) {
      case GeneralContentStatusFilter.active:
        return _active;
      case GeneralContentStatusFilter.inactive:
        return _inactive;
      case GeneralContentStatusFilter.all:
        return _all;
    }
  }

  GeneralContentStatusFilter _value(String title) {
    switch (title) {
      case _active:
        return GeneralContentStatusFilter.active;
      case _inactive:
        return GeneralContentStatusFilter.inactive;
      case _all:
      default:
        return GeneralContentStatusFilter.all;
    }
  }
}
