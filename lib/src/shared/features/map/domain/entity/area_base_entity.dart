import 'package:eks_sana_plus_org/src/shared/features/map/data/models/area_base_model.dart';

class AreaBaseEntity {
  final int id;
  final String title;
  final int provinceId;
  final int cityId;
  final String provinceTitle;
  final String cityTitle;
  final String innerColorOnMap;
  final String borderColorOnMap;
  final int status;
  final bool isActive;
  final List<ZoneInfoEntity> zoneInfoList;

  AreaBaseEntity({
    required this.id,
    required this.title,
    required this.provinceId,
    required this.cityId,
    required this.provinceTitle,
    required this.cityTitle,
    required this.innerColorOnMap,
    required this.borderColorOnMap,
    required this.status,
    required this.isActive,
    required this.zoneInfoList,
  });

  AreaBaseEntity copyWith({
    int? id,
    String? title,
    int? provinceId,
    int? cityId,
    String? provinceTitle,
    String? cityTitle,
    String? innerColorOnMap,
    String? borderColorOnMap,
    int? status,
    bool? isActive,
    List<ZoneInfoEntity>? zoneInfoList,
  }) {
    return AreaBaseEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      provinceId: provinceId ?? this.provinceId,
      cityId: cityId ?? this.cityId,
      provinceTitle: provinceTitle ?? this.provinceTitle,
      cityTitle: cityTitle ?? this.cityTitle,
      innerColorOnMap: innerColorOnMap ?? this.innerColorOnMap,
      borderColorOnMap: borderColorOnMap ?? this.borderColorOnMap,
      status: status ?? this.status,
      isActive: isActive ?? this.isActive,
      zoneInfoList: zoneInfoList ?? this.zoneInfoList,
    );
  }

  AreaBaseModel toModel() {
    return AreaBaseModel(
      id: id,
      title: title,
      provinceId: provinceId,
      cityId: cityId,
      provinceTitle: provinceTitle,
      cityTitle: cityTitle,
      innerColorOnMap: innerColorOnMap,
      borderColorOnMap: borderColorOnMap,
      status: status,
      isActive: isActive,
      zoneInfoList: zoneInfoList.map((e) => e.toModel()).toList(),
    );
  }
}

class ZoneInfoEntity {
  final int id;
  final int areaBaseInfoId;
  final String title;
  final bool isActive;
  final List<GeoLocationEntity> geoLocations;
  final List<PointEntity> points;

  ZoneInfoEntity({
    required this.id,
    required this.areaBaseInfoId,
    required this.title,
    required this.isActive,
    required this.geoLocations,
    required this.points,
  });

  ZoneInfoEntity copyWith({
    int? id,
    int? areaBaseInfoId,
    String? title,
    bool? isActive,
    List<GeoLocationEntity>? geoLocations,
    List<PointEntity>? points,
  }) {
    return ZoneInfoEntity(
      id: id ?? this.id,
      areaBaseInfoId: areaBaseInfoId ?? this.areaBaseInfoId,
      title: title ?? this.title,
      isActive: isActive ?? this.isActive,
      geoLocations: geoLocations ?? this.geoLocations,
      points: points ?? this.points,
    );
  }

  ZoneInfoModel toModel() {
    return ZoneInfoModel(
      id: id,
      areaBaseInfoId: areaBaseInfoId,
      title: title,
      isActive: isActive,
      geoLocations: geoLocations.map((e) => e.toModel()).toList(),
      points: points.map((e) => e.toModel()).toList(),
    );
  }
}

class GeoLocationEntity {
  final double latitude;
  final double longitude;

  GeoLocationEntity({
    required this.latitude,
    required this.longitude,
  });

  GeoLocationEntity copyWith({
    double? latitude,
    double? longitude,
  }) {
    return GeoLocationEntity(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  GeoLocationModel toModel() {
    return GeoLocationModel(
      latitude: latitude,
      longitude: longitude,
    );
  }
}

class PointEntity {
  final double item1;
  final double item2;

  PointEntity({
    required this.item1,
    required this.item2,
  });

  PointEntity copyWith({
    double? item1,
    double? item2,
  }) {
    return PointEntity(
      item1: item1 ?? this.item1,
      item2: item2 ?? this.item2,
    );
  }

  PointModel toModel() {
    return PointModel(
      item1: item1,
      item2: item2,
    );
  }
}
