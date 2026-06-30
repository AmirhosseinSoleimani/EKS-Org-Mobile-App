import 'package:eks_sana_plus_org/src/features/services/data/models/update_service_response_model.dart';

class UpdateServiceResponseEntity {
  final int? updatedRecordId;

  const UpdateServiceResponseEntity({this.updatedRecordId});

  UpdateServiceResponseEntity copyWith({int? updatedRecordId}) {
    return UpdateServiceResponseEntity(
      updatedRecordId: updatedRecordId ?? this.updatedRecordId,
    );
  }

  UpdateServiceResponseModel toModel() =>
      UpdateServiceResponseModel(updatedRecordId: updatedRecordId);
}
