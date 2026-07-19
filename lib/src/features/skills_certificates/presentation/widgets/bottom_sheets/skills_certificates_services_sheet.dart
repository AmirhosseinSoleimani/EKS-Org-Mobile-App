import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/presentation/cubit/skills_certificates_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SkillsCertificatesServicesSheet extends StatelessWidget {
  const SkillsCertificatesServicesSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SkillsCertificatesCubit>();
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppPadding.p16,
                AppPadding.p12,
                AppPadding.p16,
                AppPadding.p8,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                  const Spacer(),
                  Text(
                    'سرویس‌ها',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child:
                  BlocBuilder<SkillsCertificatesCubit, SkillsCertificatesState>(
                builder: (context, state) {
                  final data = state.data;
                  final skill = data.selectedSkill;

                  if (data.isServicesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(
                      AppPadding.p16,
                      AppPadding.p8,
                      AppPadding.p16,
                      AppPadding.p24,
                    ),
                    children: [
                      if (skill != null) SkillCertificateServicesHeader(skill),
                      Space.h16,
                      TextFormFieldWidget(
                        onChanged: cubit.filterServices,
                        hintText: 'جستجوی سرویس',
                        prefixIcon: const Icon(Icons.search),
                        textInputAction: TextInputAction.search,
                      ),
                      Space.h24,
                      Wrap(
                        spacing: AppSize.s8,
                        runSpacing: AppSize.s8,
                        children: cubit.filteredServices
                            .map((item) => SkillServiceSelectableItem(item))
                            .toList(),
                      ),
                    ],
                  );
                },
              ),
            ),
            _SubmitServicesButton(cubit: cubit),
          ],
        ),
      ),
    );
  }
}

class SkillCertificateServicesHeader extends StatelessWidget {
  const SkillCertificateServicesHeader(this.skill, {super.key});

  final SkillCertificateEntity skill;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          StatusLabel(
            text: skill.isActive ? 'فعال' : 'غیرفعال',
            color: skill.isActive ? colorScheme.onError : colorScheme.error,
          ),
          const Spacer(),
          Expanded(
            flex: 4,
            child: Text(
              skill.displayTitle,
              textAlign: TextAlign.left,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Space.w12,
          Container(
            width: AppSize.s48,
            height: AppSize.s48,
            decoration: BoxDecoration(
              color: colorScheme.primary.withAlpha(18),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.desktop_windows_outlined,
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class SkillServiceSelectableItem extends StatelessWidget {
  const SkillServiceSelectableItem(this.service, {super.key});

  final SkillServiceEntity service;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SkillsCertificatesCubit>();

    return BlocBuilder<SkillsCertificatesCubit, SkillsCertificatesState>(
      buildWhen: (previous, current) =>
          previous.data.selectedServiceIds != current.data.selectedServiceIds,
      builder: (context, state) {
        final selected = service.id != null &&
            state.data.selectedServiceIds.contains(service.id);

        return InkWell(
          borderRadius: BorderRadius.circular(AppSize.s8),
          onTap: () => cubit.toggleService(service),
          child: _ServiceItemContent(
            title: service.displayTitle,
            selected: selected,
          ),
        );
      },
    );
  }
}

class _ServiceItemContent extends StatelessWidget {
  const _ServiceItemContent({
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
      constraints: const BoxConstraints(minHeight: AppSize.s42),
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p12,
        vertical: AppPadding.p10,
      ),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
        border: Border.all(
          color: selected ? colorScheme.primary : colorScheme.onInverseSurface,
          width: selected ? AppSize.s2 : AppSize.s1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
          if (selected) ...[
            Space.w8,
            Icon(
              Icons.check_circle_outline,
              color: colorScheme.primary,
              size: AppSize.s18,
            ),
          ],
        ],
      ),
    );
  }
}

class _SubmitServicesButton extends StatelessWidget {
  const _SubmitServicesButton({required this.cubit});

  final SkillsCertificatesCubit cubit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(color: theme.colorScheme.outline.withAlpha(25)),
        ),
      ),
      child: BlocBuilder<SkillsCertificatesCubit, SkillsCertificatesState>(
        buildWhen: (previous, current) =>
            previous.data.isServicesSubmitting !=
            current.data.isServicesSubmitting,
        builder: (context, state) {
          return InkwellButtonWidget(
            title: state.data.isServicesSubmitting ? 'در حال ثبت...' : 'بستن',
            backgroundColor: theme.colorScheme.onPrimary,
            borderColor: theme.colorScheme.outline.withOpacity(0.65),
            titleColor: theme.colorScheme.onSurface,
            showLoading: state.data.isServicesSubmitting,
            onTap: () async {
              final submitted = await cubit.submitServices();
              if (submitted && context.mounted) {
                Navigator.of(context).pop();
              }
            },
          );
        },
      ),
    );
  }
}
