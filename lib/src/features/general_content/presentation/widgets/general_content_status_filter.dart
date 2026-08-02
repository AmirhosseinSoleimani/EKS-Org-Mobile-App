import 'package:eks_sana_plus_org/src/features/general_content/presentation/cubit/general_content_state.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/status_filter_dropdown.dart';
import 'package:flutter/material.dart';

class GeneralContentStatusFilterDropDown extends StatelessWidget {
  const GeneralContentStatusFilterDropDown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final GeneralContentStatusFilter value;
  final ValueChanged<GeneralContentStatusFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    return StatusFilterDropdown<GeneralContentStatusFilter>(
      value: value,
      options: const [
        StatusFilterOption(
          value: GeneralContentStatusFilter.all,
          label: 'همه',
        ),
        StatusFilterOption(
          value: GeneralContentStatusFilter.active,
          label: 'فعال',
        ),
        StatusFilterOption(
          value: GeneralContentStatusFilter.inactive,
          label: 'غیرفعال',
        ),
      ],
      onChanged: onChanged,
    );
  }
}
