import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/package_entity.dart';

class PackageModel extends PackageEntity {
  const PackageModel({
    super.id,
    super.name,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
