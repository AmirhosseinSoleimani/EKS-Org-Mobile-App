import 'package:eks_sana_plus_org/src/features/requests/presentation/request_list/widgets/shimmer/request_item_shimmer.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class ActiveRequestShimmerWidget extends StatelessWidget {
  const ActiveRequestShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppPadding.p16),
      child: _RequestListShimmer(),
    );
  }
}


class _RequestListShimmer extends StatelessWidget {
  const _RequestListShimmer();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppPadding.p16),
      itemCount: 2,
      itemBuilder: (_, __) => const RequestItemShimmer(),
    );
  }
}
