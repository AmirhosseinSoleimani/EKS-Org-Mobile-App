import '../../domain/entity/map_request_entity.dart';

class MapRequestModel extends MapRequestEntity {
  const MapRequestModel(
      {super.select, super.text, super.lat, super.lon, super.id});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['select'] = select;
    map['lat'] = lat;
    map['lon'] = lon;
    map['text'] = text;
    map['id'] = id;
    return map;
  }
}
