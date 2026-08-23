import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/presentation/cubit/skills_certificates_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SkillCertificateCard extends StatelessWidget {
  const SkillCertificateCard({
    super.key,
    required this.item,
    required this.onLoadServices,
    required this.onServicesLoaded,
    required this.onEdit,
    required this.onDelete,
  });

  final SkillCertificateEntity item;
  final Future<bool> Function() onLoadServices;
  final VoidCallback onServicesLoaded;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppSummaryCard(
      title: item.displayTitle,
      badges: [
        StatusLabel(
          text: item.isActive ? 'فعال' : 'غیرفعال',
          color: item.isActive ? colorScheme.onError : colorScheme.error,
          variant: StatusLabelVariant.filledWithoutBorder,
        ),
      ],
      metaItems: [
        SummaryCardMeta(
          label: 'ثبت‌کننده',
          value: item.insertUserFullName,
          date: item.insertDateTimeJalali,
        ),
        SummaryCardMeta(
          label: 'آخرین ویرایش',
          value: item.updateUserFullName,
          date: item.updateDateTimeJalali,
        ),
      ],
      onOperation: () => _showActionsSheet(context),
    );
  }

  void _showActionsSheet(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.read<SkillsCertificatesCubit>();

    BottomSheetMessage.showCustom(
      backgroundColor: Colors.white,
      context: context,
      content: BlocProvider.value(
        value: cubit,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ActionTile(
              icon: Icons.card_membership,
              title: 'سرویس‌ها',
              closeBeforeAction: false,
              loadingBuilder: (state) => state.data.isServicesLoading,
              onTap: onLoadServices,
              onActionCompleted: onServicesLoaded,
            ),
            Divider(color: colorScheme.onInverseSurface),
            _ActionTile(
              icon: Icons.edit_outlined,
              title: 'ویرایش',
              onTap: () async {
                onEdit();
                return true;
              },
            ),
            Divider(color: colorScheme.onInverseSurface),
            _ActionTile(
              icon: Icons.delete_forever_outlined,
              title: 'حذف',
              isDestructive: true,
              onTap: () async {
                onDelete();
                return true;
              },
            ),
          ],
        ),
      ),
      actionWidget: const SizedBox.shrink(),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
    this.closeBeforeAction = true,
    this.onActionCompleted,
    this.loadingBuilder,
  });

  final IconData icon;
  final String title;
  final Future<bool> Function() onTap;
  final bool isDestructive;
  final bool closeBeforeAction;
  final VoidCallback? onActionCompleted;
  final bool Function(SkillsCertificatesState state)? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).colorScheme.onTertiaryFixed;

    return BlocBuilder<SkillsCertificatesCubit, SkillsCertificatesState>(
      buildWhen: (previous, current) =>
          loadingBuilder?.call(previous) != loadingBuilder?.call(current),
      builder: (context, state) {
        final isLoading = loadingBuilder?.call(state) ?? false;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: isLoading
                ? SizedBox(
                    width: AppSize.s24,
                    height: AppSize.s24,
                    child: CircularProgressIndicator(
                      strokeWidth: AppSize.s2,
                      color: color,
                    ),
                  )
                : Icon(icon, color: color),
            title: BodyMediumText(
              text: title,
              color: color,
              fontWeight: FontWeight.w600,
            ),
            onTap: () async {
              if (isLoading) return;

              if (closeBeforeAction) {
                Navigator.of(context).pop();
              }

              final completed = await onTap();
              if (!completed || !context.mounted) return;

              if (!closeBeforeAction) {
                Navigator.of(context).pop();
              }

              onActionCompleted?.call();
            },
          ),
        );
      },
    );
  }
}
