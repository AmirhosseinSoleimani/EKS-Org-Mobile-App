import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/params/area_base_info_param_entity.dart';

class AreaBaseInfoParamModel extends AreaBaseInfoParamEntity {
  AreaBaseInfoParamModel({
    super.latitude,
    super.longitude,
    super.areaBusinessUsageTypes,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{"latitude": latitude, "longitude": longitude};

    if (areaBusinessUsageTypes != null) {
      for (int i = 0; i < areaBusinessUsageTypes!.length; i++) {
        map["areaBusinessUsageTypes[$i]"] = areaBusinessUsageTypes![i];
      }
    }

    return map;
  }
}
