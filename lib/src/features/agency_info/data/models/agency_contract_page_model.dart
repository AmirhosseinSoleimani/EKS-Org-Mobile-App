import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_contract_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_contract_page_entity.dart';

class AgencyContractPageModel extends AgencyContractPageEntity {
  const AgencyContractPageModel({
    super.records,
    super.count,
  });

  factory AgencyContractPageModel.fromJson(Map<String, dynamic> json) {
    return AgencyContractPageModel(
      records: AgencyInfoJsonHelper.pageRecords(json)
          .map(AgencyContractModel.fromJson)
          .toList(),
      count: AgencyInfoJsonHelper.pageCount(json),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'records': records?.map((item) => item.toModel().toJson()).toList(),
      'count': count,
    };
  }
}
