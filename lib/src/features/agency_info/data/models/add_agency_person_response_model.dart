import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/add_agency_person_entity.dart';

class AddAgencyPersonResponseModel extends AddAgencyPersonEntity {
  const AddAgencyPersonResponseModel({required super.id});

  factory AddAgencyPersonResponseModel.fromResponse(dynamic data) {
    if (data is Map) {
      final json = Map<String, dynamic>.from(data);
      return AddAgencyPersonResponseModel(
        id: (json['data'] ?? json['Data'])?.toString() ?? '',
      );
    }

    return AddAgencyPersonResponseModel(id: data?.toString() ?? '');
  }
}
