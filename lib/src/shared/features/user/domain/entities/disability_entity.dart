import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/enums/disability.dart';

class DisabilityEntity {
  final String? description;
  final Disability disability;

  DisabilityEntity({
    this.description,
    required this.disability,
  });
}
