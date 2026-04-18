import 'package:injectable/injectable.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart' as perm;
import '../service/location_permission_service.dart';
import 'location_permission_data_source.dart';

@LazySingleton(as: LocationPermissionDataSource)
class LocationPermissionDataSourceImpl implements LocationPermissionDataSource {
  LocationPermissionDataSourceImpl(this._locService, this._permService);
  final ILocationDeviceService _locService;
  final IPermissionDeviceService _permService;

  @override
  Future<void> applyHighAccuracy() => _locService.changeSettings(accuracy: loc.LocationAccuracy.high, interval: 0, distanceFilter: 0);

  @override
  Future<loc.LocationData> getCurrentLocation() => _locService.getLocation();

  @override
  Future<bool> isServiceEnabled() => _locService.serviceEnabled();

  @override
  Future<bool> requestService() => _locService.requestService();

  @override
  Future<perm.PermissionStatus> requestPrecise() => _permService.requestPrecise();


  @override
  Future<perm.PermissionStatus> statusPrecise() => _permService.statusPrecise();

}