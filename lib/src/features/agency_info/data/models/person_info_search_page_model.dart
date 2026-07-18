import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/person_info_search_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/person_info_search_page_entity.dart';

class PersonInfoSearchPageModel extends PersonInfoSearchPageEntity {
  const PersonInfoSearchPageModel({
    super.records,
    super.count,
  });

  factory PersonInfoSearchPageModel.fromJson(Map<String, dynamic> json) {
    return PersonInfoSearchPageModel(
      records: AgencyInfoJsonHelper.pageRecords(json)
          .map(PersonInfoSearchModel.fromJson)
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
