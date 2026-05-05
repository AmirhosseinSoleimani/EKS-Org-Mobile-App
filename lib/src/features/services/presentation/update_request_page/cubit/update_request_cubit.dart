import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/common/constants/fetch_result_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/defect_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/emdad_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/services_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_aid_services_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_defects_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/update_service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/update_service_request_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/address_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/location_data_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/location_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/usecase/get_location_data_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/usecase/get_province_with_city_list_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'update_request_cubit.freezed.dart';
part 'update_request_state.dart';

@injectable
class UpdateRequestCubit extends Cubit<UpdateRequestState> {
  UpdateRequestCubit(this._fetchSelectedRequestItemUseCase,
      this._getReliefRequestByIdUseCase,
      this._getEmdadgarInfoUseCase,
      this._getProvinceWithCityListUseCase,
      this._getLocationDataUseCase,
      this._getDefectsListUseCase,
      this._getAidServicesListUseCase,
      this._updateServiceRequestUseCase,)
      : super(const UpdateRequestState.idle());

  final formKey = GlobalKey<FormState>();
  final validationNotifier = ValueNotifier<bool>(false);

  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetEmdadgarInfoUseCase _getEmdadgarInfoUseCase;
  final GetProvinceWithCityListUseCase _getProvinceWithCityListUseCase;
  final GetLocationDataUseCase _getLocationDataUseCase;
  final GetDefectsListUseCase _getDefectsListUseCase;
  final GetAidServicesListUseCase _getAidServicesListUseCase;
  final UpdateServiceRequestUseCase _updateServiceRequestUseCase;

  ReliefRequestEntity? selectedRequest;
  EmdadgarInfoEntity? emdadgarInfo;
  List<ProvinceEntity> provinceList = <ProvinceEntity>[];
  List<DefectEntity> defectList = <DefectEntity>[];
  ServiceResponseEntity? serviceResponseEntity;
  AddressInfoEntity? addressInfoEntity;

  final selectedDefect = ValueNotifier<DefectEntity?>(null);
  final selectedProvince = ValueNotifier<ProvinceEntity?>(null);

  final showAllServices = ValueNotifier<bool>(false);
  final selectedService = ValueNotifier<EmdadServiceEntity?>(null);
  final filteredServices = ValueNotifier<List<EmdadServiceEntity>>([]);

  final locationData = ValueNotifier<LocationDataEntity?>(null);
  AddressInfoEntity? selectedLocation;

  final TextEditingController licensePlateController = TextEditingController();
  final TextEditingController clientPhoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();


  String? _errorMessage;

