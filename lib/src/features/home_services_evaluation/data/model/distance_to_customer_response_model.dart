
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/distance_to_customer_response_entity.dart';

class DistanceToCustomerResponseModel extends DistanceToCustomerResponseEntity {
  DistanceToCustomerResponseModel({
    String? startTime,
    String? startTimeDate,
    String? startTimeFollowUpName,
    String? arrivedTime,
    String? arrivedTimeDate,
    String? arrivedTimeFollowUpName,
    String? endTime,
    String? endTimeDate,
    String? endTimeFollowUpName,
    double? drivenDistance,
    double? hamlDistance,
    super.isArrivedDateEditable,
    super.isEtmamWorkDateEditable,
    super.isHamlKilometerEditable,
    super.isKilometerEditable
  }) :super(
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
      hamlDistance: hamlDistance
  );

  DistanceToCustomerResponseModel.fromJson(dynamic json) {
    startTime = json['startTime'];
    startTimeDate = json['startTimeDate'];
    startTimeFollowUpName = json['startTimeFollowUpName'];
    arrivedTime = json['arrivedTime'];
    arrivedTimeDate = json['arrivedTimeDate'];
    arrivedTimeFollowUpName = json['arrivedTimeFollowUpName'];
    endTime = json['endTime'];
    endTimeDate = json['endTimeDate'];
    endTimeFollowUpName = json['endTimeFollowUpName'];
    drivenDistance = json['drivenDistance'];
    hamlDistance = json['hamlDistance'];
    isArrivedDateEditable = json['IsArrivedDateEditable'];
    isKilometerEditable = json['IsKilometerEditable'];
    isHamlKilometerEditable = json['IsHamlKilometerEditable'];
    isEtmamWorkDateEditable = json['IsEtmamWorkDateEditable'];

  }
}