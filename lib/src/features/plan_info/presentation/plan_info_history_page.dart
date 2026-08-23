import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/cubit/plan_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/cubit/plan_info_state.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/widgets/plan_history_summary_card.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/widgets/plan_history_tile.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/refresh_widgets/swipe_refresh_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PlanInfoHistoryPage extends StatelessWidget {
  static const path = '/plan-info-history-page';
  static const name = 'plan-info-history-page';

  const PlanInfoHistoryPage({
    super.key,
    required this.item,
  });

  final PlanInfoEntity item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<PlanInfoCubit>();
        final id = item.resolvedId;
        if (id != null) {
          cubit.loadHistory(refId: id);
        }
        return cubit;
      },
      child: _PlanInfoHistoryView(item: item),
    );
  }
}

class _PlanInfoHistoryView extends StatelessWidget {
  const _PlanInfoHistoryView({required this.item});

  final PlanInfoEntity item;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PlanInfoCubit>();

    return BlocListener<PlanInfoCubit, PlanInfoState>(
      listenWhen: (previous, current) {
        final messageChanged = previous.message != current.message;
        final connectionErrorStarted =
            previous.status != PlanInfoStatus.connectionError &&
                current.status == PlanInfoStatus.connectionError;
        return messageChanged || connectionErrorStarted;
      },
      listener: (context, state) {
        if (state.status == PlanInfoStatus.connectionError) {
          BottomSheetMessage.showCustom(
            context: context,
            content: NoInternetBottomSheet(
              onRetry: () {
                final id = item.resolvedId;
                if (id == null) return;
                cubit.loadHistory(refId: id);
              },
            ),
            actionWidget: const SizedBox.shrink(),
            isDismissible: false,
            enableDrag: false,
          );
          return;
        }

        final message = state.message?.trim();
        if (message == null || message.isEmpty) return;

        if (state.status == PlanInfoStatus.error) {
          BottomSheetMessage.showError(
            isDismissible: true,
            enableDrag: true,
            context: context,
            data: BottomSheetMessageModel(
              title: 'خطا',
              message: message,
            ),
            onButtonTap: () {
              context.pop();
              final id = item.resolvedId;
              if (id != null) {
                cubit.loadHistory(refId: id);
              }
            },
          );
          return;
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: const SimpleAppBar(title: 'تاریخچه'),
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: BlocBuilder<PlanInfoCubit, PlanInfoState>(
            builder: (context, state) {
              if (state.status == PlanInfoStatus.connectionError) {
                return SwipeRefreshContainer(
                  onRefresh: () async {
                    final id = item.resolvedId;
                    if (id == null) return;
                    await cubit.loadHistory(refId: id);
                  },
                  child: const Center(child: EmptyListWidget()),
                );
              }

              final isLoading = state.loadingHistoryRefId != null;

              return RefreshIndicator(
                onRefresh: () async {
                  final id = item.resolvedId;
                  if (id == null) return;
                  await cubit.loadHistory(refId: id);
                },
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppPadding.p16,
                      AppPadding.p16,
                      AppPadding.p16,
                      AppPadding.p0,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          PlanHistorySummaryCard(item: item),
                          Space.h24,
                        ],
                      ),
                    ),
                  ),
                  if (isLoading)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (state.histories.isEmpty)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(child: EmptyListWidget()),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(
                        AppPadding.p16,
                        AppPadding.p0,
                        AppPadding.p16,
                        AppPadding.p16,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final history = state.histories[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppPadding.p18,
                              ),
                              child: PlanHistoryTile(history: history),
                            );
                          },
                          childCount: state.histories.length,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
