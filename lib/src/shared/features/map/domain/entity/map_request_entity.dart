import 'package:eks_sana_plus_org/src/shared/features/map/data/models/map_request_model.dart';

class MapRequestEntity {
  final String? select;
  final String? id;
  final String? text;
  final double? lat;
  final double? lon;

  const MapRequestEntity({
    this.select,
    this.lat,
    this.lon,
    this.text,
    this.id
  });

  MapRequestModel toModel() {
    return MapRequestModel(
        text: text,
        lat: lat,
        lon: lon,
        select: select,
        id: id
    );
  }
}