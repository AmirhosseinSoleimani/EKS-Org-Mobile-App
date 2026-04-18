import 'package:eks_sana_plus_org/src/shared/features/map/data/models/address_to_location_response_model.dart';

class AddressToLocationResponseEntity {
  const AddressToLocationResponseEntity({
    this.consumer,
    this.searchType,
    this.status,
    this.results,
  });

  final List<ResultEntity>? results;
  final String? searchType;
  final int? consumer;
  final String? status;

  AddressToLocationResponseModel toModel() {
    return AddressToLocationResponseModel(
      results: results?.map((e) => e.toModel()).toList(),
      searchType: searchType,
      consumer: consumer,
      status: status,
    );
  }
}

class ResultEntity {
  final GeoLocationEntity? geoLocation;
  final String? description;

  const ResultEntity({this.geoLocation, this.description});
  ResultsModel toModel() {
    return ResultsModel(
      geoLocation: geoLocation?.toModel(),
      description: description,
    );
  }
}

class GeoLocationEntity {
  final GeographicalLocationEntity? southWest;
  final GeographicalLocationEntity? northEast;
  final GeographicalLocationEntity? center;
  final String? title;
  final String? category;

  const GeoLocationEntity({this.southWest, this.northEast, this.center, this.title, this.category});
  GeoLocationModel toModel() {
    return GeoLocationModel(
      southWest: southWest?.toModel(),
      northEast: northEast?.toModel(),
      center: center?.toModel(),
      title: title,
      category: category,
    );
  }
}

class GeographicalLocationEntity {
  final double? latitude;
  final double? longitude;

  const GeographicalLocationEntity({this.latitude, this.longitude});
  GeographicalLocationModel toModel() {
    return GeographicalLocationModel(
      latitude: latitude,
      longitude: longitude,
    );
  }
}