import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart' as perm;


abstract class LocationPermissionDataSource {
  Future<bool> isServiceEnabled();
  Future<bool> requestService();
  Future<void> applyHighAccuracy();
  Future<loc.LocationData> getCurrentLocation();
  Future<perm.PermissionStatus> statusPrecise();
  Future<perm.PermissionStatus> requestPrecise();
}