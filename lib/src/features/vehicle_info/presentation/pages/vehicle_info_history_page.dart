import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/cubit/vehicle_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/vehicle_service_info_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
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
              return CustomScrollView(
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
                          VehicleServiceInfoCard(item:item),
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
                              padding: const EdgeInsets.only(bottom: AppPadding.p12),
                              child: _HistoryTile(history: history),
                            );
                          },
                          childCount: data.histories.length,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.history});

  final VehicleHistoryEntity history;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppPadding.p14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE4E4E4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [

              Space.w8,
              Expanded(
                child: Text(
                  _actionTitle(history.actionType),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                _dash(history.insertDateTimeJalali),
                textDirection: TextDirection.ltr,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF777777),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Space.h12,
          Text(
            _dash(history.description),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF202020),
              height: 1.7,
              fontWeight: FontWeight.w600,
            ),
          ),
          Space.h12,
          Row(
            children: [
              _MetaChip(title: _dash(history.entityTypeTitle)),
              Space.w8,
              _MetaChip(title: 'کاربر: ${_dash(history.insertUserName)}'),
            ],
          ),
        ],
      ),
    );
  }

  String _actionTitle(int? value) {
    switch (value) {
      case 1:
        return 'ثبت';
      case 2:
        return 'ویرایش';
      case 3:
        return 'حذف';
      default:
        return 'تاریخچه';
    }
  }

  String _dash(String? value) => value?.trim().isNotEmpty == true ? value!.trim() : '---';
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFF666666),
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
