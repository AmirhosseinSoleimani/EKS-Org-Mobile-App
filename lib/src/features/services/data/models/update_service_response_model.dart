import 'package:eks_sana_plus_org/src/features/services/domain/entities/update_service_response_entity.dart';

class UpdateServiceResponseModel extends UpdateServiceResponseEntity {
  const UpdateServiceResponseModel({super.updatedRecordId});

  factory UpdateServiceResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateServiceResponseModel(
      updatedRecordId: int.tryParse(json.toString()),
    );
  }
}
