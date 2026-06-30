import 'package:geolocator/geolocator.dart';
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
@LazySingleton(as: ILocationDeviceService)
class LocationDeviceService implements ILocationDeviceService {

  @override
  Future<void> changeSettings({
    required loc.LocationAccuracy accuracy,
    int interval = 0,
    double distanceFilter = 0,
  }) async {
    // geolocator تنظیم global مثل location plugin ندارد
    // پس اینجا عملاً کاری لازم نیست
  }

  @override
  Future<loc.LocationData> getLocation() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return loc.LocationData.fromMap({
      "latitude": position.latitude,
      "longitude": position.longitude,
      "accuracy": position.accuracy,
      "altitude": position.altitude,
      "speed": position.speed,
    });
  }

  @override
  Future<bool> requestService() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  @override
  Future<bool> serviceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }
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