  Future<void> init() async {
    _safeEmit(const UpdateRequestState.loading());

    /// ---------- Selected Request ----------
    selectedRequest = ReliefRequestEntity(
      id: 1001,
      firstName: 'علی',
      lastName: 'احمدی',
      licensePlate: '12الف345ایران67',
      customerMobileNumber: '09121234567',
      description: 'خودرو روشن نمی‌شود',
      provinceId: 1,
      provinceName: 'تهران',
      cityId: 101,
      cityName: 'تهران',
      latitude: 35.6892,
      longitude: 51.3890,
      defectId: 10,
      defectTitle: 'خرابی باتری',
      emdadServiceId: 501,
      emdadServiceTitle: 'تعویض باتری',
    );

    /// ---------- Emdadgar Info ----------
    emdadgarInfo = EmdadgarInfoEntity(
      id: 200,
      aidPerName1: 'امدادگر تستی',
      mobile: '09123334455',
      agencyName: 'نمایندگی مرکزی',
      lastLocationLatitude: 35.70,
      lastLocationLongitude: 51.40,
      isActive: true,
      inShift: true,
    );

    /// ---------- Province & City ----------
    provinceList = [
      ProvinceEntity(
        provinceId: 1,
        provinceCode: 21,
        title: 'تهران',
        cityId: 101,
        cityName: 'تهران',
        latitude: 35.6892,
        longitude: 51.3890,
      ),
      ProvinceEntity(
        provinceId: 2,
        provinceCode: 26,
        title: 'البرز',
        cityId: 201,
        cityName: 'کرج',
        latitude: 35.8327,
        longitude: 50.9915,
      ),
    ];

    selectedProvince.value = provinceList.firstWhere(
          (e) => e.provinceId == selectedRequest?.provinceId,
    );

    /// ---------- Defects ----------
    defectList = [
      DefectEntity(
        id: 10,
        title: 'خرابی باتری',
        isActive: true,
      ),
      DefectEntity(
        id: 11,
        title: 'پنچری لاستیک',
        isActive: true,
      ),
    ];

    selectedDefect.value = defectList.firstWhere(
          (e) => e.id == selectedRequest?.defectId,
    );

    /// ---------- Services ----------
    serviceResponseEntity = ServiceResponseEntity(
      id: 1,
      carModelId: 300,
      guid: 'fake-guid-123',
      name: 'سرویس تستی خودرو',
      chassisNo: 'CHASSIS123',
      defectInfo: DefectInfoEntity(
        id: 10,
        estimatedTime: 45,
        maxCost: 1000,
        minCost: 500,
      ),
      emdadServices: [
        EmdadServiceEntity(
          serviceType: 1,
          serviceTypeTitle: 'امداد',
          serviceCategoryId: 50,
          serviceCategoryCode: 'BAT',
          serviceCategoryTitle: 'باتری',
          serviceId: 501,
          serviceCode: 'BAT01',
          serviceTitle: 'تعویض تسمه',
          serviceFromKilometer: 0,
          serviceToKilometer: 200000,
          isSelectable: true,
          workOrderCode: 'WO-01',
          isSubscribedByNationalCode: true,
          isImageMandatory: false,
        ),
        EmdadServiceEntity(
          serviceType: 1,
          serviceTypeTitle: 'امداد',
          serviceCategoryId: 50,
          serviceCategoryCode: 'BAT',
          serviceCategoryTitle: 'باتری',
          serviceId: 5301,
          serviceCode: 'BAT01',
          serviceTitle: 'تعویض باتری',
          serviceFromKilometer: 0,
          serviceToKilometer: 200000,
          isSelectable: false,
          workOrderCode: 'WO-01',
          isSubscribedByNationalCode: false,
          isImageMandatory: false,
        ),
        EmdadServiceEntity(
          serviceType: 1,
          serviceTypeTitle: 'امداد',
          serviceCategoryId: 51,
          serviceCategoryCode: 'TIRE',
          serviceCategoryTitle: 'لاستیک',
          serviceId: 502,
          serviceCode: 'TIRE01',
          serviceTitle: 'تعویض لاستیک',
          serviceFromKilometer: 0,
          serviceToKilometer: 200000,
          isSelectable: true,
          workOrderCode: 'WO-02',
          isSubscribedByNationalCode: false,
          isImageMandatory: true,
        ),
      ],
    );
    filterServiceByisSelectable();
    selectedService.value = serviceResponseEntity!.emdadServices.firstWhere(
          (e) => e.serviceId == selectedRequest?.emdadServiceId,
    );

    /// ---------- Location ----------
    locationData.value = LocationDataEntity(
      id: 1,
      title: 'محدوده مجاز',
      type: 'Traffic',
      hasTrafficPlan: false,
      hasPollutionPlan: false,
      hasTrafficOrPollutionPlan: false,
      status: 'test status',
    );

    /// ---------- Controllers ----------
    licensePlateController.text = selectedRequest?.licensePlate ?? '';
    clientPhoneNumberController.text =
        selectedRequest?.customerMobileNumber ?? '';
    addressController.text = selectedRequest?.aidAddress ?? 'تهران، خیابان تست';
    descriptionController.text = selectedRequest?.description ?? '';

    _safeEmit(const UpdateRequestState.loaded());
  }

