import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/presentation/models/emdad_vehicle_action.dart';

class EmdadVehicleListItemViewModel {
  final VehicleModelEntity? vehicle;
  final List<EmdadVehicleAction> actions;

  const EmdadVehicleListItemViewModel({
    this.vehicle,
    this.actions = EmdadVehicleActions.values,
  });

  EmdadVehicleListItemViewModel copyWith({
    VehicleModelEntity? vehicle,
    List<EmdadVehicleAction>? actions,
  }) {
    return EmdadVehicleListItemViewModel(
      vehicle: vehicle ?? this.vehicle,
      actions: actions ?? this.actions,
    );
  }
}
