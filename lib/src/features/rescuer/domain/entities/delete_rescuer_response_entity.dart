import 'package:eks_sana_plus_org/src/features/rescuer/data/models/delete_rescuer_response_model.dart';

class DeleteRescuerResponseEntity {
  final String? id;

  const DeleteRescuerResponseEntity({this.id});

  DeleteRescuerResponseModel toModel() {
    return DeleteRescuerResponseModel(id: id);
  }
}
