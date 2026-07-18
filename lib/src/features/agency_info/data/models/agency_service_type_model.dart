import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_service_type_entity.dart';

class AgencyServiceTypeModel extends AgencyServiceTypeEntity {
  const AgencyServiceTypeModel({
    super.id,
    super.code,
    super.name,
    super.selectable,
  });

  factory AgencyServiceTypeModel.fromJson(Map<String, dynamic> json) {
    return AgencyServiceTypeModel(
      id: AgencyInfoJsonHelper.integer(json['id']),
      code: AgencyInfoJsonHelper.string(json['code']),
      name: AgencyInfoJsonHelper.string(json['name']),
      selectable: AgencyInfoJsonHelper.boolean(json['selectable']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'selectable': selectable,
    };
  }
}
