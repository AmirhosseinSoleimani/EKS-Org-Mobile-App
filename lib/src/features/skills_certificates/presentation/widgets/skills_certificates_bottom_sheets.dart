import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/presentation/cubit/skills_certificates_cubit.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/presentation/widgets/bottom_sheets/skill_certificate_form_sheet.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/presentation/widgets/bottom_sheets/skills_certificates_filter_sheet.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/presentation/widgets/bottom_sheets/skills_certificates_services_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SkillsCertificatesBottomSheets {
  static void showFilterSheet({
    required BuildContext context,
    required SkillsCertificatesCubit cubit,
  }) {
    BottomSheetMessage.showCustom(
      context: context,
      content: BlocProvider.value(
        value: cubit,
        child: const SkillsCertificatesFilterSheet(),
      ),
      actionWidget: const SizedBox.shrink(),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      maxHeight: 0.68,
    );
  }

  static Future<void> showFormSheet({
    required BuildContext context,
    required SkillsCertificatesCubit cubit,
    SkillCertificateEntity? skill,
  }) async {
    final initialSkill =
        skill?.id == null ? skill : await cubit.getSkillById(skill!.id!);
    if (skill != null && initialSkill == null) return;
    if (!context.mounted) return;

    BottomSheetMessage.showFullScreenCustom(
      context: context,
      content: BlocProvider.value(
        value: cubit,
        child: SkillCertificateFormSheet(skill: initialSkill),
      ),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,

    );
  }

  static Future<void> showServicesSheet({
    required BuildContext context,
    required SkillsCertificatesCubit cubit,
    required SkillCertificateEntity skill,
  }) async {
    await cubit.loadServices(skill);
    if (!context.mounted) return;

    BottomSheetMessage.showFullScreenCustom<void>(
      context: context,
      content: BlocProvider.value(
        value: cubit,
        child: const SkillsCertificatesServicesSheet(),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
