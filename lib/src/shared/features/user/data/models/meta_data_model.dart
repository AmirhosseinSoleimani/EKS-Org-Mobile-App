import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/meta_data_entity.dart';

class MetaDataModel extends MetaDataEntity {
  MetaDataModel({
    super.androidAppLink,
    super.androidAppVersion,
  });

  factory MetaDataModel.fromJson(Map<String, dynamic> json) {
    return MetaDataModel(
      androidAppVersion: json['androidAppVersion'],
      androidAppLink: json['androidAppLink'],
    );
  }

  Map<String, dynamic> toJson() => {
        'androidAppVersion': androidAppVersion,
        'androidAppLink': androidAppLink,
      };
}
