import 'package:eks_sana_plus_org/src/features/services/presentation/followup_register_page/cubit/follow_up_register_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/key_value_row.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/key_value_wiget_row.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestFollowupHistorySection extends StatelessWidget {
  const RequestFollowupHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FollowUpRegisterCubit, FollowUpRegisterState>(
      builder: (context, state) {
        final cubit = context.read<FollowUpRegisterCubit>();
        final items = cubit.displayedHistory;
        return (items.isEmpty)
            ? const Center(child: EmptyListWidget())
            : Column(
                children: [
                  ...List.generate(items.length, (index) {
                    final item = items[index];

                    final followupDate = item.followUpDateJalali ?? "-";
                    final followupTime = item.followUpTime ?? "-";

                    final insertDate = item.insertDateTimeJalali ?? "-";
                    final insertTime = item.insertTime ?? "-";

                    final result = item.resultStatusTitle ?? "-";
                    final source = item.sourceTypeTitle ?? "-";

                    final creator = item.authorFullName != null
                        ? "${item.authorFullName} (${item.authorTypeTitle ?? '-'})"
                        : "-";

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          KeyValueWidgetRow(
                            label: "نتیجه پیگیری",
                            value: StatusLabel(
                              text: result,
                              color: Colors.purple,
                            ),
                          ),
                          KeyValueRow(
                            label: "تاریخ و ساعت",
                            value: "$followupDate - $followupTime",
                          ),
                          KeyValueRow(label: "منبع", value: source),
                          KeyValueRow(label: "ثبت کننده", value: creator),
                          KeyValueRow(
                            label: "تاریخ و ساعت ثبت",
                            value: "$insertDate - $insertTime",
                          ),
                          if ((item.description ?? "").trim().isNotEmpty)
                            KeyValueRow(
                              label: "توضیحات",
                              value: item.description ?? '',
                            ),
                        ],
                      ),
                    );
                  }),

                  // دکمه مشاهده بیشتر
                  if (cubit.hasMoreItems)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: state.maybeWhen(
                        loadingMore: () => const CircularProgressIndicator(),
                        orElse: () => OutlinedButton(
                          onPressed: () => cubit.loadMoreItems(),
                          child: const Text('مشاهده بیشتر'),
                        ),
                      ),
                    ),
                ],
              );
      },
    );
  }
}
