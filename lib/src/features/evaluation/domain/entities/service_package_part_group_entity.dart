
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/service_package_part_group_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/home_service_package_part_entity.dart';

class ServicePackagePartGroupEntity {
  final int? laborId;
  final int? partGroupId;
  final String? partGroupTitle;
  final List<HomeServicePackagePartEntity>? parts;

  const ServicePackagePartGroupEntity({
    this.laborId,
    this.partGroupId,
    this.partGroupTitle,
    this.parts,
  });

  ServicePackagePartGroupModel toModel() {
    return ServicePackagePartGroupModel(
      laborId: laborId,
      partGroupId: partGroupId,
      partGroupTitle: partGroupTitle,
      parts: parts?.map((element) => element.toModel()).toList(),
    );
  }

  ServicePackagePartGroupEntity copyWith({
    int? laborId,
    int? partGroupId,
    String? partGroupTitle,
    List<HomeServicePackagePartEntity>? parts,
  }) {
    return ServicePackagePartGroupEntity(
      laborId: laborId ?? this.laborId,
      partGroupId: partGroupId ?? this.partGroupId,
      partGroupTitle: partGroupTitle ?? this.partGroupTitle,
      parts: parts ?? this.parts,
    );
  }
}