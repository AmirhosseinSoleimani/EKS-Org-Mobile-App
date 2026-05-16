import 'package:eks_sana_plus_org/src/common/constants/fetch_result_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/change_address_home_service_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/change_home_service_request_address_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/address_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/usecase/get_province_with_city_list_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../services/network/network_state/result/api_result.dart';

part 'change_home_service_request_address_cubit.freezed.dart';
part 'change_home_service_request_address_state.dart';

@injectable
class ChangeHomeServiceRequestAddressCubit
    extends Cubit<ChangeHomeServiceRequestAddressState> {
  ChangeHomeServiceRequestAddressCubit(
    this._fetchSelectedRequestItemUseCase,
    this._getHomeServiceRequestByIdUseCase,
    this._getEmdadgarInfoUseCase,
      this._getProvinceWithCityListUseCase,
      this._changeHomeServiceRequestAddressUseCase,
  ) : super(const ChangeHomeServiceRequestAddressState.idle());

  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetHomeServiceRequestByIdUseCase _getHomeServiceRequestByIdUseCase;
  final GetEmdadgarInfoUseCase _getEmdadgarInfoUseCase;
  final GetProvinceWithCityListUseCase _getProvinceWithCityListUseCase;
  final ChangeHomeServiceRequestAddressUseCase _changeHomeServiceRequestAddressUseCase;

  String? _errorMessage;
  BaseRequestEntity? selectedRequest;
  EmdadgarInfoEntity? emdadgarInfo;
  AddressInfoEntity? selectedLocation;
  List<ProvinceEntity> provinceList = <ProvinceEntity>[];

  final selectedProvince = ValueNotifier<ProvinceEntity?>(null);

  final addressController = TextEditingController();


  Future<void> init() async {
    _safeEmit(const ChangeHomeServiceRequestAddressState.loading());
    final result = await _initializeData();

    switch (result) {
      case FetchResultType.success:
        _safeEmit(const ChangeHomeServiceRequestAddressState.loaded());
        break;

      case FetchResultType.failure:
        _emitError();
        break;

      case FetchResultType.connectionError:
        _safeEmit(const ChangeHomeServiceRequestAddressState.connectionError());
        break;

      case FetchResultType.expireToken:
        _emitError('نشست شما منقضی شده است. لطفا دوباره وارد شوید');
        break;
    }
  }

  Future<FetchResultType> _initializeData() async {
    final selectedResult = await _fetchSelectedRequest();
    if (selectedResult != FetchResultType.success) return selectedResult;

    final requestResult = await _fetchServiceRequestData();
    if (requestResult != FetchResultType.success) {
      return requestResult;
    }

    if (selectedRequest?.hasEmdadGar ?? false) {
      final emdadgarResult = await _fetchEmdadgarInfo();
      if (emdadgarResult != FetchResultType.success) {
        return emdadgarResult;
      }
    }

    final provinceListResult = await _fetchProvinceList();
    if (provinceListResult != FetchResultType.success) {
      return provinceListResult;
    }

    return FetchResultType.success;
  }

  Future<FetchResultType> _fetchSelectedRequest() async {
    try {
      selectedRequest = await _fetchSelectedRequestItemUseCase.call();
      return FetchResultType.success;
    } catch (_) {
      _errorMessage = _fallbackError();
      return FetchResultType.failure;
    }
  }

  Future<FetchResultType> _fetchServiceRequestData() async {
    final id = selectedRequest?.id ?? 0;
    final result = await _getHomeServiceRequestByIdUseCase(id);

    FetchResultType fetchResult = FetchResultType.failure;

    result.whenOrNull(
      success: (data, _, _) {
        selectedRequest = data;
        fetchResult = FetchResultType.success;
      },
      failure: (_, msg) {
        _errorMessage = _fallbackError(msg);
        fetchResult = FetchResultType.failure;
      },
      connectionError: () {
        fetchResult = FetchResultType.connectionError;
      },
    );
    return fetchResult;
  }

  Future<FetchResultType> _fetchEmdadgarInfo() async {
    final param = ServiceRequestParamEntity(
      serviceRequestId: selectedRequest?.id ?? 0,
      serviceType: selectedRequest?.serviceType?.value ?? 1,
    );
    final result = await _getEmdadgarInfoUseCase(param);

    FetchResultType fetchResult = FetchResultType.failure;

    result.whenOrNull(
      success: (data, _, _) {
        emdadgarInfo = data;
        fetchResult = FetchResultType.success;
      },
      failure: (_, msg) {
        _errorMessage = _fallbackError(msg);
        fetchResult = FetchResultType.failure;
      },
      connectionError: () {
        fetchResult = FetchResultType.connectionError;
      },
    );
    return fetchResult;
  }
  Future<FetchResultType> _fetchProvinceList() async {
    provinceList = <ProvinceEntity>[
      const ProvinceEntity(
        provinceId: 25,
        provinceCode: 25,
        cityId: 2502,
        cityCode: 2502,
        title: 'قم/دستجرد',
        cityName: 'دستجرد',
        latitude: 34.6399443,
        longitude: 50.8759419,
      ),
      const ProvinceEntity(
        provinceId: 25,
        provinceCode: 25,
        cityId: 2504,
        cityCode: 2504,
        title: 'قم/سلفچکان',
        cityName: 'سلفچکان',
        latitude: 34.4766738,
        longitude: 50.4553687,
      ),
      const ProvinceEntity(
        provinceId: 25,
        provinceCode: 25,
        cityId: 2505,
        cityCode: 2505,
        title: 'قم/جعفریه',
        cityName: 'جعفریه',
        latitude: 34.774489,
        longitude: 50.514622,
      ),
      const ProvinceEntity(
        provinceId: 26,
        provinceCode: 26,
        cityId: 2601,
        cityCode: 2601,
        title: 'کردستان/سنندج',
        cityName: 'سنندج',
        latitude: 35.3029422,
        longitude: 47.0026312,
      ),
      const ProvinceEntity(
        provinceId: 26,
        provinceCode: 26,
        cityId: 2602,
        cityCode: 2602,
        title: 'کردستان/قروه',
        cityName: 'قروه',
        latitude: 35.165218,
        longitude: 47.799809,
      ),
      const ProvinceEntity(
        provinceId: 26,
        provinceCode: 26,
        cityId: 2604,
        cityCode: 2604,
        title: 'کردستان/مریوان',
        cityName: 'مریوان',
        latitude: 35.5195216,
        longitude: 46.1840209,
      ),
      const ProvinceEntity(
        provinceId: 16,
        provinceCode: 16,
        cityId: 1601,
        cityCode: 1601,
        title: 'تهران/تهران',
        cityName: 'تهران',
        latitude: 35.702937,
        longitude: 51.400449,
      ),
    ];

    selectedProvince.value = provinceList
        .where((element) => element.provinceId == selectedRequest?.id)
        .cast<ProvinceEntity?>()
        .firstOrNull;

    return FetchResultType.success;
  }



/*  Future<FetchResultType> _fetchProvinceList() async {
    final result = await _getProvinceWithCityListUseCase();
    FetchResultType fetchResult = FetchResultType.failure;

    result.when(
      success: (data, _, _) {
        provinceList = data;
        selectedProvince.value = provinceList
            .where((element) => element.provinceId == selectedRequest?.id)
            .cast<ProvinceEntity?>()
            .firstOrNull;

        fetchResult = FetchResultType.success;
      },
      failure: (_, msg) {
        _errorMessage = _fallbackError(msg);
        fetchResult = FetchResultType.failure;
      },
      connectionError: () {
        fetchResult = FetchResultType.connectionError;
      },
      expireToken: () {
        fetchResult = FetchResultType.expireToken;
      },
    );
    return fetchResult;
  }*/

  Future<void> changeRequestAddress() async {
    _safeEmit(ChangeHomeServiceRequestAddressState.submitLoading());

    final param = ChangeAddressHomeServiceParamEntity(
      homeServiceRequestId: selectedRequest?.id ?? 0,
      cityId: selectedProvince.value?.cityId,
      latitude: selectedLocation?.latitude,
      longitude: selectedLocation?.longitude,
      address: addressController.text,
    );
    final result = await _changeHomeServiceRequestAddressUseCase(param);

    result.whenOrNull(
      success: (data, _, _) {
        final successMessage = BottomSheetMessageModel(
            title: '', message: data.message);
        _safeEmit(ChangeHomeServiceRequestAddressState.submitSuccess(
            message: successMessage));
      },
      failure: (error, msg) =>
          _emitError(_fallbackError(msg ?? error.toString())),
      connectionError: () =>
          _safeEmit(const ChangeHomeServiceRequestAddressState.connectionError()),
    );
  }

  void setSelectedProvince(ProvinceEntity province) {
    selectedProvince.value = province;
    selectedLocation = (selectedLocation ?? const AddressInfoEntity()).copyWith(
      latitude: province.latitude,
      longitude: province.longitude,
    );
  }

  void setSelectedLocation(AddressInfoEntity location) {
    selectedLocation = location;
    addressController.text = location.address ?? '';
  }

  void _safeEmit(ChangeHomeServiceRequestAddressState state) {
    if (!isClosed) emit(state);
  }

  void _emitError([String? message]) {
    _safeEmit(
      ChangeHomeServiceRequestAddressState.error(
        message: BottomSheetMessageModel(
          title: 'خطا',
          message: message ?? _errorMessage ?? _fallbackError(),
        ),
      ),
    );
  }

  String _fallbackError([String? msg]) {
    if (msg?.trim().isNotEmpty == true) {
      return msg!;
    }
    return 'درخواست شما با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';
  }
}
