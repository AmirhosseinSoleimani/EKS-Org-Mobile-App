
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/area_base_entity.dart';

class AreaBaseModel extends AreaBaseEntity {
  AreaBaseModel({
    required super.id,
    required super.title,
    required super.provinceId,
    required super.cityId,
    required super.provinceTitle,
    required super.cityTitle,
    required super.innerColorOnMap,
    required super.borderColorOnMap,
    required super.status,
    required super.isActive,
    required List<ZoneInfoModel> super.zoneInfoList,
  });

  factory AreaBaseModel.fromJson(Map<String, dynamic> json) {
    return AreaBaseModel(
      id: json["id"],
      title: json["title"] ?? "",
      provinceId: json["provinceId"] ?? 0,
      cityId: json["cityId"] ?? 0,
      provinceTitle: json["provinceTitle"] ?? "",
      cityTitle: json["cityTitle"] ?? "",
      innerColorOnMap: json["innerColorOnMap"] ?? "",
      borderColorOnMap: json["borderColorOnMap"] ?? "",
      status: json["status"] ?? 0,
      isActive: json["isActive"] ?? false,
      zoneInfoList: (json["zoneInfoList"] as List)
          .map((v) => ZoneInfoModel.fromJson(v))
          .toList(),
    );
  }
}

class ZoneInfoModel extends ZoneInfoEntity {
  ZoneInfoModel({
    required super.id,
    required super.areaBaseInfoId,
    required super.title,
    required super.isActive,
    required List<GeoLocationModel> super.geoLocations,
    required List<PointModel> super.points,
  });

  factory ZoneInfoModel.fromJson(Map<String, dynamic> json) {
    return ZoneInfoModel(
      id: json["id"],
      areaBaseInfoId: json["areaBaseInfoId"],
      title: json["title"] ?? "",
      isActive: json["isActive"] ?? false,
      geoLocations: (json["geoLocations"] as List)
          .map((e) => GeoLocationModel.fromJson(e))
          .toList(),
      points: (json["points"] as List)
          .map((e) => PointModel.fromJson(e))
          .toList(),
    );
  }
}

class GeoLocationModel extends GeoLocationEntity {
  GeoLocationModel({
    required super.latitude,
    required super.longitude,
  });

  factory GeoLocationModel.fromJson(Map<String, dynamic> json) {
    return GeoLocationModel(
      latitude: (json["latitude"] as num).toDouble(),
      longitude: (json["longitude"] as num).toDouble(),
    );
  }
}

class PointModel extends PointEntity {
  PointModel({
    required super.item1,
    required super.item2,
  });

  factory PointModel.fromJson(Map<String, dynamic> json) {
    return PointModel(
      item1: (json["item1"] as num).toDouble(),
      item2: (json["item2"] as num).toDouble(),
    );
  }
}
