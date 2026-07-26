import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/person_info_search_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/add_person/add_agency_person_state.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/add_flow/agency_add_search_results.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/add_person/agency_person_summary_card.dart';
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
    return AgencyAddSearchResults<PersonInfoSearchEntity>(
      items: state.persons,
      count: state.searchCount,
      showEmpty: state.status == AddAgencyPersonStatus.searchEmpty,
      itemBuilder: (context, person) {
        return AgencyPersonSummaryCard(
          person: person,
          onAdd: () => onAdd(person),
        );
      },
    );
  }
}
