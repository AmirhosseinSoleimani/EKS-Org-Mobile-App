import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_entity.dart';

List<ProvinceEntity> uniqueDeploymentLocationProvinces(
  List<ProvinceEntity> items,
) {
  final seen = <String>{};
  final result = <ProvinceEntity>[];

  for (final item in items) {
    final key = item.provinceId?.toString() ?? item.title?.trim() ?? '';
    if (key.isEmpty || !seen.add(key)) continue;
    result.add(item);
  }

  result.sort(
    (a, b) => (a.title ?? '').compareTo(b.title ?? ''),
  );
  return result;
}

List<ProvinceEntity> deploymentLocationCitiesForProvince(
  List<ProvinceEntity> items,
  int? provinceId,
) {
  if (provinceId == null) return const [];

  final result = items
      .where(
        (item) =>
            item.provinceId == provinceId &&
            item.cityId != null &&
            item.cityName?.trim().isNotEmpty == true,
      )
      .toList(growable: false);

  result.sort(
    (a, b) => (a.cityName ?? '').compareTo(b.cityName ?? ''),
  );
  return result;
}

ProvinceEntity? findDeploymentLocationProvince({
  required List<ProvinceEntity> items,
  int? provinceId,
  String? provinceTitle,
}) {
  final normalizedTitle = provinceTitle?.trim();
  for (final item in uniqueDeploymentLocationProvinces(items)) {
    if (provinceId != null && item.provinceId == provinceId) return item;
    if (normalizedTitle?.isNotEmpty == true && item.title == normalizedTitle) {
      return item;
    }
  }
  return null;
}

ProvinceEntity? findDeploymentLocationCity({
  required List<ProvinceEntity> items,
  int? cityId,
  String? cityTitle,
}) {
  final normalizedTitle = cityTitle?.trim();
  for (final item in items) {
    if (cityId != null && item.cityId == cityId) return item;
    if (normalizedTitle?.isNotEmpty == true &&
        item.cityName == normalizedTitle) {
      return item;
    }
  }
  return null;
}
