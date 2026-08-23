import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_additional_information_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_action_agency_header.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_action_content_widgets.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class AgencyInfoComplementaryInfoActionView extends StatelessWidget {
  const AgencyInfoComplementaryInfoActionView({
    super.key,
    required this.item,
    required this.information,
  });

  final AgencyInfoEntity item;
  final AgencyAdditionalInformationEntity? information;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AgencyInfoActionAgencyHeader(item: item),
        Space.h24,
        Expanded(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: AppPadding.p24),
            child: AgencyInfoActionCard(
              child: Column(
                children: [
                  AgencyInfoActionLabelValueRow(
                    label: 'شناسه ملی',
                    value: information?.agencyNationalId,
                    useSpaceBetween: true,
                  ),
                  AgencyInfoActionLabelValueRow(
                    label: 'کد تفصیلی',
                    value: information?.detailedCode,
                    useSpaceBetween: true,
                  ),
                  AgencyInfoActionLabelValueRow(
                    label: 'شماره پیگیری',
                    value: information?.trackingNumber,
                    useSpaceBetween: true,
                  ),
                  AgencyInfoActionLabelValueRow(
                    label: 'پرونده مالیاتی',
                    value: _taxFileStatus(information?.taxFileCompleted),
                    useSpaceBetween: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  static String? _taxFileStatus(bool? isCompleted) {
    if (isCompleted == null) return null;
    return isCompleted ? 'تکمیل شده' : 'تکمیل نشده';
  }
}
