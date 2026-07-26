import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_action_content_widgets.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class AgencyAddSearchResults<T> extends StatelessWidget {
  const AgencyAddSearchResults({
    super.key,
    required this.items,
    required this.count,
    required this.showEmpty,
    required this.itemBuilder,
  });

  final List<T> items;
  final int count;
  final bool showEmpty;
  final Widget Function(BuildContext context, T item) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      child: _child(context),
    );
  }

  Widget _child(BuildContext context) {
    if (showEmpty) {
      return const Center(
        key: ValueKey('search-empty'),
        child: EmptyListWidget(),
      );
    }

    if (items.isEmpty) {
      return const SizedBox(key: ValueKey('search-initial'));
    }

    return Column(
      key: const ValueKey('search-results'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: BodyMediumText(
                text: 'نتایج جستجو',
                fontWeight: FontWeight.w800,
                fontSize: AppSize.s16,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            BodySmallText(
              text:
                  '${AgencyInfoActionFormatter.toPersianDigits(count.toString())} مورد',
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
        Space.h12,
        Expanded(
          child: ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => Space.h12,
            itemBuilder: (context, index) {
              return itemBuilder(context, items[index]);
            },
          ),
        ),
      ],
    );
  }
}
