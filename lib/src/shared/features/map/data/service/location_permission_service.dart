
import 'package:injectable/injectable.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart' as perm;

abstract class ILocationDeviceService {
  Future<void> changeSettings({required loc.LocationAccuracy accuracy, int interval, double distanceFilter});
  Future<bool> serviceEnabled();
  Future<bool> requestService();
  Future<loc.LocationData> getLocation();
}

@LazySingleton(as: ILocationDeviceService)
class LocationDeviceService implements ILocationDeviceService {
  LocationDeviceService(this._location);
  final loc.Location _location;

  @override
  Future<void> changeSettings({required loc.LocationAccuracy accuracy, int interval = 0, double distanceFilter = 0}) =>
      _location.changeSettings(accuracy: accuracy, interval: interval, distanceFilter: distanceFilter);

  @override
  Future<loc.LocationData> getLocation() => _location.getLocation();


  @override
  Future<bool> requestService() => _location.requestService();


  @override
  Future<bool> serviceEnabled() => _location.serviceEnabled();
}



abstract class IPermissionDeviceService {
  Future<perm.PermissionStatus> statusPrecise();
  Future<perm.PermissionStatus> requestPrecise();
  Future<bool> openAppSettings();
}

@LazySingleton(as: IPermissionDeviceService)
class PermissionDeviceService implements IPermissionDeviceService {

  @override
  Future<bool> openAppSettings() => perm.openAppSettings();

  @override
  Future<perm.PermissionStatus> requestPrecise() => perm.Permission.location.request();

  @override
  Future<perm.PermissionStatus> statusPrecise() => perm.Permission.location.status;

}