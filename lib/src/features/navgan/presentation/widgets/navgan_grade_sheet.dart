import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/cubit/navgan_cubit.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/cubit/navgan_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/full_screen_bottom_sheet_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/overlay_dropdown_form_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/sticky_form_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavganGradeSheet extends StatelessWidget {
  const NavganGradeSheet({
    super.key,
    required this.onSubmit,
    required this.onCancel,
  });

  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NavganCubit>();
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocBuilder<NavganCubit, NavganState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: theme.colorScheme.onPrimary,
            body: Column(
              children: [
                FullScreenBottomSheetAppBar(
                  title: 'ثبت الگوی گرید',
                  onClose: onCancel,
                ),
                Expanded(
                  child: SafeArea(
                    top: false,
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.all(AppPadding.p16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          OverlayDropdownFormField<GradePatternEntity>(
                            key: ValueKey(
                              'grade-pattern-${state.selectedGradePattern?.id}-${state.gradePatterns.length}',
                            ),
                            labelText: 'الگوی گرید',
                            mandatory: true,
                            items: state.gradePatterns,
                            value: state.selectedGradePattern,
                            enabled: !state.isGradePatternsLoading &&
                                state.gradePatterns.isNotEmpty,
                            hintText: state.isGradePatternsLoading
                                ? 'در حال دریافت...'
                                : 'انتخاب کنید',
                            onChanged: cubit.selectGradePattern,
                          ),
                          Space.h20,
                          if (state.isGradeDetailLoading)
                            const Center(child: LoadingWidget())
                          else if (state.gradePatternDetail != null)
                            GradePatternDetailView(
                              item: state.gradePatternDetail!,
                            )
                          else
                            BodySmallText(
                              text:
                                  'برای مشاهده جزئیات، یک الگوی گرید انتخاب کنید.',
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: StickyFormActionBar(
              submitTitle: 'ثبت',
              cancelTitle: 'انصراف',
              isSubmitting: state.isGradeSubmitting,
              onSubmit: onSubmit,
              onCancel: onCancel,
            ),
          );
        },
      ),
    );
  }
}

class GradePatternDetailView extends StatelessWidget {
  const GradePatternDetailView({super.key, required this.item});

  final GradePatternEntity item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final details = item.details;

    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSize.s8),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TitleLargeText(
            text: item.name ?? item.label,
            color: theme.colorScheme.onSurface,
            fontSize: AppSize.s16,
          ),
          Space.h12,
          if (details.isEmpty)
            BodySmallText(
              text: 'جزئیاتی برای این الگو ثبت نشده است.',
              color: theme.colorScheme.onSurfaceVariant,
            )
          else
            ...details.map((detail) => _GradeDetailRow(item: detail)),
        ],
      ),
    );
  }
}

class _GradeDetailRow extends StatelessWidget {
  const _GradeDetailRow({required this.item});

  final GradePatternEntity item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p12),
      child: Row(
        children: [
          Expanded(
            child: BodyMediumText(
              text: item.gradeTitle ?? '---',
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
          BodySmallText(
            text: 'ضریب: ${item.gradeCoefficient ?? 0}',
            color: theme.colorScheme.onSurfaceVariant,
          ),
          Space.w12,
          BodySmallText(
            text: 'کمیسیون: ${item.managmentCommisionPercent ?? 0}',
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}
