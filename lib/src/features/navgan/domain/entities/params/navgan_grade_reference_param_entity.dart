import 'package:eks_sana_plus_org/src/features/navgan/data/models/params/navgan_grade_reference_request_model.dart';

class NavganGradeReferenceParamEntity {
  const NavganGradeReferenceParamEntity({
    required this.gradePatternId,
    required this.serviceTypeId,
    required this.refType,
    required this.refId,
    this.isActive = true,
  });

  final int gradePatternId;
  final int serviceTypeId;
  final int refType;
  final int refId;
  final bool isActive;

  NavganGradeReferenceRequestModel toModel() {
    return NavganGradeReferenceRequestModel(
      gradePatternId: gradePatternId,
      serviceTypeId: serviceTypeId,
      refType: refType,
      refId: refId,
      isActive: isActive,
    );
  }
}
