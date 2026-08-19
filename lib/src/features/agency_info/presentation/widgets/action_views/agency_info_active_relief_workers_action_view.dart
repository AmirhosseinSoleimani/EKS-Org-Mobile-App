import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_person_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_person_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_action_agency_header.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_action_content_widgets.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/list_item_text.dart';
import 'package:flutter/material.dart';

class AgencyInfoActiveReliefWorkersActionView extends StatelessWidget {
  const AgencyInfoActiveReliefWorkersActionView({
    super.key,
    required this.item,
    required this.persons,
    this.showSectionHeader = true,
  });

  final AgencyInfoEntity item;
  final AgencyPersonPageEntity persons;
  final bool showSectionHeader;

  @override
  Widget build(BuildContext context) {
    final records = persons.records ?? const <AgencyPersonEntity>[];
    final count = (persons.count ?? 0) > 0
        ? persons.count!
        : records.length;

    return Column(
      children: [
        AgencyInfoActionAgencyHeader(item: item),
        Space.h24,
        if (showSectionHeader) ...[
          AgencyInfoActionSectionHeader(
            title: 'امدادرسان‌های فعلی',
            count: count,
          ),
          Space.h16,
        ],
        Expanded(
          child: records.isEmpty
              ? EmptyListWidget()
              : ListView.separated(
                  padding: const EdgeInsets.only(bottom: AppPadding.p24),
                  itemCount: records.length,
                  separatorBuilder: (_, __) => Space.h12,
                  itemBuilder: (context, index) {
                    return _AgencyReliefWorkerItem(person: records[index]);
                  },
                ),
        ),
      ],
    );
  }
}

class _AgencyReliefWorkerItem extends StatelessWidget {
  const _AgencyReliefWorkerItem({required this.person});

  final AgencyPersonEntity person;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isActive = _isActive(person) ??false;
    return AgencyInfoActionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListItemTitleText(
                  text: AgencyInfoActionFormatter.joinNonEmpty(
                    [person.firstName, person.lastName],
                  ),
                  maxLines: 1,
                ),
              ),
              Space.w8,
              StatusLabel(text: isActive? 'فعال' : 'غیرفعال', color: isActive ? colorScheme.onError : colorScheme.error),
            ],
          ),
          Space.h12,
          Divider(
            height: AppSize.s1,
            color: theme.dividerColor.withOpacity(0.55),
          ),
          Space.h8,
          AgencyInfoActionIconInfoRow(
            icon: Icons.badge_outlined,
            label: 'کد پرسنلی',
            value: person.code,
          ),
          AgencyInfoActionIconInfoRow(
            icon: Icons.contact_mail_outlined,
            label: 'کد ملی',
            value: person.nationalNumber,
          ),
          AgencyInfoActionIconInfoRow(
            icon: Icons.groups_2_outlined,
            label: 'واحد امدادی',
            value: _firstNonEmpty([person.jobPosition, person.address]),
          ),
          AgencyInfoActionIconInfoRow(
            icon: Icons.business_outlined,
            label: 'نوع فعالیت',
            value: _activityTypeTitle(person.activityType),
          ),
          AgencyInfoActionIconInfoRow(
            icon: Icons.phone_outlined,
            label: 'شماره تماس',
            value: _firstNonEmpty([person.aidPersonMobile, person.mobile]),
          ),
        ],
      ),
    );
  }

  static bool? _isActive(AgencyPersonEntity person) {
    if (person.isActive != null) return person.isActive;
    if (person.status != null) return person.status == 1;

    final statusTitle = person.statusTitle?.trim().toLowerCase();
    if (statusTitle == null || statusTitle.isEmpty) return null;
    if (statusTitle.contains('غیر فعال') || statusTitle.contains('غیرفعال')) {
      return false;
    }
    if (statusTitle.contains('فعال')) return true;
    return null;
  }

  static String? _activityTypeTitle(int? activityType) {
    switch (activityType) {
      case 1:
        return 'تمام وقت';
      case 2:
        return 'پاره وقت';
      default:
        return activityType?.toString();
    }
  }

  static String? _firstNonEmpty(Iterable<String?> values) {
    for (final value in values) {
      if (value?.trim().isNotEmpty == true) return value!.trim();
    }
    return null;
  }
}
