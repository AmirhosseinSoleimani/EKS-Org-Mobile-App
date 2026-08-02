import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/report_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/status_filter_dropdown.dart';
import 'package:flutter/material.dart';

class SkillsCertificatesToolbar extends StatelessWidget {
  const SkillsCertificatesToolbar({
    super.key,
    required this.activeFilter,
    required this.isReportLoading,
    required this.onFilterTap,
    required this.onStatusChanged,
    required this.onReportTap,
  });

  final bool? activeFilter;
  final bool isReportLoading;
  final VoidCallback onFilterTap;
  final ValueChanged<bool?> onStatusChanged;
  final VoidCallback onReportTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        FiltersRow(
          spacing: AppSize.s12,
          filters: [
            FilterButton(
              title: 'فیلترها',
              icon: Icons.filter_alt_outlined,
              onTap: onFilterTap,
            ),
            StatusFilterDropdown<bool?>(
              value: activeFilter,
              options: const [
                StatusFilterOption(value: null, label: 'همه'),
                StatusFilterOption(value: true, label: 'فعال'),
                StatusFilterOption(value: false, label: 'غیرفعال'),
              ],
              onChanged: onStatusChanged,
            ),
          ],
        ),
        Space.h16,
        ReportButtonWidget(
          isLoading: isReportLoading,
          onTap: () {
            if (isReportLoading) return;
            onReportTap();
          },
        ),
      ],
    );
  }

}
