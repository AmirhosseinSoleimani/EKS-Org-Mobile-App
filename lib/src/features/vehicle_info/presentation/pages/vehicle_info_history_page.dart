import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/cubit/vehicle_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/vehicle_history_tile.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/vehicle_service_info_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VehicleInfoHistoryPage extends StatelessWidget {
  static const path = '/vehicle-info-history-page';
  static const name = 'vehicle-info-history-page';

  const VehicleInfoHistoryPage({super.key, required this.item});

  final VehicleInfoEntity item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<VehicleInfoCubit>();
        final id = item.id;
        if (id != null) {
          cubit.loadHistory(refId: id, type: 2);
        }
        return cubit;
      },
      child: _VehicleInfoHistoryView(item: item),
    );
  }
}

class _VehicleInfoHistoryView extends StatelessWidget {
  const _VehicleInfoHistoryView({required this.item});

  final VehicleInfoEntity item;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VehicleInfoCubit>();

    return BlocListener<VehicleInfoCubit, VehicleInfoState>(
      listener: (context, state) {
        state.whenOrNull(
          failure: (data) {
            BottomSheetMessage.showError(
              context: context,
              data: BottomSheetMessageModel(
                title: 'خطا',
                message: data.errorMessage ?? 'عملیات با خطا مواجه شد.',
              ),
              onButtonTap: () {
                context.pop();
                if (cubit.hasRetryAction) {
                  cubit.retryLastAction();
                }
              },
            );
          },
          connectionError: (data) {
            BottomSheetMessage.showCustom(
              context: context,
              content: NoInternetBottomSheet(
                onRetry: cubit.hasRetryAction ? cubit.retryLastAction : () => context.pop(),
              ),
              actionWidget: const SizedBox.shrink(),
              isDismissible: false,
              enableDrag: false,
            );
          },
        );
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: const SimpleAppBar(title: 'تاریخچه'),
          backgroundColor: const Color(0xFFF4F4F4),
          body: BlocBuilder<VehicleInfoCubit, VehicleInfoState>(
            builder: (context, state) {
              final data = state.data;
              final isLoading = data.loadingHistoryRefId != null;
              return RefreshIndicator(
                onRefresh: () async {
                  final id = item.id;
                  if (id == null) return;
                  await cubit.loadHistory(refId: id, type: 2);
                },
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppPadding.p16,
                      AppPadding.p16,
                      AppPadding.p16,
                      0,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          VehicleServiceInfoCard(item: item),
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
                  else if (data.histories.isEmpty)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(child: EmptyListWidget()),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(
                        AppPadding.p16,
                        0,
                        AppPadding.p16,
                        AppPadding.p16,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final history = data.histories[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: AppPadding.p18),
                              child: VehicleHistoryTile(history: history),
                            );
                          },
                          childCount: data.histories.length,
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
