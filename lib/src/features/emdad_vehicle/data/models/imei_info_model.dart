import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/imei_info_entity.dart';

class ImeiInfoModel extends ImeiInfoEntity {
  const ImeiInfoModel({
    super.id,
    super.title,
  });

  factory ImeiInfoModel.fromJson(Map<String, dynamic> json) {
    return ImeiInfoModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
    );
  }

  static List<ImeiInfoModel> fromJsonList(List<dynamic> json) {
    return json
        .map(
          (item) => ImeiInfoModel.fromJson(
            Map<String, dynamic>.from(item as Map),
          ),
        )
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}
