import 'package:eks_sana_plus_org/src/shared/features/map/data/models/province_model.dart';

class ProvinceEntity {
  final int? provinceId;
  final int? provinceCode;
  final int? cityId;
  final int? cityCode;
  final String? title;
  final String? cityName;
  final double? latitude;
  final double? longitude;

  const ProvinceEntity({
    this.provinceId,
    this.provinceCode,
    this.cityId,
    this.cityCode,
    this.title,
    this.cityName,
    this.latitude,
    this.longitude,
  });

  ProvinceEntity copyWith({
    int? provinceId,
    int? provinceCode,
    int? cityId,
    int? cityCode,
    String? title,
    String? cityName,
    double? latitude,
    double? longitude,
  }) {
    return ProvinceEntity(
      provinceId: provinceId ?? this.provinceId,
      provinceCode: provinceCode ?? this.provinceCode,
      cityId: cityId ?? this.cityId,
      cityCode: cityCode ?? this.cityCode,
      title: title ?? this.title,
      cityName: cityName ?? this.cityName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  ProvinceModel toModel() => ProvinceModel(
    provinceId: provinceId,
    provinceCode: provinceCode,
    cityId: cityId,
    cityCode: cityCode,
    title: title,
    cityName: cityName,
    latitude: latitude,
    longitude: longitude,
  );
}
