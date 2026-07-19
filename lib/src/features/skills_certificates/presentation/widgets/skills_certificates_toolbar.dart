import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
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

  static const _statusTitles = ['همه', 'فعال', 'غیرفعال'];

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
            EkDropDown(
              _statusTitles,
              label: 'وضعیت',
               fillColor:Colors.white,
              selectedItem: _statusTitle(activeFilter),
              onItemValue: (value) => onStatusChanged(_statusValue(value)),
            ),
          ],
        ),
        Space.h16,
        InkwellButtonWidget(
          title: 'گزارش گیری',
          titleColor: colorScheme.onPrimaryFixed,
          loadingColor: colorScheme.onPrimaryFixed,
          prefixIcon: SvgWidget(src: SvgAsset(SvgManager.exportNotes)),
          backgroundColor: colorScheme.secondaryContainer,
          borderColor: colorScheme.onPrimaryFixed,
          borderWidth: AppSize.s2,
          showLoading: isReportLoading,
          onTap: onReportTap,
        ),
      ],
    );
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
