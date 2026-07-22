import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/presentation/cubit/skills_certificates_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
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
        child: ColoredBox(
          color: theme.colorScheme.onInverseSurface,
          child: Column(
            children: [
              _ServicesSheetHeader(
                onClose: () => Navigator.of(context).pop<bool>(false),
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
                        if (skill != null) ...[
                          SkillCertificateServicesHeader(skill),
                          Space.h16,
                        ],
                        TextFormFieldWidget(
                          onChanged: cubit.filterServices,
                          hintText: 'جستجوی سرویس',
                          suffixIcon: const Icon(Icons.search),
                          textInputAction: TextInputAction.search,
                        ),
                        Space.h24,
                        if (data.services.isEmpty)
                          const _ServicesEmptyMessage(
                            message: 'سرویس یافت نشد.',
                          )
                        else if (filteredServices.isEmpty)
                          const _ServicesEmptyMessage(
                            message: 'سرویسی با این عنوان پیدا نشد.',
                          )
                        else
                          _ServicesWrap(services: filteredServices),
                      ],
                    );
                  },
                ),
              ),
              _ServicesActions(cubit: cubit),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServicesSheetHeader extends StatelessWidget {
  const _ServicesSheetHeader({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.onPrimary,
      padding: const EdgeInsets.fromLTRB(
        AppPadding.p16,
        AppPadding.p12,
        AppPadding.p16,
        AppPadding.p10,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'سرویس‌ها',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          IconButton(
            onPressed: onClose,
            tooltip: 'بستن',
            icon: const Icon(Icons.close_rounded),
          ),
        ],
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
          Container(
            width: AppSize.s54,
            height: AppSize.s54,
            decoration: BoxDecoration(
              color: colorScheme.primary.withAlpha(18),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.desktop_windows_outlined,
              color: colorScheme.primary,
              size: AppSize.s28,
            ),
          ),
          Space.w12,
          Expanded(
            child: Text(
              skill.displayTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
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

class _ServicesWrap extends StatelessWidget {
  const _ServicesWrap({required this.services});

  final List<SkillServiceEntity> services;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SkillsCertificatesCubit>();

    return LayoutBuilder(
      builder: (context, constraints) {
        return BlocBuilder<SkillsCertificatesCubit, SkillsCertificatesState>(
          buildWhen: (previous, current) =>
              previous.data.selectedServiceIds !=
                  current.data.selectedServiceIds ||
              previous.data.isServicesSubmitting !=
                  current.data.isServicesSubmitting,
          builder: (context, state) {
            return Wrap(
              spacing: AppSize.s8,
              runSpacing: AppSize.s8,
              alignment: WrapAlignment.start,
              children: services.map((service) {
                final selected = service.id != null &&
                    state.data.selectedServiceIds.contains(service.id);

                return _ServiceCheckItem(
                  title: service.displayTitle,
                  selected: selected,
                  maxWidth: constraints.maxWidth,
                  onTap: () {
                    if (state.data.isServicesSubmitting) return;
                    cubit.toggleService(service);
                  },
                );
              }).toList(),
            );
          },
        );
      },
    );
  }
}

class _ServiceCheckItem extends StatelessWidget {
  const _ServiceCheckItem({
    required this.title,
    required this.selected,
    required this.maxWidth,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final double maxWidth;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;
    final borderColor = selected ? primary : colorScheme.onInverseSurface;
    final textColor = selected ? primary : colorScheme.onSurface;
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: textColor,
        );

    const horizontalPadding = 28.0;
    final iconWidth = selected ? 26.0 : AppSize.s0;
    final availableTextWidth =
        (maxWidth - horizontalPadding - iconWidth)
            .clamp(80.0, maxWidth)
            .toDouble();
    final itemWidth = _calculateWidth(
      context: context,
      textStyle: textStyle,
      availableTextWidth: availableTextWidth,
      iconWidth: iconWidth,
    ).clamp(0.0, maxWidth).toDouble();

    final child = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: itemWidth,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: borderColor,
          width: selected ? 1.5 : 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (selected) ...[
            Icon(Icons.check_circle_outline, color: primary, size: 18),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: BodyMediumText(
              text: title,
              color: textColor,
            ),
          ),
        ],
      ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: child,
      ),
    );
  }

  double _calculateWidth({
    required BuildContext context,
    required TextStyle? textStyle,
    required double availableTextWidth,
    required double iconWidth,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(text: title, style: textStyle),
      textDirection: Directionality.of(context),
    )..layout(maxWidth: availableTextWidth);

    return textPainter.width + 28 + iconWidth;
  }
}


class _ServicesEmptyMessage extends StatelessWidget {
  const _ServicesEmptyMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p24),
        child: Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
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
                    title: isSubmitting ? 'در حال ثبت...' : 'ثبت',
                    backgroundColor: theme.colorScheme.primary,
                    borderColor: theme.colorScheme.primary,
                    titleColor: theme.colorScheme.onPrimary,
                    showLoading: isSubmitting,
                    onTap: () async {
                      if (isSubmitting) return;

                      final submitted = await cubit.submitServices();
                      if (submitted && context.mounted) {
                        Navigator.of(context).pop<bool>(true);
                      }
                    },
                  ),
                ),
                Space.w12,
                Expanded(
                  child: InkwellButtonWidget(
                    title: 'بستن',
                    backgroundColor: theme.colorScheme.onPrimary,
                    borderColor: theme.colorScheme.outline,
                    titleColor: theme.colorScheme.onSurface,
                    borderWidth: AppSize.s1,
                    onTap: () {
                      if (isSubmitting) return;
                      Navigator.of(context).pop<bool>(false);
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
