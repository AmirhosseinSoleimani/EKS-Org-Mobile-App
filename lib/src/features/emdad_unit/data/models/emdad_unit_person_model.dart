import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_person_entity.dart';

class EmdadUnitPersonModel extends EmdadUnitPersonEntity {
  const EmdadUnitPersonModel({
    super.id,
    super.emdadUnitId,
    super.emdadUnitTitle,
    super.agencyInfoId,
    super.agencyInfoTitle,
    super.agencyPersonId,
    super.personInfoId,
    super.code,
    super.mobile,
    super.firstName,
    super.lastName,
    super.nationalNumber,
    super.isActive,
  });

  factory EmdadUnitPersonModel.fromJson(Map<String, dynamic> json) {
    return EmdadUnitPersonModel(
      id: json['id'] as int?,
      emdadUnitId: json['emdadUnitId'] as int?,
      emdadUnitTitle: json['emdadUnitTitle'] as String?,
      agencyInfoId: json['agencyInfoId'] as int?,
      agencyInfoTitle: json['agencyInfoTitle'] as String?,
      agencyPersonId: json['agencyPersonId'] as int?,
      personInfoId: json['personInfoId'] as int?,
      code: json['code'] as String?,
      mobile: json['mobile'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      nationalNumber: json['nationalNumber'] as String?,
      isActive: json['isActive'] as bool?,
    );
  }
}
