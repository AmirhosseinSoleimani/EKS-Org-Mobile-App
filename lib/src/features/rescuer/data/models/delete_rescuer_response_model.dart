import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/delete_rescuer_response_entity.dart';

class DeleteRescuerResponseModel extends DeleteRescuerResponseEntity {
  const DeleteRescuerResponseModel({super.id});

  factory DeleteRescuerResponseModel.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return DeleteRescuerResponseModel(id: json['id']?.toString());
    }
    return DeleteRescuerResponseModel(id: json?.toString());
  }
}
