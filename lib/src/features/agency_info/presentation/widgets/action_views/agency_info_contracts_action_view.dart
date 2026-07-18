import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_action_agency_header.dart';
import 'package:flutter/material.dart';

class AgencyInfoContractsActionView extends StatelessWidget {
  const AgencyInfoContractsActionView({
    super.key,
    required this.item,
  });

  final AgencyInfoEntity item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AgencyInfoActionAgencyHeader(item: item),
        const SizedBox.shrink(),
      ],
    );
  }
}
