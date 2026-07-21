import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_vehicle_grade_detail_model.dart';

class AgencyVehicleGradeDetailEntity {
  const AgencyVehicleGradeDetailEntity({
    this.gradeId,
    this.gradeCode,
    this.gradeTitle,
    this.gradeCoefficient,
    this.managementCommissionPercent,
  });

  final int? gradeId;
  final String? gradeCode;
  final String? gradeTitle;
  final double? gradeCoefficient;
  final int? managementCommissionPercent;

  AgencyVehicleGradeDetailModel toModel() {
    return AgencyVehicleGradeDetailModel(
      gradeId: gradeId,
      gradeCode: gradeCode,
      gradeTitle: gradeTitle,
      gradeCoefficient: gradeCoefficient,
      managementCommissionPercent: managementCommissionPercent,
    );
  }

  AgencyVehicleGradeDetailEntity copyWith({
    int? gradeId,
    String? gradeCode,
    String? gradeTitle,
    double? gradeCoefficient,
    int? managementCommissionPercent,
  }) {
    return AgencyVehicleGradeDetailEntity(
      gradeId: gradeId ?? this.gradeId,
      gradeCode: gradeCode ?? this.gradeCode,
      gradeTitle: gradeTitle ?? this.gradeTitle,
      gradeCoefficient: gradeCoefficient ?? this.gradeCoefficient,
      managementCommissionPercent: managementCommissionPercent ?? this.managementCommissionPercent,
    );
  }
}
