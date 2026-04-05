import 'package:eks_sana_plus_org/src/features/requests/domain/entities/enums/request_type.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_list/widgets/shimmer/request_item_shimmer.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_list/widgets/tab_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class TabsWithShimmer extends StatelessWidget {
  const TabsWithShimmer({super.key});

  final tabs = const ['خدمات امدادی', 'خدمت در محل'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        children: [
          TabBarWidget(
            tabs: tabs,
            selectedTab: RequestType.reliefService,
          ),
          Space.h16,
          const Expanded(
            child: _RequestListShimmer(),
          ),
        ],
      ),
    );
  }
}



class _RequestListShimmer extends StatelessWidget {
  const _RequestListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppPadding.p16),
      itemCount: 4,
      itemBuilder: (_, __) => const RequestItemShimmer(),
    );
  }
}
