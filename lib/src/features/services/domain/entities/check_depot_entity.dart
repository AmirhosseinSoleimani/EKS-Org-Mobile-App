import 'package:eks_sana_plus_org/src/features/services/data/models/check_depot_model.dart';

class CheckDepotEntity {
  bool? launchDepotIsEnable;
  bool? emdadgarDepotStatus;
  bool? isIncompletePartInDepot;
  List<dynamic>? listOfIncompletePartsSerial;
  bool? allowMark500;

  CheckDepotEntity({
    this.launchDepotIsEnable,
    this.emdadgarDepotStatus,
    this.isIncompletePartInDepot,
    this.listOfIncompletePartsSerial,
    this.allowMark500,
  });

  CheckDepotEntity copyWith({
    bool? launchDepotIsEnable,
    bool? emdadgarDepotStatus,
    bool? isIncompletePartInDepot,
    List<dynamic>? listOfIncompletePartsSerial,
    bool? allowMark500,
  }) {
    return CheckDepotEntity(
      launchDepotIsEnable: launchDepotIsEnable ?? this.launchDepotIsEnable,
      emdadgarDepotStatus: emdadgarDepotStatus ?? this.emdadgarDepotStatus,
      isIncompletePartInDepot:
      isIncompletePartInDepot ?? this.isIncompletePartInDepot,
      listOfIncompletePartsSerial:
      listOfIncompletePartsSerial ?? this.listOfIncompletePartsSerial,
      allowMark500: allowMark500 ?? this.allowMark500,
    );
  }

  CheckDepotModel toModel() {
    return CheckDepotModel(
      launchDepotIsEnable: launchDepotIsEnable,
      emdadgarDepotStatus: emdadgarDepotStatus,
      isIncompletePartInDepot: isIncompletePartInDepot,
      listOfIncompletePartsSerial: listOfIncompletePartsSerial,
      allowMark500: allowMark500,
    );
  }
}

