import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/distance_to_customer_response_model.dart';

class DistanceToCustomerResponseEntity {
  String? startTime;
  String? startTimeDate;
  String? startTimeFollowUpName;
  String? arrivedTime;
  String? arrivedTimeDate;
  String? arrivedTimeFollowUpName;
  String? endTime;
  String? endTimeDate;
  String? endTimeFollowUpName;
  double? drivenDistance;
  double? hamlDistance;
  bool? isArrivedDateEditable;
  bool? isKilometerEditable;
  bool? isHamlKilometerEditable;
  bool? isEtmamWorkDateEditable;

  DistanceToCustomerResponseEntity({
    this.startTime,
    this.startTimeDate,
    this.startTimeFollowUpName,
    this.arrivedTime,
    this.arrivedTimeDate,
    this.arrivedTimeFollowUpName,
    this.endTime,
    this.endTimeDate,
    this.endTimeFollowUpName,
    this.drivenDistance,
    this.hamlDistance,
    this.isArrivedDateEditable,
    this.isEtmamWorkDateEditable,
    this.isHamlKilometerEditable,
    this.isKilometerEditable,
  });

  DistanceToCustomerResponseModel toModel() {
    return DistanceToCustomerResponseModel(
      startTime: startTime,
      startTimeDate: startTimeDate,
      startTimeFollowUpName: startTimeFollowUpName,
      arrivedTime: arrivedTime,
      arrivedTimeDate: arrivedTimeDate,
      arrivedTimeFollowUpName: arrivedTimeFollowUpName,
      endTime: endTime,
      endTimeDate: endTimeDate,
      endTimeFollowUpName: endTimeFollowUpName,
      drivenDistance: drivenDistance,
      hamlDistance: hamlDistance,
      isArrivedDateEditable: isArrivedDateEditable,
      isEtmamWorkDateEditable: isEtmamWorkDateEditable,
      isHamlKilometerEditable: isHamlKilometerEditable,
      isKilometerEditable: isKilometerEditable,
    );
  }
}
