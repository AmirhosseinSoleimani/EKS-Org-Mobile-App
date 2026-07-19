import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_vehicle_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_vehicle_page_entity.dart';

class AgencyVehiclePageModel extends AgencyVehiclePageEntity {
  const AgencyVehiclePageModel({
    super.records,
    super.count,
  });

  factory AgencyVehiclePageModel.fromJson(Map<String, dynamic> json) {
    return AgencyVehiclePageModel(
      records: AgencyInfoJsonHelper.pageRecords(json)
          .map(AgencyVehicleModel.fromJson)
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
