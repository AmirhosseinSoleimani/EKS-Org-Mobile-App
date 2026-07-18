import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/vehicle_info_search_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/vehicle_info_search_page_entity.dart';

class VehicleInfoSearchPageModel extends VehicleInfoSearchPageEntity {
  const VehicleInfoSearchPageModel({
    super.records,
    super.count,
  });

  factory VehicleInfoSearchPageModel.fromJson(Map<String, dynamic> json) {
    return VehicleInfoSearchPageModel(
      records: AgencyInfoJsonHelper.pageRecords(json)
          .map(VehicleInfoSearchModel.fromJson)
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
