import 'package:eks_sana_plus_org/src/shared/features/user/data/models/package_model.dart';

class PackageEntity {
  const PackageEntity({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  PackageModel toModel() {
    return PackageModel(id: id, name: name);
  }
}
