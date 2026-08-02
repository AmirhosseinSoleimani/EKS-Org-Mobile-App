import 'dart:convert';
import 'dart:typed_data';

import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/person_info_search_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_action_content_widgets.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/image_widget/image_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
import 'package:flutter/material.dart';

class AgencyPersonSummaryCard extends StatelessWidget {
  const AgencyPersonSummaryCard({
    super.key,
    required this.person,
    this.onAdd,
    this.compact = false,
  });

  final PersonInfoSearchEntity person;
  final VoidCallback? onAdd;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    final isActive = _isActive(person) ?? false;
    return AppSummaryCard(
      title: AgencyInfoActionFormatter.joinNonEmpty(
        [person.firstName, person.lastName],
      ),
      leading: compact ? null : _PersonAvatar(person: person),
      badges: compact
          ? const []
          : [
        StatusLabel(text: isActive ? 'فعال' : 'غیرفعال',
            color: isActive ? colorScheme.onError : colorScheme.error)
      ],
      infoItems: [
        SummaryCardInfo(
          icon: Icons.badge_outlined,
          label: 'کد پرسنلی',
          value: person.code,
        ),
        SummaryCardInfo(
          icon: Icons.contact_mail_outlined,
          label: 'کد ملی',
          value: person.nationalNumber,
        ),
        if (!compact)
          SummaryCardInfo(
            icon: Icons.credit_card_outlined,
            label: 'کد گواهینامه',
            value: person.licenseCode,
          ),
        if (!compact)
          SummaryCardInfo(
            icon: Icons.location_on_outlined,
            label: 'استان/شهر',
            value: AgencyInfoActionFormatter.joinNonEmpty([
              person.provinceNameIssuingPlace,
              person.cityNameIssuingPlace,
            ]),
          ),
        SummaryCardInfo(
          icon: Icons.phone_outlined,
          label: 'شماره تماس',
          value: person.mobile,
        ),
      ],
      afterInfo: onAdd == null
          ? null
          : Align(
        alignment: AlignmentDirectional.centerEnd,
              child: SizedBox(
                width: AppSize.s40,
                height: AppSize.s40,
                child: Material(
                  color: colorScheme.primary,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: onAdd,
                    child: Icon(
                      Icons.add_rounded,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  static bool? _isActive(PersonInfoSearchEntity person) {
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
}

class _PersonAvatar extends StatelessWidget {
  const _PersonAvatar({required this.person});

  final PersonInfoSearchEntity person;

  @override
  Widget build(BuildContext context) {
    final bytes = _decodeImage(person.imageBase64);
    final colorScheme = Theme.of(context).colorScheme;

    if (bytes != null) {
      return ImageWidget.memory(
        bytes,
        width: AppSize.s48,
        height: AppSize.s48,
        isCircle: true,
      );
    }

    return CircleAvatar(
      radius: AppSize.s24,
      backgroundColor: colorScheme.primary.withOpacity(0.08),
      child: Icon(
        Icons.person_outline_rounded,
        color: colorScheme.primary,
      ),
    );
  }

  Uint8List? _decodeImage(String? value) {
    final raw = value?.trim();
    if (raw == null || raw.isEmpty) return null;

    try {
      final base64Value = raw.contains(',') ? raw.split(',').last : raw;
      return base64Decode(base64Value);
    } catch (_) {
      return null;
    }
  }
}
