import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';

class SkillCertificateCard extends StatelessWidget {
  final SkillCertificateEntity item;
  final VoidCallback onServices;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const SkillCertificateCard({
    super.key,
    required this.item,
    required this.onServices,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 4,
      shadowColor: Colors.black.withAlpha(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TitleMediumText(text: item.displayTitle,
                  textAlign: TextAlign.left,
                ),
                const Spacer(),
                StatusLabel(
                  text: item.isActive ? 'فعال' : 'غیرفعال',
                  color: item.isActive ? colorScheme.onError : colorScheme
                      .error,
                ),
              ],
            ),
            Space.h16,
            Divider(color: colorScheme.onInverseSurface),
            Space.h8,
            _MetaRow(
              label: 'ثبت‌کننده',
              name: item.insertUserFullName,
              date: item.insertDateTimeJalali,
            ),
            Space.h8,
            _MetaRow(
              label: 'آخرین ویرایش',
              name: item.updateUserFullName,
              date: item.updateDateTimeJalali,
            ),
            Space.h16,
            InkwellButtonWidget(
              title: 'عملیات',
              height: AppSize.s48,
              backgroundColor: colorScheme.secondaryContainer,
              titleColor: colorScheme.onSurface,
              prefixIcon: Icon(
                Icons.settings_outlined,
                size: AppSize.s20,
                color: colorScheme.onSurfaceVariant,
              ),
              suffixIcon: Icon(
                Icons.keyboard_arrow_down_outlined,
                size: AppSize.s24,
                color: colorScheme.onSurfaceVariant,
              ),
              onTap: () => _showActionsSheet(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showActionsSheet(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    BottomSheetMessage.showCustom(
      backgroundColor: Colors.white,
      context: context,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ActionTile(
            icon: Icons.card_membership,
            title: 'سرویس‌ها',
            onTap: onServices,
          ),
          Divider(color: colorScheme.onInverseSurface),
          _ActionTile(
            icon: Icons.edit_outlined,
            title: 'ویرایش',
            onTap: onEdit,
          ),
          Divider(color: colorScheme.onInverseSurface),
          _ActionTile(
            icon: Icons.delete_forever_outlined,
            title: 'حذف',
            onTap: onDelete,
            isDestructive: true,
          ),
        ],
      ),
      actionWidget: const SizedBox.shrink(),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final String label;
  final String? name;
  final String? date;

  const _MetaRow({
    required this.label,
    this.name,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: BodyMediumText(
            text: '$label: ${_display(name)}',
            color: colorScheme.onTertiaryFixed,
            fontSize: 14,
          ),
        ),
        Space.w8,
        BodyMediumText(
          text: _display(date),
          color: colorScheme.onTertiaryFixed,
          fontSize: 13,
        ),
      ],
    );
  }

  String _display(String? value) {
    final normalized = value?.trim();
    return normalized == null || normalized.isEmpty ? '---' : normalized;
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).colorScheme.onTertiaryFixed;

    return ListTile(
      leading: Icon(icon, color: color),
      title: BodyMediumText(
        text: title,
        color: color,
        fontWeight: FontWeight.w600,
      ),
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
    );
  }
}
