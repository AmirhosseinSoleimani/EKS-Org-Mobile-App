import 'package:eks_sana_plus_org/src/features/services/data/models/emdadgar/plan_id_person_model.dart';

class PlanAidPersonEntity {
  int? planId;
  int? agencyInfoId;
  int? personInfoId;
  String? code;
  String? mobile;
  String? firstName;
  String? lastName;
  String? fullName;
  bool? isHomeService;
  bool? isEmdadService;
  String? nationalCode;

  PlanAidPersonEntity({
    this.planId,
    this.agencyInfoId,
    this.personInfoId,
    this.code,
    this.mobile,
    this.firstName,
    this.lastName,
    this.fullName,
    this.isHomeService,
    this.isEmdadService,
    this.nationalCode,
  });

  PlanAidPersonModel toModel() {
    return PlanAidPersonModel(
      planId: planId,
      agencyInfoId: agencyInfoId,
      personInfoId: personInfoId,
      code: code,
      mobile: mobile,
      firstName: firstName,
      lastName: lastName,
      fullName: fullName,
      nationalCode: nationalCode,
      isEmdadService: isEmdadService,
      isHomeService: isHomeService,
    );
  }
}

