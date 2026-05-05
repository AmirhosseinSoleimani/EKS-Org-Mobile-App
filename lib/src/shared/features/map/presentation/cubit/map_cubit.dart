import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/address_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/address_to_location_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/map_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/usecase/apply_high_accuracy_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/usecase/ensure_location_reading_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/usecase/fetch_address_info_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/usecase/fetch_address_to_location_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/usecase/fetch_location_to_address_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/usecase/get_current_location_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/usecase/set_address_info_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart' as lat_lng;

import 'map_state.dart';
import 'map_utilities.dart';


@injectable
class MapCubit extends Cubit<MapState> {
  final FetchAddressInfoUseCase _fetchAddressInfoUseCase;
  final EnsureLocationReadingUseCase _ensureLocationReadingUseCase;
  final ApplyHighAccuracyUseCase _applyHighAccuracyUseCase;
  final GetCurrentLocationUseCase _getCurrentLocationUseCase;
  final FetchLocationToAddressUseCase _fetchLocationToAddressUseCase;
  final SetAddressInfoUseCase _setAddressInfoUseCase;
  final FetchAddressToLocationUseCase _fetchAddressToLocationUseCase;
  final Connectivity _connectivity = Connectivity();
  AddressInfoEntity? _initialLocation;
  MapCubit(
      this._fetchAddressInfoUseCase,
      this._ensureLocationReadingUseCase,
      this._applyHighAccuracyUseCase,
      this._getCurrentLocationUseCase,
      this._fetchLocationToAddressUseCase,
      this._setAddressInfoUseCase,
      this._fetchAddressToLocationUseCase,
      ) : super(const MapState.idle());

  final MapController mapController = MapController();
  late final StreamSubscription _mapMoveSub;

  final TextEditingController searchController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  lat_lng.LatLng _location = const lat_lng.LatLng(AppConstants.defaultLatitude, AppConstants.defaultLongitude);
  lat_lng.LatLng get location => _location;

  final _searchDebouncer = Debouncer(const Duration(milliseconds: 400));
  final _moveThrottle = Throttler(duration: const Duration(milliseconds: 80));

  AddressToLocationResponseEntity addressToLocationResponseEntity = const AddressToLocationResponseEntity();

  final _effects = StreamController<MapSideEffect>.broadcast();
  Stream<MapSideEffect> get effects => _effects.stream;
  final ValueNotifier<bool> findCurrentLocationLoading =
      ValueNotifier<bool>(false);
  VoidCallback? _retryAction;

  void _safeEmit(MapState state) {
    if (!isClosed) emit(state);
  }

  Future<bool> checkConnectionOrEmit() async {
    final results = await _connectivity.checkConnectivity();
    final hasInternet = !results.contains(ConnectivityResult.none);

    if (!hasInternet) {
      _safeEmit(const MapState.connectionError());
    }

    return hasInternet;
  }

