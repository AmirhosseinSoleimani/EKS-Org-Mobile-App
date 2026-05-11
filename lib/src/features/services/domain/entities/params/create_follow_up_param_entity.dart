import 'package:eks_sana_plus_org/src/features/services/data/models/params/create_follow_up_param_model.dart';

class CreateFollowUpParamEntity {
  final int? serviceRequestId;
  final int? serviceType;
  final int? resultStatusId;
  final int? sourceType;
  final String? description;
  final String? followUpDateTime;

  const CreateFollowUpParamEntity({
    this.serviceRequestId,
    this.serviceType,
    this.resultStatusId,
    this.sourceType,
    this.description,
    this.followUpDateTime,
  });

  CreateFollowUpParamEntity copyWith({
    int? serviceRequestId,
    int? serviceType,
    int? resultStatusId,
    int? sourceType,
    String? description,
    String? followUpDateTime,
  }) {
    return CreateFollowUpParamEntity(
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      serviceType: serviceType ?? this.serviceType,
      resultStatusId: resultStatusId ?? this.resultStatusId,
      sourceType: sourceType ?? this.sourceType,
      description: description ?? this.description,
      followUpDateTime: followUpDateTime ?? this.followUpDateTime,
    );
  }

  CreateFollowUpParamModel toModel() {
    return CreateFollowUpParamModel(
      serviceRequestId: serviceRequestId,
      serviceType: serviceType,
      resultStatusId: resultStatusId,
      sourceType: sourceType,
      description: description,
      followUpDateTime: followUpDateTime,
    );
  }
}
