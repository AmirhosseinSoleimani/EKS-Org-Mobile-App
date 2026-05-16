import 'package:eks_sana_plus_org/src/features/services/domain/entities/check_depot_entity.dart';

class CheckDepotModel extends CheckDepotEntity {
  CheckDepotModel({
    super.launchDepotIsEnable,
    super.emdadgarDepotStatus,
    super.isIncompletePartInDepot,
    super.listOfIncompletePartsSerial,
    super.allowMark500,
  });

  factory CheckDepotModel.fromJson(Map<String, dynamic> json) {
    return CheckDepotModel(
      launchDepotIsEnable: json["launchDepotIsEnable"],
      emdadgarDepotStatus: json["emdadgarDepotStatus"],
      isIncompletePartInDepot: json["isIncompletePartInDepot"],
      listOfIncompletePartsSerial: json["listOfIncompletePartsSerial"],
      allowMark500: json["allowMark500"],
    );
  }
}
