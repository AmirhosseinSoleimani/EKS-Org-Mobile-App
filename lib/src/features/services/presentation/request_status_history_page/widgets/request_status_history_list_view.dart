import 'package:eks_sana_plus_org/src/features/services/domain/entities/request_status_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/key_value_row.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_status_history_page/cubit/request_status_history_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_status_history_page/cubit/request_status_history_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/timeline_item_card.dart';

class RequestStatusHistoryListView extends StatelessWidget {
  final List<RequestStatusHistoryItemEntity> items;
  final Widget icon;

  const RequestStatusHistoryListView({
    super.key,
    required this.items,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isEmpty = items.isEmpty;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BodyMediumText(text: "تاریخچه وضعیت درخواست"),
          const SizedBox(height: 8),
          if (isEmpty)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.62,
              child: const Center(
                child: EmptyListWidget(),
              ),
            ),
          if (!isEmpty) ...[
            BlocBuilder<RequestStatusHistoryCubit, RequestStatusHistoryState>(
              builder: (context, state) {
                final cubit = context.read<RequestStatusHistoryCubit>();
                final items = cubit.items;

                if (items.isEmpty) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.62,
                    child: const Center(
                      child: EmptyListWidget(),
                    ),
                  );
                }

                return ListView.builder(
                  key: const PageStorageKey('request_status_history_list'),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return TimelineItemCard(
                      icon: icon,
                      children: [
                        KeyValueRow(
                          label: 'عنوان',
                          value: item.title ?? '-',
                        ),
                        KeyValueRow(
                          label: 'ثبت کننده',
                          value: item.insertUserName ?? '-',
                        ),
                        KeyValueRow(
                          label: 'تاریخ و ساعت ثبت',
                          value: item.insertDateTime ?? '-',
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const BodySmallText(text: 'توضیحات'),
                            Space.h8,
                            BodySmallText(
                              text: item.description!,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        )
                      ],
                    );
                  },
                );
              },
            ),
            BlocBuilder<RequestStatusHistoryCubit, RequestStatusHistoryState>(
              builder: (context, state) {
              final cubit = context.read<RequestStatusHistoryCubit>();

              if (!cubit.hasMore) {
                return const SizedBox();
              }

              final loadingMore = state.whenOrNull(
                loadingMore: () => true,
              );

              if (loadingMore == true) {
                return  Padding(
                  padding: const EdgeInsets.all(12),
                  child: Center(
                    child: CircularProgressIndicator(
                      color:  cubit.selectedRequest?.serviceType?.serviceColor,
                    ),
                  ),
                );
              }
              return Center(
                child: TextButton(
                  onPressed: () => cubit.loadMore(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BodyMediumText(
                        text: 'مشاهده بیشتر',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Space.w4,
                      const Icon(Icons.expand_more),
                    ],
                  ),
                ),
              );
            },
          ),
          ]
        ],
      ),
    );
  }
}
