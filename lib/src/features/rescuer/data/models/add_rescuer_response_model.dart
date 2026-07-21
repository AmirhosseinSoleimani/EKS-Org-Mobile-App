import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/add_rescuer_response_entity.dart';
class AddRescuerResponseModel extends AddRescuerResponseEntity {
  const AddRescuerResponseModel({required super.id});
  factory AddRescuerResponseModel.fromJson(dynamic json) => AddRescuerResponseModel(id: json?.toString() ?? '');
}
