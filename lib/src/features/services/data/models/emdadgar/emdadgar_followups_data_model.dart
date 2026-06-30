import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_followups_data_entity.dart';

class EmdadgarFollowupsDataModel
    extends EmdadgarFollowupsDataEntity {
  const EmdadgarFollowupsDataModel({
    super.startTime,
    super.startTimeDate,
    super.startTimeFollowUpName,
    super.arrivedTime,
    super.arrivedTimeDate,
    super.arrivedTimeFollowUpName,
    super.endTime,
    super.endTimeDate,
    super.endTimeFollowUpName,
    super.isArrivedDateEditable,
    super.isKilometerEditable,
    super.isHamlKilometerEditable,
    super.isEtmamWorkDateEditable,
  });

  factory EmdadgarFollowupsDataModel.fromEntity(
      EmdadgarFollowupsDataEntity entity) {
    return EmdadgarFollowupsDataModel(
      startTime: entity.startTime,
      startTimeDate: entity.startTimeDate,
      startTimeFollowUpName: entity.startTimeFollowUpName,
      arrivedTime: entity.arrivedTime,
      arrivedTimeDate: entity.arrivedTimeDate,
      arrivedTimeFollowUpName: entity.arrivedTimeFollowUpName,
      endTime: entity.endTime,
      endTimeDate: entity.endTimeDate,
      endTimeFollowUpName: entity.endTimeFollowUpName,
      isArrivedDateEditable: entity.isArrivedDateEditable,
      isKilometerEditable: entity.isKilometerEditable,
      isHamlKilometerEditable: entity.isHamlKilometerEditable,
      isEtmamWorkDateEditable: entity.isEtmamWorkDateEditable,
    );
  }

  factory EmdadgarFollowupsDataModel.fromJson(
      Map<String, dynamic> json) {
    return EmdadgarFollowupsDataModel(
      startTime: json["startTime"],
      startTimeDate: json["startTimeDate"] != null
          ? DateTime.parse(json["startTimeDate"])
          : null,
      startTimeFollowUpName: json["startTimeFollowUpName"],
      arrivedTime: json["arrivedTime"],
      arrivedTimeDate: json["arrivedTimeDate"] != null
          ? DateTime.parse(json["arrivedTimeDate"])
          : null,
      arrivedTimeFollowUpName: json["arrivedTimeFollowUpName"],
      endTime: json["endTime"],
      endTimeDate: json["endTimeDate"] != null
          ? DateTime.parse(json["endTimeDate"])
          : null,
      endTimeFollowUpName: json["endTimeFollowUpName"],
      isArrivedDateEditable: json["isArrivedDateEditable"],
      isKilometerEditable: json["isKilometerEditable"],
      isHamlKilometerEditable: json["isHamlKilometerEditable"],
      isEtmamWorkDateEditable:
      json["isEtmamWorkDateEditable"],
    );
  }
}
