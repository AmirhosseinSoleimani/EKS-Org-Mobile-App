import 'package:eks_sana_plus_org/src/features/evaluation/data/models/home_service_package_part_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_package_part_group_entity.dart';

class ServicePackagePartGroupModel extends ServicePackagePartGroupEntity {
  const ServicePackagePartGroupModel({
    super.laborId,
    super.partGroupId,
    super.partGroupTitle,
    super.parts,
  });

  factory ServicePackagePartGroupModel.fromJson(Map<String, dynamic> json) {
    return ServicePackagePartGroupModel(
      laborId: json['laborId'],
      partGroupId: json['partGroupId'],
      partGroupTitle: json['partGroupTitle'],
      parts: json['parts'] == null
          ? null
          : (json['parts'] as List)
                .map((e) => HomeServicePackagePartModel.fromJson(e))
                .toList(),
    );
  }
}
