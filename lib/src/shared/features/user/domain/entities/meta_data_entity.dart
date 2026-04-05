import 'package:eks_sana_plus_org/src/shared/features/user/data/models/meta_data_model.dart';

class MetaDataEntity {
  final String? androidAppVersion;
  final String? androidAppLink;

  const MetaDataEntity({this.androidAppVersion, this.androidAppLink});

  MetaDataModel toModel() {
    return MetaDataModel(
        androidAppVersion: androidAppVersion, androidAppLink: androidAppLink);
  }
}
