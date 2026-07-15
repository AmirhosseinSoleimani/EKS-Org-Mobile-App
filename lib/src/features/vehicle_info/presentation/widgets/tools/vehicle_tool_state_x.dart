import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_tool_entity.dart';

extension VehicleToolStateX on VehicleToolEntity {
  bool get isSelectedForVehicle => isSelectable;

  bool get isReadOnlyForVehicle {
    final dynamic item = this;
    final readOnly = _tryReadBool(() => item.readOnly);
    if (readOnly != null) return readOnly;

    final readonly = _tryReadBool(() => item.readonly);
    if (readonly != null) return readonly;

    final readoOnley = _tryReadBool(() => item.readoOnley);
    if (readoOnley != null) return readoOnley;

    final readOnlyTypo = _tryReadBool(() => item.readOnley);
    if (readOnlyTypo != null) return readOnlyTypo;

    return false;
  }

  bool? _tryReadBool(bool? Function() read) {
    try {
      return read();
    } catch (_) {
      return null;
    }
  }
}