 /* Future<void> init() async {
    final result = await _initializeData();

    switch (result) {
      case FetchResultType.success:
        _safeEmit(const UpdateRequestState.loaded());
        break;

      case FetchResultType.failure:
        _emitError();
        break;

      case FetchResultType.connectionError:
        _safeEmit(const UpdateRequestState.connectionError());
        break;

      case FetchResultType.expireToken:
        _emitError('نشست شما منقضی شده است. لطفا دوباره وارد شوید');
        break;
    }
  }*/

  Future<FetchResultType> _initializeData() async {
    final selectedResult = await _fetchSelectedServiceRequest();
    if (selectedResult != FetchResultType.success) {
      return selectedResult;
    }

    _safeEmit(const UpdateRequestState.loading());

    final requestResult = await _fetchServiceRequestData();
    if (requestResult != FetchResultType.success) {
      return requestResult;
    }

    if (_shouldFetchEmdadgarInfo) {
      final emdadgarResult = await _fetchEmdadgarInfo();
      if (emdadgarResult != FetchResultType.success) {
        return emdadgarResult;
      }
    }

    final provinceListResult = await _fetchProvinceList();
    if (provinceListResult != FetchResultType.success) {
      return provinceListResult;
    }

    final locationDataResult = await _fetchLocationData();
    if (locationDataResult != FetchResultType.success) {
      return locationDataResult;
    }

    final defectsListResult = await _fetchDefectsList();
    if (defectsListResult != FetchResultType.success) {
      return defectsListResult;
    }

    final aidServicesListResult = await _fetchAidServicesList();
    if (aidServicesListResult != FetchResultType.success) {
      return aidServicesListResult;
    }

    return FetchResultType.success;
  }

  bool get _shouldFetchEmdadgarInfo {
    return (selectedRequest?.requestStatus ?? 0) > 1;
  }

  Future<FetchResultType> _fetchSelectedServiceRequest() async {
    try {
      selectedRequest =
      (await _fetchSelectedRequestItemUseCase.call() as ReliefRequestEntity);
      return FetchResultType.success;
    } catch (_) {
      _errorMessage = _fallbackError();
      return FetchResultType.failure;
    }
  }

