import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_service_entity.dart';

class SkillServiceTypeGroup {
  const SkillServiceTypeGroup({
    required this.type,
    required this.title,
    required this.services,
  });

  final int type;
  final String title;
  final List<SkillServiceEntity> services;
}

List<SkillServiceTypeGroup> groupSkillServicesByType(
  List<SkillServiceEntity> services,
) {
  final grouped = <int, List<SkillServiceEntity>>{};

  for (final service in services) {
    grouped.putIfAbsent(service.serviceTypeKey, () => []).add(service);
  }

  final hasKnownServiceType = grouped.containsKey(1) || grouped.containsKey(2);
  if (hasKnownServiceType) {
    grouped.putIfAbsent(1, () => []);
    grouped.putIfAbsent(2, () => []);
  }

  final orderedKeys = grouped.keys.toList(growable: false)
    ..sort((first, second) {
      final firstOrder = _serviceTypeOrder(first);
      final secondOrder = _serviceTypeOrder(second);
      final comparison = firstOrder.compareTo(secondOrder);
      return comparison != 0 ? comparison : first.compareTo(second);
    });

  return orderedKeys
      .map(
        (type) => SkillServiceTypeGroup(
          type: type,
          title: skillServiceTypeTitle(type),
          services: List<SkillServiceEntity>.unmodifiable(grouped[type]!),
        ),
      )
      .toList(growable: false);
}

String skillServiceTypeTitle(int type) {
  switch (type) {
    case 1:
      return 'خدمات امدادی';
    case 2:
      return 'خدمت در محل';
    case -1:
      return 'سایر خدمات';
    default:
      return 'سایر خدمات';
  }
}

int _serviceTypeOrder(int type) {
  switch (type) {
    case 1:
      return 0;
    case 2:
      return 1;
    default:
      return 2;
  }
}

extension SkillServiceTypeUiX on SkillServiceEntity {
  int get serviceTypeKey {
    final value = type;
    if (value == 1 || value == 2) return value!;
    return -1;
  }
}
