import 'dart:convert';
import 'dart:typed_data';

import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/person_info_search_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_action_content_widgets.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_status_badge.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/image_widget/image_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AgencyInfoActionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!compact) ...[
                _PersonAvatar(person: person),
                Space.w12,
              ],
              Expanded(
                child: BodyMediumText(
                  text: AgencyInfoActionFormatter.joinNonEmpty(
                    [person.firstName, person.lastName],
                  ),
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onSurface,
                  fontSize: AppSize.s16,
                ),
              ),
              if (!compact) ...[
                Space.w8,
                AgencyInfoStatusBadge(isActive: _isActive(person)),
              ],
            ],
          ),
          Space.h12,
          Divider(
            height: AppSize.s1,
            color: theme.dividerColor.withOpacity(0.55),
          ),
          Space.h8,
          _InfoRow(
            icon: Icons.badge_outlined,
            label: 'کد پرسنلی',
            value: person.code,
          ),
          _InfoRow(
            icon: Icons.contact_mail_outlined,
            label: 'کد ملی',
            value: person.nationalNumber,
          ),
          if (!compact) ...[
            _InfoRow(
              icon: Icons.credit_card_outlined,
              label: 'کد گواهینامه',
              value: person.licenseCode,
            ),
            _InfoRow(
              icon: Icons.location_on_outlined,
              label: 'استان/شهر',
              value: AgencyInfoActionFormatter.joinNonEmpty([
                person.provinceNameIssuingPlace,
                person.cityNameIssuingPlace,
              ]),
            ),
          ],
          _InfoRow(
            icon: Icons.phone_outlined,
            label: 'شماره تماس',
            value: person.mobile,
          ),
          if (onAdd != null) ...[
            Space.h12,
            Align(
              alignment: Alignment.centerLeft,
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
          ],
        ],
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

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: AppSize.s18,
            color: colorScheme.onTertiaryFixed,
          ),
          Space.w8,
          Expanded(
            child: BodyMediumText(
              text: '$label: ${AgencyInfoActionFormatter.valueOrDash(value)}',
              color: colorScheme.onSurfaceVariant,
              lineHeight: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
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
