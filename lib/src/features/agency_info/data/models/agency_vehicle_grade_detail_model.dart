import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_vehicle_grade_detail_entity.dart';

class AgencyVehicleGradeDetailModel extends AgencyVehicleGradeDetailEntity {
  const AgencyVehicleGradeDetailModel({
    super.gradeId,
    super.gradeCode,
    super.gradeTitle,
    super.gradeCoefficient,
    super.managementCommissionPercent,
  });

  factory AgencyVehicleGradeDetailModel.fromJson(Map<String, dynamic> json) {
    return AgencyVehicleGradeDetailModel(
      gradeId: AgencyInfoJsonHelper.integer(json['gradeId']),
      gradeCode: AgencyInfoJsonHelper.string(json['gradeCode']),
      gradeTitle: AgencyInfoJsonHelper.string(json['gradeTitle']),
      gradeCoefficient: AgencyInfoJsonHelper.decimal(json['gradeCoefficient']),
      managementCommissionPercent: AgencyInfoJsonHelper.integer(json['managmentCommisionPercent']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gradeId': gradeId,
      'gradeCode': gradeCode,
      'gradeTitle': gradeTitle,
      'gradeCoefficient': gradeCoefficient,
      'managmentCommisionPercent': managementCommissionPercent,
    };
  }
}
