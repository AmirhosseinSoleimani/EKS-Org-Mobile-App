import 'package:eks_sana_plus_org/src/features/navgan/data/models/navgan_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_entity.dart';

class NavganModel extends NavganEntity {
  const NavganModel({
    super.id,
    super.emdadgarNavganType,
    super.title,
    super.code,
    super.insertUserFullName,
    super.updateUserFullName,
    super.insertDateTime,
    super.insertDateTimeJalali,
    super.updateDateTime,
    super.updateDateTimeJalali,
    super.isActive,
  });

  factory NavganModel.fromJson(Map<String, dynamic> json) {
    return NavganModel(
      id: NavganJsonHelper.integer(json['id'] ?? json['Id']),
      emdadgarNavganType: NavganJsonHelper.integer(
        json['emdadgarNavganType'] ?? json['EmdadgarNavganType'],
      ),
      title: NavganJsonHelper.string(json['title'] ?? json['Title']),
      code: NavganJsonHelper.string(json['code'] ?? json['Code']),
      insertUserFullName: NavganJsonHelper.string(
        json['insertUserFullName'] ?? json['InsertUserFullName'],
      ),
      updateUserFullName: NavganJsonHelper.string(
        json['updateUserFullName'] ?? json['UpdateUserFullName'],
      ),
      insertDateTime: NavganJsonHelper.string(
        json['insertDateTime'] ?? json['InsertDateTime'],
      ),
      insertDateTimeJalali: NavganJsonHelper.string(
        json['insertDateTimeJalali'] ?? json['InsertDateTimeJalali'],
      ),
      updateDateTime: NavganJsonHelper.string(
        json['updateDateTime'] ?? json['UpdateDateTime'],
      ),
      updateDateTimeJalali: NavganJsonHelper.string(
        json['updateDateTimeJalali'] ?? json['UpdateDateTimeJalali'],
      ),
      isActive: NavganJsonHelper.boolean(json['isActive'] ?? json['IsActive']),
    );
  }
}
