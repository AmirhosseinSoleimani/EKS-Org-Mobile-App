import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/status_filter_dropdown.dart';
import 'package:flutter/material.dart';

class ListFilterToolbar<T> extends StatelessWidget {
  const ListFilterToolbar({
    super.key,
    required this.onFilterTap,
    required this.statusValue,
    required this.statusOptions,
    required this.onStatusChanged,
    this.filterTitle = 'فیلترها',
    this.statusPlaceholder = 'وضعیت',
    this.spacing = AppSize.s12,
  });

  final VoidCallback onFilterTap;
  final T statusValue;
  final List<StatusFilterOption<T>> statusOptions;
  final ValueChanged<T> onStatusChanged;
  final String filterTitle;
  final String statusPlaceholder;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return FiltersRow(
      spacing: spacing,
      filters: [
        StatusFilterDropdown<T>(
          value: statusValue,
          options: statusOptions,
          placeholder: statusPlaceholder,
          onChanged: onStatusChanged,
        ),
        FilterButton(
          title: filterTitle,
          onTap: onFilterTap,
        ),
      ],
    );
  }
}
