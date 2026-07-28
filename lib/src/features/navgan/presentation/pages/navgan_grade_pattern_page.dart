import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/grade_pattern_reference_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/cubit/navgan_cubit.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/cubit/navgan_state.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/pages/navgan_grade_pattern_form_page.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/widgets/navgan_grade_pattern_action_sheet.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/widgets/navgan_grade_pattern_ui_mapper.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/delete_confirm_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/floating_action_button_widget.dart';
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
            floatingActionButton: FloatingActionButtonWidget(
              title: 'ثبت الگوی جدید',
              onPressed: () {
                _openForm(
                  context,
                  cubit,
                  state.selectedNavgan,
                );
              },
            ),
            body: SafeArea(
              top: false,
              child: _GradePatternList(
                state: state,
                onDetails: (reference) =>
                    _showDetails(context, cubit, reference),
                onOperations: (reference) =>
                    _showOperationSheet(context, cubit, state, reference),
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
    GradePatternReferenceEntity reference,
  ) async {
    final pattern = cubit.patternForReference(reference);
    if (pattern == null) {
      SnakeBarWidget.showError(
        context: context,
        message: 'الگوی گرید مرتبط با این رفرنس یافت نشد.',
      );
      return;
    }

    var detail = pattern;
    await cubit.loadGradePatternDetail(
      pattern,
      loadingId: reference.id ?? reference.gradePatternId,
    );
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

  void _showOperationSheet(
    BuildContext context,
    NavganCubit cubit,
    NavganState state,
    GradePatternReferenceEntity reference,
  ) {
    BottomSheetMessage.showCustom(
      context: context,
      content: Builder(
        builder: (sheetContext) {
          return NavganGradePatternActionSheet(
            loadingAction: state.isGradeDeleting
                ? NavganGradePatternOperation.delete
                : null,
            onActionSelected: (operation) async {
              Navigator.of(sheetContext).pop();
              await Future<void>.delayed(Duration.zero);
              if (!context.mounted) return;

              switch (operation) {
                case NavganGradePatternOperation.delete:
                  _showDeleteSheet(context, cubit, reference);
                  return;
              }
            },
          );
        },
      ),
      actionWidget: const SizedBox.shrink(),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
    );
  }

  void _showDeleteSheet(
    BuildContext context,
    NavganCubit cubit,
    GradePatternReferenceEntity reference,
  ) {
    final referenceId = reference.id;
    if (referenceId == null) {
      SnakeBarWidget.showError(
        context: context,
        message: 'شناسه الگوی گرید برای حذف یافت نشد.',
      );
      return;
    }

    BottomSheetMessage.showCustom(
      context: context,
      content: Builder(
        builder: (sheetContext) {
          return DeleteConfirmSheet(
            title: 'حذف الگوی گرید',
            message: 'آیا الگوی گرید ${reference.gradePatternName ?? '---'} حذف شود؟',
            confirmTitle: 'حذف',
            isSubmitting: cubit.state.isGradeDeleting,
            onConfirm: () async {
              final success = await cubit.deleteGradeReference(referenceId);
              if (success && sheetContext.mounted) {
                Navigator.of(sheetContext).pop();
              }
            },
          );
        },
      ),
      actionWidget: const SizedBox.shrink(),
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      maxHeight: 0.5,
    );
  }

  Future<void> _openForm(
    BuildContext context,
    NavganCubit cubit,
    NavganEntity? navgan,
  ) async {
    if (navgan == null) {
      SnakeBarWidget.showError(
        context: context,
        message: 'اطلاعات ناوگان یافت نشد.',
      );
      return;
    }

    final changed = await context.pushNamed<bool>(
      NavganGradePatternFormPage.name,
      extra: NavganGradePatternFormPageArgs(
        navgan: navgan,
      ),
    );
    if (changed == true) {
      await cubit.fetchGradePatternReferences(navgan);
    }
  }
}

class _GradePatternList extends StatelessWidget {
  const _GradePatternList({
    required this.state,
    required this.onDetails,
    required this.onOperations,
  });

  final NavganState state;
  final ValueChanged<GradePatternReferenceEntity> onDetails;
  final ValueChanged<GradePatternReferenceEntity> onOperations;

  @override
  Widget build(BuildContext context) {
    if (state.isGradeReferencesLoading) {
      return const Center(child: LoadingWidget());
    }

    final items = state.gradeReferences;
    if (items.isEmpty) {
      return const Center(child: EmptyListWidget());
    }

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

        final reference = items[index - 1];
        final serviceType = ServiceType.fromValue(
          reference.serviceTypeId ?? state.selectedNavgan?.emdadgarNavganType,
        );
        return GradePatternListCard(
          item: reference.toUiModel(),
          showSummary: false,
          isDetailsLoading: state.isGradeDetailLoading &&
              state.loadingGradeDetailId ==
                  (reference.id ?? reference.gradePatternId),
          statusLabelText: reference.serviceTypeTitle ?? serviceType.label,
          statusLabelColor: serviceType.serviceColor,
          onDetails: () => onDetails(reference),
          onAction: () => onOperations(reference),
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
