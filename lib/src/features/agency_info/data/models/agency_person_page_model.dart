import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_person_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_person_page_entity.dart';

class AgencyPersonPageModel extends AgencyPersonPageEntity {
  const AgencyPersonPageModel({
    super.records,
    super.count,
  });

  factory AgencyPersonPageModel.fromJson(Map<String, dynamic> json) {
    return AgencyPersonPageModel(
      records: AgencyInfoJsonHelper.pageRecords(json)
          .map(AgencyPersonModel.fromJson)
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
