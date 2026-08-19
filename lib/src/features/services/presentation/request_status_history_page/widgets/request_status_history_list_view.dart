import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/key_value_row.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_status_history_page/cubit/request_status_history_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_status_history_page/cubit/request_status_history_state.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/vertical_line_indicator.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/list_widgets/list_section_header.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/timeline_item_card.dart';

class RequestStatusHistoryListView extends StatelessWidget {
  final Widget icon;

  const RequestStatusHistoryListView({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: ListSectionHeader(title: 'تاریخچه وضعیت درخواست'),
          ),
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

                return Stack(
                  children: [
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: VerticalLineIndicator(icon: icon),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: ListView.builder(
                        key: const PageStorageKey(
                            'request_status_history_list'),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return TimelineItemCard(
                            children: [
                              KeyValueRow(
                                label: item.title ?? '-',
                                valueFontSize: 14,
                                boldLabel: true,
                                value: item.insertDateTimeJalali ?? '-',
                              ),
                              Space.h8,
                              KeyValueRow(
                                leadingWidget: Icon(
                                    Icons.person_rounded, size: 18,
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .onSurface),
                                label: '',
                                value: item.insertUserName ?? '-',
                                boldValue: true,
                                mainAxisAlignment: MainAxisAlignment.start,
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Space.h8,
                                  BodySmallText(
                                    text: item.description!,
                                    textAlign: TextAlign.start,
                                    fontSize: 12,
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
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
                    child: SizedBox(
                      height: 24,width: 24,
                      child: CircularProgressIndicator(
                        color:  cubit.selectedRequest?.serviceType?.serviceColor,
                        strokeWidth: 2,

                      ),
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
                        color: cubit.selectedRequest?.serviceType?.serviceColor ?? ServiceType.reliefService.serviceColor,
                      ),
                      Space.w4,
                       Icon(Icons.expand_more, color: cubit.selectedRequest?.serviceType?.serviceColor ?? ServiceType.reliefService.serviceColor,),
                    ],
                  ),
                ),
              );
            },
          ),

        ],
      ),
    );
  }
}
