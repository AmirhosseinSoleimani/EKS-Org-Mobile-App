import 'package:eks_sana_plus_org/src/features/requests/domain/entities/enums/request_type.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_list/cubit/request_list_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabBarWidget extends StatelessWidget {
  final RequestType selectedTab;
  final List<String> tabs;

  const TabBarWidget(
      {super.key, required this.selectedTab, required this.tabs});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final tabWidth = MediaQuery.of(context).size.width / tabs.length;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: List.generate(
            tabs.length,
                (index) => _TabTitle(
              title: tabs[index],
              onTap: () => context
                  .read<RequestListCubit>()
                  .selectTab(RequestType.values[index]),
            ),
          ),
        ),
        SizedBox(
          height: AppSize.s4,
          child: Stack(
            children: [
              Container(
                height: AppSize.s2,
                color: colorScheme.inverseSurface,
              ),
              AnimatedAlign(
                alignment: selectedTab == RequestType.homeService
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Container(
                  width: tabWidth,
                  height: AppSize.s4,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TabTitle extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _TabTitle({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
            child: TitleLargeText(
              text: title,
              fontSize: AppSize.s16,
              color: colorScheme.shadow,
            ),
          ),
        ),
      ),
    );
  }
}

