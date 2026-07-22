import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/presentation/cubit/skills_certificates_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/app_checkbox_widget.dart';
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
                  Expanded(
                    child: Text(
                      'سرویس‌های گواهینامه',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop<bool>(false),
                    tooltip: 'بستن',
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
            Divider(
              height: AppSize.s1,
              color: theme.dividerColor,
            ),
            Expanded(
              child: BlocBuilder<SkillsCertificatesCubit,
                  SkillsCertificatesState>(
                builder: (context, state) {
                  final data = state.data;
                  final skill = data.selectedSkill;

                  if (data.isServicesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final filteredServices = cubit.filteredServices;
                  final selectedServices = filteredServices.where((service) {
                    final id = service.id;
                    return id != null && data.selectedServiceIds.contains(id);
                  }).toList();
                  final unselectedServices = filteredServices.where((service) {
                    final id = service.id;
                    return id == null || !data.selectedServiceIds.contains(id);
                  }).toList();

                  return ListView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(
                      AppPadding.p16,
                      AppPadding.p16,
                      AppPadding.p16,
                      AppPadding.p24,
                    ),
                    children: [
                      if (skill != null) SkillCertificateServicesHeader(skill),
                      Space.h24,
                      TextFormFieldWidget(
                        onChanged: cubit.filterServices,
                        hintText: 'جستجوی سرویس',
                        prefixIcon: const Icon(Icons.search),
                        textInputAction: TextInputAction.search,
                      ),
                      Space.h16,
                      AppCheckboxWidget(
                        title: 'انتخاب همه',
                        value: cubit.areAllServicesSelected,
                        enabled: !data.isServicesSubmitting,
                        onChanged: cubit.setAllServices,
                      ),
                      Space.h24,
                      if (data.services.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: AppPadding.p24,
                            ),
                            child: Text('سرویسی برای این گواهینامه یافت نشد.'),
                          ),
                        )
                      else if (filteredServices.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: AppPadding.p24,
                            ),
                            child: Text('سرویسی با این عنوان پیدا نشد.'),
                          ),
                        )
                      else ...[
                        _ServicesSectionTitle(
                          title: 'سرویس‌های انتخاب‌شده',
                          count: selectedServices.length,
                        ),
                        Space.h12,
                        if (selectedServices.isEmpty)
                          Text(
                            'هنوز سرویسی انتخاب نشده است.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          )
                        else
                          Wrap(
                            spacing: AppSize.s8,
                            runSpacing: AppSize.s8,
                            children: selectedServices
                                .map(SkillServiceSelectableItem.new)
                                .toList(),
                          ),
                        Space.h24,
                        _ServicesSectionTitle(
                          title: 'سایر سرویس‌ها',
                          count: unselectedServices.length,
                        ),
                        Space.h12,
                        if (unselectedServices.isEmpty)
                          Text(
                            'همه سرویس‌ها انتخاب شده‌اند.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          )
                        else
                          Wrap(
                            spacing: AppSize.s8,
                            runSpacing: AppSize.s8,
                            children: unselectedServices
                                .map(SkillServiceSelectableItem.new)
                                .toList(),
                          ),
                      ],
                    ],
                  );
                },
              ),
            ),
            _ServicesActions(cubit: cubit),
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
            blurRadius: AppSize.s16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              skill.displayTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Space.w12,
          StatusLabel(
            text: skill.isActive ? 'فعال' : 'غیرفعال',
            color: skill.isActive ? colorScheme.onError : colorScheme.error,
            variant: StatusLabelVariant.filledWithoutBorder,
          ),
        ],
      ),
    );
  }
}

class _ServicesSectionTitle extends StatelessWidget {
  const _ServicesSectionTitle({
    required this.title,
    required this.count,
  });

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p8,
            vertical: AppPadding.p4,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withAlpha(18),
            borderRadius: BorderRadius.circular(AppSize.s12),
          ),
          child: Text(
            count.toString(),
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
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
          previous.data.selectedServiceIds != current.data.selectedServiceIds ||
          previous.data.isServicesSubmitting !=
              current.data.isServicesSubmitting,
      builder: (context, state) {
        final selected = service.id != null &&
            state.data.selectedServiceIds.contains(service.id);

        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppSize.s8),
            onTap: state.data.isServicesSubmitting
                ? null
                : () => cubit.toggleService(service),
            child: _ServiceItemContent(
              title: service.displayTitle,
              selected: selected,
            ),
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
          if (selected) ...[
            Icon(
              Icons.check_circle_outline_rounded,
              color: colorScheme.primary,
              size: AppSize.s18,
            ),
            Space.w8,
          ],
          Flexible(
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: selected
                    ? colorScheme.primary
                    : colorScheme.onSurface,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServicesActions extends StatelessWidget {
  const _ServicesActions({required this.cubit});

  final SkillsCertificatesCubit cubit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppPadding.p16,
        AppPadding.p12,
        AppPadding.p16,
        AppPadding.p16,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.08),
            blurRadius: AppSize.s16,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: BlocBuilder<SkillsCertificatesCubit, SkillsCertificatesState>(
          buildWhen: (previous, current) =>
              previous.data.isServicesSubmitting !=
              current.data.isServicesSubmitting,
          builder: (context, state) {
            final isSubmitting = state.data.isServicesSubmitting;

            return Row(
              children: [
                Expanded(
                  child: InkwellButtonWidget(
                    title: 'بستن',
                    backgroundColor: theme.colorScheme.onPrimary,
                    borderColor: theme.colorScheme.outline,
                    titleColor: theme.colorScheme.onSurface,
                    borderWidth: AppSize.s1,
                    onTap: isSubmitting
                        ? null
                        : () => Navigator.of(context).pop<bool>(false),
                  ),
                ),
                Space.w12,
                Expanded(
                  child: InkwellButtonWidget(
                    title: isSubmitting ? 'در حال ثبت...' : 'ثبت',
                    backgroundColor: theme.colorScheme.primary,
                    borderColor: theme.colorScheme.primary,
                    titleColor: theme.colorScheme.onPrimary,
                    showLoading: isSubmitting,
                    onTap: isSubmitting
                        ? null
                        : () async {
                            final submitted = await cubit.submitServices();
                            if (submitted && context.mounted) {
                              Navigator.of(context).pop<bool>(true);
                            }
                          },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
