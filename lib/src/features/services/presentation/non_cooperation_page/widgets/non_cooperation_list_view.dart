import 'package:eks_sana_plus_org/src/features/services/domain/entities/non_cooperation_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/non_cooperation_page/cubit/non_cooperation_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/key_value_wiget_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/vertical_line_indicator.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/widgets/request_widgets/key_value_row.dart';
import '../../widgets/timeline_item_card.dart';

class NonCooperationListView extends StatelessWidget {
  final List<NonCooperationItemEntity> items;
  final Widget icon;

  const NonCooperationListView({
    super.key,
    required this.items,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isEmpty = items.isEmpty;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
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
          Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 8.0),
              child: const BodyMediumText(text: "لیست درخواست های عدم همکاری")),
          const SizedBox(height: 8),
          if (isEmpty)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.62,
              child: const Center(
                child: EmptyListWidget(),
              ),
            ),
          if (!isEmpty) ...[
            BlocBuilder<NonCooperationCubit, NonCooperationState>(
              builder: (context, state) {
                final cubit = context.read<NonCooperationCubit>();
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
                      padding: const EdgeInsets.only(top: 18.0),
                      child: ListView.builder(
                        key: const PageStorageKey('non_cooperation_list'),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];

                          return TimelineItemCard(
                            children: [
                              KeyValueRow(
                                label: "نام نمایندگی (کد نمایندگی)",
                                value:
                                    "${item.agencyName ?? '-'} (${item.agencyCode ?? '-'})",
                              ),
                              KeyValueRow(
                                label: "نام امدادرسان",
                                value: item.aidPerName ?? "-",
                              ),
                              KeyValueRow(
                                label: "ثبت کننده",
                                value: item.authorFullname ?? "-",
                              ),
                              KeyValueRow(
                                label: "تاریخ و ساعت ثبت",
                                value:
                                    "${item.submitDateJalali ?? '-'} - ${item.submitTime ?? '-'}",
                              ),
                              KeyValueWidgetRow(
                                label: "نوع عدم همکاری",
                                value: StatusLabel(
                                  text: item.typeOfLackTitle ?? "-",
                                  color: Colors.grey,
                                  variant: StatusLabelVariant.outlined,
                                ),
                              ),
                              KeyValueRow(
                                label: "توضیحات",
                                value: item.description ?? "-",
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
            BlocBuilder<NonCooperationCubit, NonCooperationState>(
            builder: (context, state) {
              final cubit = context.read<NonCooperationCubit>();

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
                        color: cubit.selectedBaseRequest?.serviceType?.serviceColor
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
