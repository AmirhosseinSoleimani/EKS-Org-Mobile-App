import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_entity.dart';

class ProvinceModel extends ProvinceEntity {
  const ProvinceModel({
    super.provinceId,
    super.provinceCode,
    super.cityId,
    super.cityCode,
    super.title,
    super.cityName,
    super.latitude,
    super.longitude,
  });

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
      provinceId: json['provinceId'] as int?,
      provinceCode: json['provinceCode'] as int?,
      cityId: json['cityId'] as int?,
      cityCode: json['cityCode'] as int?,
      title: json['title']?.toString(),
      cityName: json['cityName']?.toString(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'provinceId': provinceId,
      'provinceCode': provinceCode,
      'cityId': cityId,
      'cityCode': cityCode,
      'title': title,
      'cityName': cityName,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
