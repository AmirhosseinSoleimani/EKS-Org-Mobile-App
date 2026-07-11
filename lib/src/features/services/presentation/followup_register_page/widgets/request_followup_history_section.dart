import 'package:eks_sana_plus_org/src/features/services/presentation/followup_register_page/cubit/follow_up_register_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/followup_register_page/widgets/request_followup_history_item.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
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

        if (items.isEmpty) {
          return const Center(
            child: EmptyListWidget(),
          );
        }

        return Column(
          children: [
            ...List.generate(items.length, (index) {
              final item = items[index];
              return RequestFollowupHistoryItem.fromEntity(item);
            }),

            if (cubit.hasMoreItems)
              state.maybeWhen(
                loadingMore: () => const CircularProgressIndicator(),
                orElse: () =>
                    Center(
                      child: TextButton(
                        onPressed: () => cubit.loadMoreItems(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BodyMediumText(
                              text: 'مشاهده بیشتر',
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary,
                            ),
                            Space.w4,
                            const Icon(Icons.expand_more),
                          ],
                        ),
                      ),
                    ),
              ),
          ],
        );
      },
    );
  }
}