  Future<FetchResultType> _fetchServiceRequestData() async {
    final id = selectedRequest?.id ?? 0;

    final result = await _getReliefRequestByIdUseCase(id);

    FetchResultType fetchResult = FetchResultType.failure;

    result.when(
      success: (data, failures, resultCode) {
        selectedRequest = data;
        clientPhoneNumberController.text =
            selectedRequest?.customerMobileNumber ?? '';

        licensePlateController.text = selectedRequest?.licensePlate ?? '';

        descriptionController.text = selectedRequest?.description ?? '';

        selectedLocation = AddressInfoEntity(
          latitude: selectedRequest?.latitude,
          longitude: selectedRequest?.longitude,
          address: selectedRequest?.aidAddress,
        );

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
  }

  Future<FetchResultType> _fetchEmdadgarInfo() async {
    final param = ServiceRequestParamEntity(
      serviceRequestId: selectedRequest?.id ?? 0,
      serviceType: selectedRequest?.serviceType?.value ?? 1,
    );
    final result = await _getEmdadgarInfoUseCase(param);

    FetchResultType fetchResult = FetchResultType.failure;

    result.when(
      success: (data, _, __) {
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
      expireToken: () {
        fetchResult = FetchResultType.expireToken;
      },
    );
    return fetchResult;
  }


  Future<FetchResultType> _fetchProvinceList() async {
    final result = await _getProvinceWithCityListUseCase();
    FetchResultType fetchResult = FetchResultType.failure;

    result.when(
      success: (data, _, __) {
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
  }

  Future<FetchResultType> _fetchLocationData() async {
    final param = LocationEntity(
      latitude: selectedLocation?.latitude ?? 0,
      longitude: selectedLocation?.longitude ?? 0,
    );

    final result = await _getLocationDataUseCase(param);

    FetchResultType fetchResult = FetchResultType.failure;

    result.when(
      success: (data, _, __) {
        locationData.value = data;
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
  }

  Future<FetchResultType> _fetchDefectsList() async {
    final result = await _getDefectsListUseCase(selectedRequest?.id);

    FetchResultType fetchResult = FetchResultType.failure;

    result.when(
      success: (data, _, __) {
        defectList = data;
        selectedDefect.value = defectList
            .where((element) => element.id == selectedRequest?.defectId)
            .cast<DefectEntity?>()
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
  }

  Future<FetchResultType> _fetchAidServicesList() async {
    final param = ServicesParamEntity(
        serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
        carModelId: selectedRequest?.carModelId ?? 0,
        carInfoGuid: selectedRequest?.carInfoGuid ?? '',
        defectId: selectedRequest?.defectId ?? 0,
        nationalCode: selectedRequest?.nationalCode ?? '',
        kilometer: selectedRequest?.kilometer ?? 0);

    final result = await _getAidServicesListUseCase(param);

    FetchResultType fetchResult = FetchResultType.failure;

    result.when(
      success: (data, _, __) {
        serviceResponseEntity = data;

        selectedService.value = serviceResponseEntity?.emdadServices
            .where((element) =>
        element.serviceId == selectedRequest?.emdadServiceId)
            .cast<EmdadServiceEntity?>()
            .firstOrNull;

        filteredServices.value = serviceResponseEntity!.emdadServices
            .where((e) => e.isSelectable)
            .toList();

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
  }

  Future<FetchResultType> updateServiceRequest() async {
    final param = UpdateServiceRequestParamEntity(
      id: selectedRequest?.id,
      latitude: selectedLocation?.latitude,
      longitude: selectedLocation?.longitude,
      aIDAddress: addressController.text,
      licensePlateNo: licensePlateController.text,
      callMobileNumber: selectedRequest?.callMobileNumber,
      carInfoGuid: selectedRequest?.carInfoGuid ?? '',
      defectId: selectedDefect.value?.id ?? 0,
      description: descriptionController.text,
      emdadServiceId: selectedService.value?.serviceId ?? 0,
      trafficPlan: locationData.value?.hasTrafficPlan ?? false,
      cityId: selectedProvince.value?.cityId,
    );

    final result = await _updateServiceRequestUseCase(param);

    FetchResultType fetchResult = FetchResultType.failure;

    result.when(
      success: (data, _, __) {
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
  }

  String _fallbackError([String? msg]) =>
      msg
          ?.trim()
          .isNotEmpty == true
          ? msg!
          : 'درخواست شما با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';

  void _emitError([String? message]) {
    _safeEmit(
      UpdateRequestState.error(
        message: BottomSheetMessageModel(
          title: 'خطا',
          message: message ?? _errorMessage ?? _fallbackError(),
        ),
      ),
    );
  }

  void toggleShowAllServices(bool value) {
    showAllServices.value = value;

    final list = serviceResponseEntity?.emdadServices ?? [];

    if (value) {
      filteredServices.value = List.from(list);
    } else {
      filterServiceByisSelectable();
    }
  }

  void filterServiceByisSelectable() {
     filteredServices.value = (serviceResponseEntity?.emdadServices ?? [])
         .where((e) => e.isSelectable).toList();
  }

  void setSelectedService(EmdadServiceEntity service) {
    selectedService.value = service;
  }

  void setSelectedDefect(DefectEntity defect) {
    selectedDefect.value = defect;
  }
  void setSelectedProvince(ProvinceEntity province) {
    selectedProvince.value = province;
  }

  void setSelectedLocation(AddressInfoEntity location) {
    selectedLocation = location;
    addressController.text = location.address ?? '';
    _fetchLocationData();
  }


  void _safeEmit(UpdateRequestState state) {
    if (!isClosed) emit(state);
  }
}
