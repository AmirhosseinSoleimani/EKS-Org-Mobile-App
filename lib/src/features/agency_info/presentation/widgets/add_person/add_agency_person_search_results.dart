import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/person_info_search_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/add_person/add_agency_person_state.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/add_person/agency_person_summary_card.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_action_content_widgets.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class AddAgencyPersonSearchResults extends StatelessWidget {
  const AddAgencyPersonSearchResults({
    super.key,
    required this.state,
    required this.onAdd,
  });

  final AddAgencyPersonState state;
  final ValueChanged<PersonInfoSearchEntity> onAdd;

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
    if (state.status == AddAgencyPersonStatus.searchEmpty) {
      return const Center(
        key: ValueKey('search-empty'),
        child: EmptyListWidget(),
      );
    }

    if (state.persons.isEmpty) {
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
                  '${AgencyInfoActionFormatter.toPersianDigits(state.searchCount.toString())} مورد',
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
        Space.h12,
        Expanded(
          child: ListView.separated(
            itemCount: state.persons.length,
            separatorBuilder: (_, __) => Space.h12,
            itemBuilder: (context, index) {
              final person = state.persons[index];
              return AgencyPersonSummaryCard(
                person: person,
                onAdd: () => onAdd(person),
              );
            },
          ),
        ),
      ],
    );
  }
}
