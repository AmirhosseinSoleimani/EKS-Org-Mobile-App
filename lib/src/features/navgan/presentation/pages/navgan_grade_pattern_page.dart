import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/cubit/navgan_cubit.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/cubit/navgan_state.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/widgets/navgan_grade_pattern_ui_mapper.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/grade_pattern/grade_pattern_details_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/grade_pattern/grade_pattern_list_card.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
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
              child: _GradePatternList(
                state: state,
                onDetails: (item) => _showDetails(context, cubit, item),
                onAssign: (item) async {
                  final success = await cubit.assignGradePattern(item);
                  if (success && context.mounted) context.pop(true);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _showDetails(
    BuildContext context,
    NavganCubit cubit,
    GradePatternEntity item,
  ) async {
    var detail = item;
    await cubit.loadGradePatternDetail(item);
    final loaded = cubit.state.gradePatternDetail;
    if (loaded != null) detail = loaded;

    if (!context.mounted) return;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s20)),
      ),
      builder: (_) => GradePatternDetailsSheet(item: detail.toUiModel()),
    );
  }
}

class _GradePatternList extends StatelessWidget {
  const _GradePatternList({
    required this.state,
    required this.onDetails,
    required this.onAssign,
  });

  final NavganState state;
  final ValueChanged<GradePatternEntity> onDetails;
  final ValueChanged<GradePatternEntity> onAssign;

  @override
  Widget build(BuildContext context) {
    if (state.isGradePatternsLoading) {
      return const Center(child: LoadingWidget());
    }

    final items = state.gradePatterns;
    if (items.isEmpty) {
      return const Center(child: EmptyListWidget());
    }

    final selectedId =
        state.selectedGradePattern?.id ?? state.selectedGradePattern?.gradeId;

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppPadding.p16,
        AppPadding.p16,
        AppPadding.p16,
        AppPadding.p100,
      ),
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _NavganSummaryCard(navgan: state.selectedNavgan),
              Space.h16,
            ],
          );
        }

        final item = items[index - 1];
        final itemId = item.id ?? item.gradeId;
        return GradePatternListCard(
          item: item.toUiModel(),
          isDetailsLoading: state.isGradeDetailLoading && selectedId == itemId,
          isActionLoading: state.isGradeSubmitting && selectedId == itemId,
          actionTitle: 'ثبت الگو',
          actionIcon: Icons.add_task_outlined,
          actionSuffixIcon: null,
          onDetails: () => onDetails(item),
          onAction: () => onAssign(item),
        );
      },
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
