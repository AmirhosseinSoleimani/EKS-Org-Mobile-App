import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/labor_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/view_models/home_service_labor_selection_view_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/view_models/home_service_package_selection_view_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/view_models/home_service_part_selection_view_model.dart';

class HomeServiceEvaluationSelectionMapper {
  const HomeServiceEvaluationSelectionMapper._();

  static List<EmdadServiceResultEntity> extractCategories(
      ServiceResponseEntity? serviceResponse,
      ) {
    final services = serviceResponse?.emdadServices ?? [];

    final Map<int, EmdadServiceResultEntity> categories = {};

    for (final service in services) {
      final categoryId = service.serviceCategoryId;

      if (categoryId == null) continue;

      categories.putIfAbsent(categoryId, () => service);
    }

    return categories.values.toList();
  }

  static List<EmdadServiceResultEntity> extractPackagesByCategory({
    required ServiceResponseEntity? serviceResponse,
    required int? categoryId,
  }) {
    if (categoryId == null) return const [];

    final services = serviceResponse?.emdadServices ?? [];

    return services
        .where((service) => service.serviceCategoryId == categoryId)
        .toList();
  }

  static HomeServicePackageSelectionViewModel packageToSelection({
    required EmdadServiceResultEntity package,
    List<HomeServiceLaborSelectionViewModel> labors = const [],
  }) {
    return HomeServicePackageSelectionViewModel(
      categoryId: package.serviceCategoryId,
      categoryTitle: package.serviceCategoryTitle,
      packageId: package.serviceId,
      packageTitle: package.serviceTitle,
      labors: labors,
    );
  }

  static HomeServiceLaborSelectionViewModel laborToSelection({
    required LaborResponseEntity labor,
    List<HomeServicePartSelectionViewModel> parts = const [],
    bool isRequired = false,
    bool isSelected = false,
  }) {
    return HomeServiceLaborSelectionViewModel(
      id: labor.id ?? 0,
      title: labor.name ?? '',
      isRequired: isRequired,
      isSelected: isRequired || isSelected,
      parts: parts,
    );
  }

  static HomeServicePartSelectionViewModel partToSelection({
    required PartResponseEntity part,
    required int fallbackIndex,
    bool isRequired = false,
    bool isSelected = false,
  }) {
    return HomeServicePartSelectionViewModel(
      id: _resolvePartId(
        part: part,
        fallbackIndex: fallbackIndex,
      ),
      title: part.name ?? '',
      isRequired: isRequired,
      isSelected: isRequired || isSelected,
    );
  }

  static List<HomeServicePartSelectionViewModel> partsToSelection(
      List<PartResponseEntity> parts,
      ) {
    return parts.asMap().entries.map((entry) {
      return partToSelection(
        part: entry.value,
        fallbackIndex: entry.key,
      );
    }).toList();
  }

  static int _resolvePartId({
    required PartResponseEntity part,
    required int fallbackIndex,
  }) {
    final serial = part.serial;

    if (serial != null && serial.trim().isNotEmpty) {
      final parsedSerial = int.tryParse(serial);

      if (parsedSerial != null) {
        return parsedSerial;
      }
    }

    return -(fallbackIndex + 1);
  }
}