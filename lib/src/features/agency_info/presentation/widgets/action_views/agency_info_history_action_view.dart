import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_action_agency_header.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:flutter/material.dart';

class AgencyInfoHistoryActionView extends StatelessWidget {
  const AgencyInfoHistoryActionView({
    super.key,
    required this.item,
    required this.histories,
  });

  final AgencyInfoEntity item;
  final List<AgencyHistoryEntity> histories;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AgencyInfoActionAgencyHeader(item: item),
        Space.h16,
        Expanded(
          child: histories.isEmpty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [
                    SizedBox(
                      height: AppSize.s300,
                      child: Center(child: EmptyListWidget()),
                    ),
                  ],
                )
              : ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(
                    top: AppPadding.p8,
                    bottom: AppPadding.p24,
                  ),
                  itemCount: histories.length,
                  separatorBuilder: (_, __) => Space.h12,
                  itemBuilder: (context, index) {
                    return _AgencyHistoryItem(history: histories[index]);
                  },
                ),
        ),
      ],
    );
  }
}

class _AgencyHistoryItem extends StatelessWidget {
  const _AgencyHistoryItem({required this.history});

  final AgencyHistoryEntity history;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s12),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.08),
            blurRadius: AppSize.s12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                _formatDateTime(history.insertDateTimeJalali),
                textDirection: TextDirection.ltr,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onTertiaryFixed,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                'ثبت‌کننده: ${_valueOrDash(history.insertUserName)}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onTertiaryFixed,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Space.h12,
          Text(
            _valueOrDash(history.description),
            textAlign: TextAlign.right,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface,
              height: 1.7,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  static String _formatDateTime(String? value) {
    final rawValue = value?.trim();
    if (rawValue == null || rawValue.isEmpty) return '---';

    try {
      final normalizedValue = rawValue.replaceAll('T', ' ');
      final parts = normalizedValue
          .split(RegExp(r'\s+'))
          .where((part) => part.isNotEmpty)
          .toList();

      if (parts.length < 2) return _toPersianDigits(rawValue);

      final date = parts.first;
      final timeParts = parts[1].split(':');
      final time = timeParts.length >= 2
          ? '${timeParts[0].padLeft(2, '0')}:${timeParts[1].padLeft(2, '0')}'
          : parts[1];

      return _toPersianDigits('$date - $time');
    } catch (_) {
      return _toPersianDigits(rawValue);
    }
  }

  static String _toPersianDigits(String value) {
    const englishDigits = '0123456789';
    const persianDigits = '۰۱۲۳۴۵۶۷۸۹';

    return value.split('').map((character) {
      final index = englishDigits.indexOf(character);
      return index == -1 ? character : persianDigits[index];
    }).join();
  }

  static String _valueOrDash(String? value) {
    return value?.trim().isNotEmpty == true ? value!.trim() : '---';
  }
}
