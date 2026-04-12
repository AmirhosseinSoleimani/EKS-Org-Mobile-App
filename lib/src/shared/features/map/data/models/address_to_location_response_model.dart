import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/address_to_location_response_entity.dart';

class AddressToLocationResponseModel extends AddressToLocationResponseEntity {
  const AddressToLocationResponseModel({
    super.results,
    super.searchType,
    super.consumer,
    super.status,
  });

  factory AddressToLocationResponseModel.fromJson(Map<String, dynamic> json) {
    return AddressToLocationResponseModel(
      results: (json['results'] as List<dynamic>?)?.map((e) => ResultsModel.fromJson(e as Map<String, dynamic>)).toList(),
      searchType: json['search_type'],
      consumer: json['consumer'],
      status: json['status'],
    );
  }
}

class ResultsModel extends ResultEntity {
  const ResultsModel({
    super.geoLocation,
    super.description,
  });

  factory ResultsModel.fromJson(Map<String, dynamic> json) {
    return ResultsModel(
      geoLocation: json['geo_location'] != null ? GeoLocationModel.fromJson(json['geo_location']) : null,
      description: json['description'],
    );
  }
}

class GeoLocationModel extends GeoLocationEntity {
  const GeoLocationModel({
    super.southWest,
    super.northEast,
    super.center,
    super.title,
    super.category,
  });

  factory GeoLocationModel.fromJson(Map<String, dynamic> json) {
    return GeoLocationModel(
      southWest: json['south_west'] != null
          ? GeographicalLocationModel.fromJson(json['south_west'])
          : null,
      northEast: json['north_east'] != null
          ? GeographicalLocationModel.fromJson(json['north_east'])
          : null,
      center: json['center'] != null
          ? GeographicalLocationModel.fromJson(json['center'])
          : null,
      title: json['title'],
      category: json['category'],
    );
  }
}



class GeographicalLocationModel extends GeographicalLocationEntity {
  const GeographicalLocationModel({
    super.latitude,
    super.longitude,
  });

  factory GeographicalLocationModel.fromJson(Map<String, dynamic> json) {
    return GeographicalLocationModel(
      latitude: json['lat'],
      longitude: json['lng'],
    );
  }
}