  Future<void> _centerMapSafely(lat_lng.LatLng pos, {double zoom = 17}) async {
    if (!isClosed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        try {
          setMapPosition(pos, zoom: zoom);
        } catch (e, st) {
          debugPrint('centerMapSafely error: $e\n$st');
        }
      });
    }
  }

  void setMapPosition(lat_lng.LatLng pos, {double zoom = 17}) {
    try {
      if (mapController.camera.center != pos || mapController.camera.zoom != zoom) {
        mapController.move(pos, zoom);
      }
    } catch (e, st) {
      debugPrint('centerMapSafely error: $e\n$st');
    }

  }

  void setInitialLocation(AddressInfoEntity? address) {
    _initialLocation = address;
  }

  Future<void> init() async {
    _safeEmit(const MapState.idle());
    _retryAction = init;
    if(!await checkConnectionOrEmit()){
      return;
    }
    try {
      if (_initialLocation != null) {
        _location = lat_lng.LatLng(
          _initialLocation!.latitude ?? AppConstants.defaultLatitude,
          _initialLocation!.longitude ?? AppConstants.defaultLongitude,
        );
     }else{
       final addressInfoEntity = await _fetchAddressInfoUseCase();
       _location = lat_lng.LatLng(
         addressInfoEntity?.latitude ?? AppConstants.defaultLatitude,
         addressInfoEntity?.longitude ?? AppConstants.defaultLongitude,
       );
       await _centerMapSafely(_location, zoom: 17);
       _mapMoveSub = mapController.mapEventStream.listen((event) {
         if (event is MapEventMove && findCurrentLocationLoading.value) {
           findCurrentLocationLoading.value = false;
         }
       });
     }
    } catch (e) {
      emit(const MapState.error(
          messageModel:
              BottomSheetMessageModel(title: '', message: 'خطای غیر منتظره')));
    }
  }

  @override
  Future<void> close() async {
    try {
      _searchDebouncer.dispose();
    } catch (_) {}

    try {
      await _effects.close();
    } catch (_) {}

    try {
      searchController.dispose();
      addressController.dispose();
      findCurrentLocationLoading.dispose();
      _mapMoveSub.cancel();
    } catch (_) {}

    return super.close();
  }


  bool _movedEnough(lat_lng.LatLng a, lat_lng.LatLng b, {double eps = 1e-6}) {
    return (a.latitude - b.latitude).abs() > eps ||
        (a.longitude - b.longitude).abs() > eps;
  }

  void onMapMoved(MapCamera position) {
    _moveThrottle.run(() {
      final center = lat_lng.LatLng(position.center.latitude, position.center.longitude);
      if(_movedEnough(_location, center)) {
        _location = center;
      }
    });
  }

  Future<void> ensureAndCenterOnUser({int zoom = 17, bool centerOnMap = true}) async {
    _retryAction = () => ensureAndCenterOnUser(zoom: zoom,centerOnMap:centerOnMap);
    if (findCurrentLocationLoading.value) {
      return;
    }

    findCurrentLocationLoading.value = true;
    const fallback = lat_lng.LatLng(
      AppConstants.defaultLatitude,
      AppConstants.defaultLongitude,
    );
    final result = await _ensureLocationReadingUseCase.call();
    result.whenOrNull(
        success: (data, failures, resultCode) async {
        switch (data) {
          case PermissionOutcome.ok:
            emit(const MapState.permissionSuccess());
              await _applyHighAccuracyUseCase.call();
              final pos = await _getCurrentLocationUseCase();
              pos.whenOrNull(
                  success: (latLng, failures, resultCode) {
                    _location = latLng;
                    if (centerOnMap) setMapPosition(latLng, zoom: zoom.toDouble());
                  },
                  failure: (err, msg) {
                    if (centerOnMap) setMapPosition(fallback, zoom: zoom.toDouble());
                  },
              );
              break;
            case PermissionOutcome.gpsOff:
              if (centerOnMap) setMapPosition(fallback, zoom: zoom.toDouble());
              break;
            case PermissionOutcome.permanentlyDenied:
              _effects.add(const AskOpenSettings());
              if (centerOnMap) setMapPosition(fallback, zoom: zoom.toDouble());
              break;
            case PermissionOutcome.denied:
            emit(const MapState.permissionError(
                messageModel: BottomSheetMessageModel(
                    title: 'بدون مجوز',
                    message:
                        'بدون دسترسی، نقشه روی آدرس پیش‌فرض نمایش داده می‌شود')));
            if (centerOnMap) setMapPosition(fallback, zoom: zoom.toDouble());
            break;
            case PermissionOutcome.serviceError:
            emit(const MapState.permissionError(
                messageModel: BottomSheetMessageModel(
                    title: 'خطا', message: 'خطا در بررسی سرویس/مجوز موقعیت')));
            if (centerOnMap) setMapPosition(fallback, zoom: zoom.toDouble());
            break;
          }
        },
        failure: (error, msg) {
        emit(MapState.permissionError(
            messageModel: BottomSheetMessageModel(
                title: 'خطا', message: msg ?? 'بروز خطا در عملیات')));
        if (centerOnMap) setMapPosition(fallback, zoom: zoom.toDouble());
      },
      connectionError: () => emit(const MapState.connectionError()),
    );
  }

  Future<void> confirmSelectedAddress() async {
    if (addressController.text.isNotEmpty) {
      await setAddressInfo(
          entity: AddressInfoEntity(
        address: addressController.text,
        longitude: _location.longitude,
        latitude: _location.latitude,
      ));
    }
  }

  Future<void> setAddressInfo({AddressInfoEntity? entity}) async{
    try {
      await _setAddressInfoUseCase.call(entity);
    } catch(e) {
      emit(const MapState.error(
          messageModel: BottomSheetMessageModel(
              title: 'خطا',
              message:
                  "درخواست با خطا مواجه شد، سرویس دهنده نقشه در دسترس نمی باشد")));
    }
  }

  Future<void> fetchLocationToAddress() async {
    _retryAction = fetchLocationToAddress;
    emit(const MapState.locationToAddressLoading());
      final MapRequestEntity model = MapRequestEntity(
        select: 'nearby',
        lat: _location.latitude,
        lon: _location.longitude,
      );
      final result = await _fetchLocationToAddressUseCase.call(model);
      result.whenOrNull(
        success: (data, failures, resultCode) async {
          addressController.text = data?.address ?? '';
        await setAddressInfo(entity: AddressInfoEntity(
            address: addressController.text,
            longitude: _location.longitude,
            latitude: _location.latitude,
          ));
          emit(const MapState.locationToAddressSuccess());
        },
        failure: (error, msg) {
        emit(const MapState.error(
            messageModel: BottomSheetMessageModel(
                title: 'خطا',
                message:
                    "درخواست با خطا مواجه شد، سرویس دهنده نقشه در دسترس نمی باشد")));
      },
        connectionError: () => emit(const MapState.connectionError()),
      );
  }

  Future<void> fetchAddressToLocation() async {
    _retryAction = fetchAddressToLocation;
    if (searchController.text.length < 3) {
      return;
    }
    if (searchController.text.isNotEmpty) {
      _safeEmit(const MapState.searchLoading());
      final result = await _fetchAddressToLocationUseCase.call(
          MapRequestEntity(
            text: searchController.text,
            lat: _location.latitude,
            lon: _location.longitude,
          )
      );
      result.whenOrNull(
        success: (data, _, __) {
          addressToLocationResponseEntity = data ?? const AddressToLocationResponseEntity();
          _safeEmit(const MapState.searchSuccess());
        },
        failure: (error, msg) {
          _safeEmit(const MapState.searchError(
              bottomSheetMessageModel: BottomSheetMessageModel(
                title: 'خطا',
                message: '"درخواست با خطا مواجه شد، سرویس دهنده نقشه در دسترس نمی باشد"',
              )));
        },
        connectionError: () => emit(const MapState.connectionError()),
      );
    }
  }

  Future<void> selectedAddressLocation(GeoLocationEntity? entity) async{
    _location = lat_lng.LatLng(
      entity?.center?.latitude ?? AppConstants.defaultLatitude,
      entity?.center?.longitude ?? AppConstants.defaultLongitude,
    );
    await _centerMapSafely(_location, zoom: 17);
  }

  void retryLastAction() => _retryAction?.call();
}
