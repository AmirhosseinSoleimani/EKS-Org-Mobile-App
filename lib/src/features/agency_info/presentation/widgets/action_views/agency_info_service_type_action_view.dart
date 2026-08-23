import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_service_type_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_action_agency_header.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class AgencyInfoServiceTypeActionView extends StatelessWidget {
  const AgencyInfoServiceTypeActionView({
    super.key,
    required this.item,
    required this.serviceTypes,
  });

  final AgencyInfoEntity item;
  final List<AgencyServiceTypeEntity> serviceTypes;

  static const List<_AgencyServiceOption> _serviceOptions = [
    _AgencyServiceOption(
      title: 'خدمات در محل',
      aliases: ['خدمات در محل', 'در محل', 'local', 'onsite', 'on site'],
    ),
    _AgencyServiceOption(
      title: 'خدمات فروش تجاری',
      aliases: [
        'خدمات فروش تجاری',
        'فروش تجاری',
        'commercial',
        'commercial sales',
      ],
    ),
    _AgencyServiceOption(
      title: 'خدمات امدادی',
      aliases: ['خدمات امدادی', 'امدادی', 'relief', 'emdad', 'emergency'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: AppPadding.p24),
      children: [
        AgencyInfoActionAgencyHeader(item: item),
        Space.h24,
        Align(
          alignment: Alignment.topRight,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: AppSize.s8,
              runSpacing: AppSize.s12,
              children: _serviceOptions
                  .map(
                    (option) => _AgencyServiceTypeChip(
                      title: option.title,
                      selected: _isSelected(option),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  bool _isSelected(_AgencyServiceOption option) {
    return serviceTypes.any((serviceType) {
      final candidates = [serviceType.name, serviceType.code]
          .whereType<String>()
          .map(_normalize)
          .where((value) => value.isNotEmpty);

      return candidates.any(
        (candidate) => option.aliases.any(
          (alias) {
            final normalizedAlias = _normalize(alias);
            return candidate == normalizedAlias ||
                candidate.contains(normalizedAlias) ||
                normalizedAlias.contains(candidate);
          },
        ),
      );
    });
  }

  static String _normalize(String value) {
    return value
        .trim()
        .toLowerCase()
        .replaceAll('ي', 'ی')
        .replaceAll('ك', 'ک')
        .replaceAll('\u200c', ' ')
        .replaceAll(RegExp(r'[_\-]+'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ');
  }
}

class _AgencyServiceTypeChip extends StatelessWidget {
  const _AgencyServiceTypeChip({
    required this.title,
    required this.selected,
  });

  final String title;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      constraints: const BoxConstraints(minHeight: AppSize.s48),
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p12,
        vertical: AppPadding.p10,
      ),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
        border: Border.all(
          color: selected
              ? colorScheme.primary
              : colorScheme.outline.withOpacity(0.30),
          width: selected ? 1.5 : AppSize.s1,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.03),
            blurRadius: AppSize.s8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (selected) ...[
            Icon(
              Icons.check_circle_outline_rounded,
              size: AppSize.s18,
              color: colorScheme.primary,
            ),
            Space.w8,
          ],
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _AgencyServiceOption {
  const _AgencyServiceOption({
    required this.title,
    required this.aliases,
  });

  final String title;
  final List<String> aliases;
}
