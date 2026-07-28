import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/cubit/navgan_cubit.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/cubit/navgan_state.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/widgets/navgan_grade_pattern_detail_view.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/overlay_dropdown_form_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/sticky_form_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NavganGradePatternPage extends StatelessWidget {
  static const path = '/navgan-grade-pattern-page';
  static const name = 'navgan-grade-pattern-page';

  const NavganGradePatternPage({
    super.key,
    required this.navgan,
  });

  final NavganEntity navgan;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NavganCubit>()..prepareGradeSheet(navgan),
      child: const _NavganGradePatternView(),
    );
  }
}

class _NavganGradePatternView extends StatelessWidget {
  const _NavganGradePatternView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NavganCubit>();
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<NavganCubit, NavganState>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage ||
            previous.successMessage != current.successMessage,
        listener: (context, state) {
          final error = state.errorMessage;
          if (error?.trim().isNotEmpty == true) {
            SnakeBarWidget.showError(context: context, message: error!);
          }

          final success = state.successMessage;
          if (success?.trim().isNotEmpty == true) {
            SnakeBarWidget.showSuccess(context: context, message: success!);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF6F6F6),
            appBar: const SimpleActionBar(title: 'الگوی گرید'),
            body: SafeArea(
              top: false,
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.all(AppPadding.p16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _NavganSummaryCard(navgan: state.selectedNavgan),
                    Space.h16,
                    Container(
                      padding: const EdgeInsets.all(AppPadding.p16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(AppSize.s8),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.shadow.withOpacity(0.08),
                            blurRadius: AppSize.s12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          OverlayDropdownFormField<GradePatternEntity>(
                            key: ValueKey(
                              'navgan-grade-pattern-${state.selectedGradePattern?.id}-${state.gradePatterns.length}',
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
                            NavganGradePatternDetailView(
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
                  ],
                ),
              ),
            ),
            bottomNavigationBar: StickyFormActionBar(
              submitTitle: 'ثبت',
              cancelTitle: 'انصراف',
              isSubmitting: state.isGradeSubmitting,
              onSubmit: () async {
                final success = await cubit.submitGradeReference();
                if (success && context.mounted) context.pop(true);
              },
              onCancel: () => context.pop(),
            ),
          );
        },
      ),
    );
  }
}

class _NavganSummaryCard extends StatelessWidget {
  const _NavganSummaryCard({required this.navgan});

  final NavganEntity? navgan;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.08),
            blurRadius: AppSize.s12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: AppSize.s24,
            backgroundColor: theme.colorScheme.primary.withAlpha(25),
            child: Icon(
              Icons.commute_rounded,
              color: theme.colorScheme.primary,
            ),
          ),
          Space.w12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  navgan?.title?.trim().isNotEmpty == true
                      ? navgan!.title!.trim()
                      : '---',
                  textAlign: TextAlign.right,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Space.h6,
                Text(
                  'کد ناوگان: ${navgan?.code ?? '---'}',
                  textAlign: TextAlign.right,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
