import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/plan_id_person_entity.dart';

class PlanAidPersonModel extends PlanAidPersonEntity {
  PlanAidPersonModel({
    super.planId,
    super.agencyInfoId,
    super.personInfoId,
    super.code,
    super.mobile,
    super.firstName,
    super.lastName,
    super.fullName,
    super.isEmdadService,
    super.isHomeService,
    super.nationalCode,
  });

  factory PlanAidPersonModel.fromJson(Map<String, dynamic> json) {
    return PlanAidPersonModel(
      planId: json["planId"],
      agencyInfoId: json["agencyInfoId"],
      personInfoId: json["personInfoId"],
      code: json["code"],
      mobile: json["mobile"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      fullName: json["fullName"],
      nationalCode: json["nationalCode"],
      isEmdadService: json["isEmdadService"],
      isHomeService: json["isHomeService"],
    );
  }
}
