import 'dart:async';

import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/data_source/location_permission_data_source.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/repository/location_permission_repository.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart' as lat_lng;
import 'package:permission_handler/permission_handler.dart' as perm;

@LazySingleton(as: LocationPermissionRepository)
class LocationPermissionRepositoryImpl extends LocationPermissionRepository {
  final LocationPermissionDataSource _dataSource;

  LocationPermissionRepositoryImpl(this._dataSource);

  @override
  Future<ApiResult<void>> applyHighAccuracy() async {
    try {
      await _dataSource.applyHighAccuracy();
      return const ApiResult.success(data: null, resultCode: 0);
    } catch (_) {
      return const ApiResult.failure(
          failures:
          'خطا در دریافت دقیق (GPS) موقعیت مکانی شما بصورت حدودی نمایش داده می شود');
    }
  }

  @override
  Future<ApiResult<PermissionOutcome>> ensureReadiness() async {
    try {
      bool enabled = await _dataSource.isServiceEnabled();
      if (!enabled) {
        enabled = await _dataSource.requestService();
        if (!enabled)
          return const ApiResult.success(
              data: PermissionOutcome.gpsOff, resultCode: 1);
      }
    } catch (_) {
      return const ApiResult.success(
          data: PermissionOutcome.serviceError, resultCode: 1);
    }
    try {
      perm.PermissionStatus status = await _dataSource.statusPrecise();
      if (status.isDenied || status.isRestricted) {
        status = await _dataSource.requestPrecise();
      }
      if (status.isPermanentlyDenied) {
        return const ApiResult.success(
            data: PermissionOutcome.permanentlyDenied, resultCode: 1);
      }
      if (!status.isGranted) {
        return const ApiResult.success(
            data: PermissionOutcome.denied, resultCode: 1);
      }
    } catch (_) {
      return const ApiResult.success(
          data: PermissionOutcome.serviceError, resultCode: 1);
    }

    return const ApiResult.success(data: PermissionOutcome.ok, resultCode: 0);
  }

  @override
  Future<ApiResult<lat_lng.LatLng>> getCurrentPosition(
      {Duration? timeout}) async {
    try {
      final d = await _dataSource
          .getCurrentLocation()
          .timeout(timeout ?? DurationConstant.d6000);
      final pos = lat_lng.LatLng(
        d.latitude ?? AppConstants.defaultLatitude,
        d.longitude ?? AppConstants.defaultLongitude,
      );
      return ApiResult.success(data: pos, resultCode: 0);
    } catch (_) {
      return const ApiResult.failure(
          failures: 'دریافت موقعیت مکانی، با خطا همراه می باشد');
    }
  }
}
