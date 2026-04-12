import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:latlong2/latlong.dart' as lat_lng;


abstract class LocationPermissionRepository {
  Future<ApiResult<PermissionOutcome>> ensureReadiness();
  Future<ApiResult<void>> applyHighAccuracy();
  Future<ApiResult<lat_lng.LatLng>> getCurrentPosition({Duration? timeout});
}