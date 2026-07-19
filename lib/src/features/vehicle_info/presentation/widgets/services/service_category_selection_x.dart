import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/emdad_service_category_entity.dart';

extension ServiceCategorySelectionX on EmdadServiceCategoryEntity {
  bool get isSelectedForVehicle => selected ?? selectable;
}
