import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/list_widgets/list_section_header.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_info_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/list_item_text.dart';
import 'package:flutter/material.dart';

class AgencyInfoActionSectionHeader extends StatelessWidget {
  const AgencyInfoActionSectionHeader({
    super.key,
    required this.title,
    required this.count,
  });

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return ListSectionHeader(
      title: title,
      countText:
          '${AgencyInfoActionFormatter.toPersianDigits(count.toString())} مورد',
    );
  }
}

class AgencyInfoActionCard extends StatelessWidget {
  const AgencyInfoActionCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppPadding.p16),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.06),
            blurRadius: AppSize.s16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class AgencyInfoActionLabelValueRow extends StatelessWidget {
  const AgencyInfoActionLabelValueRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p4),
      child: ListItemLabelValueText(
        label: label.replaceFirst(RegExp(r':$'), ''),
        value: AgencyInfoActionFormatter.valueOrDash(value),
        maxLines: 2,
      ),
    );
  }
}

class AgencyInfoActionIconInfoRow extends StatelessWidget {
  const AgencyInfoActionIconInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return SummaryCardInfoRow(
      item: SummaryCardInfo(
        icon: icon,
        label: label,
        value: value,
      ),
    );
  }
}

class AgencyInfoActionEmptyView extends StatelessWidget {
  const AgencyInfoActionEmptyView({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const EmptyListWidget(),
          Space.h16,
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class AgencyInfoActionFormatter {
  const AgencyInfoActionFormatter._();

  static String valueOrDash(String? value) {
    return value?.trim().isNotEmpty == true ? value!.trim() : '---';
  }

  static String toPersianDigits(String value) {
    const englishDigits = '0123456789';
    const persianDigits = '۰۱۲۳۴۵۶۷۸۹';

    return value.split('').map((character) {
      final index = englishDigits.indexOf(character);
      return index == -1 ? character : persianDigits[index];
    }).join();
  }

  static String joinNonEmpty(Iterable<String?> values) {
    final result = values
        .whereType<String>()
        .map((value) => value.trim())
        .where((value) => value.isNotEmpty)
        .join(' ');

    return result.isEmpty ? '---' : result;
  }
}
