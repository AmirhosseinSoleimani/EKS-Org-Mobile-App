import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/representation_entity.dart';

class RepresentationModel extends RepresentationEntity {
  RepresentationModel({
    super.id,
    super.cityId,
    super.systemCode,
    super.boardCode,
    super.name,
    super.nameWithBoardCode,
    super.address,
    super.isDeleted,
    super.isActive,
    super.latitude,
    super.longitude,
  });

  factory RepresentationModel.fromJson(Map<String, dynamic> json) {
    return RepresentationModel(
      id: json['id'] as int?,
      cityId: json['cityId'] as int?,
      systemCode: json['systemCode'] as String?,
      boardCode: json['boardCode'] as String?,
      name: json['name'] as String?,
      nameWithBoardCode: json['nameWithBoardCode'] as String?,
      address: json['address'] as String?,
      isDeleted: json['isDeleted'] as bool?,
      isActive: json['isActive'] as bool?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cityId': cityId,
      'systemCode': systemCode,
      'boardCode': boardCode,
      'name': name,
      'nameWithBoardCode': nameWithBoardCode,
      'address': address,
      'isDeleted': isDeleted,
      'isActive': isActive,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
