import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/distance_to_customer_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/home_service_package_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/home_service_package_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/home_service_part_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/labor_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/last_evaluation_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_category_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_category_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_distance_to_customer_home_service_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_home_service_package_use_case.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_labor_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_last_evaluation_home_service_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_part_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_service_categories_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_services_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/post_evaluation_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/cubit/home_service_evaluation_data.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/cubit/home_service_evaluation_sheet_type.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/cubit/home_service_evaluation_state.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/mappers/home_service_evaluation_selection_mapper.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/view_models/home_service_package_selection_view_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/view_models/selected_extra_service_view_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/view_models/selected_home_service_labor_view_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/view_models/selected_home_service_package_view_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/view_models/selected_home_service_part_view_model.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_info_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeServiceEvaluationCubit extends Cubit<HomeServiceEvaluationState> {
  final GetServicesUseCase _getServicesUseCase;
  final GetLaborUseCase _getLaborUseCase;
  final GetPartUseCase _getPartUseCase;
  final GetLastEvaluationHomeServiceUseCase
  _getLastEvaluationHomeServiceUseCase;
  final GetDistanceToCustomerHomeServiceUseCase
  _getDistanceToCustomerHomeServiceUseCase;
  final GetEmdadgarInfoUseCase _getEmdadgarInfoUseCase;
  final PostEvaluationUseCase _postEvaluationUseCase;
  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetServiceCategoriesUseCase _getServiceCategoriesUseCase;
  final GetInsertHomeServicePackageUseCase _getHomeServicePackageUseCase;

  HomeServiceEvaluationCubit(this._getServicesUseCase,
      this._getLaborUseCase,
      this._getPartUseCase,
      this._getLastEvaluationHomeServiceUseCase,
      this._getDistanceToCustomerHomeServiceUseCase,
      this._getEmdadgarInfoUseCase,
      this._postEvaluationUseCase,
      this._fetchSelectedRequestItemUseCase,
      this._getServiceCategoriesUseCase,
      this._getHomeServicePackageUseCase,)
      : super(const HomeServiceEvaluationState.idle());

  String? _errorMessage;

  HomeServiceEvaluationData get data => state.data;

  String? get errorMessage => _errorMessage;

  Future<void> init() async {
    emit(HomeServiceEvaluationState.loading(data: data));

    final selectedRequestLoaded = await _getSelectedRequest();
    if (!selectedRequestLoaded) return;

    final emdadgarInfoLoaded = await _getEmdadgarInfo();
    if (!emdadgarInfoLoaded) return;

    final lastEvaluationLoaded = await _getLastEvaluation();
    if (!lastEvaluationLoaded) return;

    final distanceLoaded = await _getDistanceToCustomer();
    if (!distanceLoaded) return;

    final serviceCategoriesLoaded = await _getServiceCategories();
    if (!serviceCategoriesLoaded) return;

    emit(HomeServiceEvaluationState.loaded(data: data));
  }

  bool get isInitialized {
    return data.selectedRequest != null &&
        data.lastEvaluationEntity != null &&
        data.distanceToCustomerEntity != null &&
        data.serviceCategories.isNotEmpty;
  }

  Future<bool> _getEmdadgarInfo() async {
    final request = data.selectedRequest;

    if (request == null || request.emdadgarId == null) {
      return true;
    }

    final result = await _getEmdadgarInfoUseCase(
      ServiceRequestParamEntity(
        serviceRequestId: request.id,
        serviceType: ServiceType.homeService.value,
      ),
    );

    bool isSuccess = false;

    result.whenOrNull(
      success: (response, failures, resultCode) {
        if (resultCode == 0) {
          emit(
            HomeServiceEvaluationState.loading(
              data: data.copyWith(
                emdadgarInfo: response,
              ),
            ),
          );

          isSuccess = true;
        } else {
          _emitFailure(_failuresToString(failures));
        }
      },
      failure: (error, msg) {
        _emitFailure(msg ?? 'خطای دریافت اطلاعات امدادگر');
      },
    );

    return isSuccess;
  }

  Future<bool> _getSelectedRequest() async {
    final result = await _fetchSelectedRequestItemUseCase();

    bool isSuccess = false;
    try {
      final request = await _fetchSelectedRequestItemUseCase.call();
      if (request is HomeServiceRequestEntity) {
        emit(
          HomeServiceEvaluationState.loading(
            data: data.copyWith(
              selectedRequest: result as HomeServiceRequestEntity,
            ),
          ),
        );
        isSuccess = true;
      }
      else {
        _emitFailure(_failuresToString('خطای دریافت اطلاعات درخواست'));
      }
    } catch (_) {
      _emitFailure('خطای دریافت اطلاعات درخواست');
    }

    return isSuccess;
  }



  Future<bool> _getServiceCategories() async {
    final result = await _getServiceCategoriesUseCase(
      const ServiceCategoryRequestEntity(
        serviceType: ServiceType.homeService,
      ),
    );

    bool isSuccess = false;

    result.whenOrNull(
      success: (categories, failures, resultCode) {
        if (resultCode == 0) {
          emit(
            HomeServiceEvaluationState.loading(
              data: data.copyWith(
                serviceCategories:
                categories.whereType<ServiceCategoryResponseEntity>().toList(),
                serviceList: const [],
                clearSelectedServiceCategory: true,
                clearSelectedService: true,
                clearPackageDraft: true,
              ),
            ),
          );

          isSuccess = true;
        } else {
          _emitFailure(_failuresToString(failures));
        }
      },
      failure: (error, msg) {
        _emitFailure(msg ?? 'خطای دریافت دسته‌بندی سرویس‌ها');
      },
    );

    return isSuccess;
  }

  Future<bool> _getLastEvaluation() async {
    final request = data.selectedRequest;
    if (request == null) return false;

    final result = await _getLastEvaluationHomeServiceUseCase(
      LastEvaluationRequestEntity(
        serviceRequestId: request.id,
        serviceType: ServiceType.homeService,
        emdadgarId: request.emdadgarId,
      ),
    );

    bool isSuccess = false;

    result.whenOrNull(
      success: (response, failures, resultCode) {
        if (resultCode == 0) {
          emit(
            HomeServiceEvaluationState.loading(
              data: data.copyWith(
                lastEvaluationEntity: response,
              ),
            ),
          );

          isSuccess = true;
        } else {
          _emitFailure(_failuresToString(failures));
        }
      },
      failure: (error, msg) {
        _emitFailure(msg ?? 'خطای دریافت آخرین ارزیابی');
      },
    );

    return isSuccess;
  }

  Future<bool> _getDistanceToCustomer() async {
    final request = data.selectedRequest;
    if (request == null) return false;

    final result = await _getDistanceToCustomerHomeServiceUseCase(
      DistanceToCustomerRequestEntity(
        serviceRequestId: request.id,
        serviceType: ServiceType.homeService,
        needCustomerDistance: true,
        needHaml: false,
      ),
    );

    bool isSuccess = false;

    result.whenOrNull(
      success: (response, failures, resultCode) {
        if (resultCode == 0) {
          emit(
            HomeServiceEvaluationState.loading(
              data: data.copyWith(
                distanceToCustomerEntity: response,
              ),
            ),
          );

          isSuccess = true;
        } else {
          _emitFailure(_failuresToString(failures));
        }
      },
      failure: (error, msg) {
        _emitFailure(msg ?? 'خطای دریافت مسافت تا مشتری');
      },
    );

    return isSuccess;
  }

  void openAddPackageSheet() {
    emit(
      HomeServiceEvaluationState.sheetLoaded(
        sheetType: HomeServiceEvaluationSheetType.package,
        data: data.copyWith(
          packageDraft: const HomeServicePackageSelectionViewModel(),
          clearEditingPackageLocalId: true,
          clearAddingPartPackageLocalId: true,
        ),
      ),
    );
  }

  void selectServiceCategory(ServiceCategoryResponseEntity category) {
    emit(
      HomeServiceEvaluationState.sheetLoaded(
        sheetType: HomeServiceEvaluationSheetType.package,
        data: data.copyWith(
          selectedServiceCategory: category,
          serviceList: const [],
          packageItems: const [],
          clearSelectedService: true,
          clearPackageDraft: true,
          clearPackageItems: true,
          clearPackageLabors: true,
          clearAvailablePartsForSelectedLabor: true,
        ),
      ),
    );
  }

  Future<void> searchServices(String query) async {
    final request = data.selectedRequest;
    final category = data.selectedServiceCategory;
    final searchText = query.trim();

    if (request == null || category == null) return;

    if (searchText.length < 3) {
      emit(
        HomeServiceEvaluationState.sheetLoaded(
          sheetType: HomeServiceEvaluationSheetType.package,
          data: data.copyWith(
            serviceList: const [],
            packageItems: const [],
            clearSelectedService: true,
            clearPackageDraft: true,
            clearPackageItems: true,
            clearPackageLabors: true,
            clearAvailablePartsForSelectedLabor: true,
          ),
        ),
      );
      return;
    }

    emit(
      HomeServiceEvaluationState.sheetLoading(
        sheetType: HomeServiceEvaluationSheetType.package,
        data: data.copyWith(
          serviceList: const [],
          packageItems: const [],
          clearSelectedService: true,
          clearPackageDraft: true,
          clearPackageItems: true,
          clearPackageLabors: true,
          clearAvailablePartsForSelectedLabor: true,
        ),
      ),
    );

    final result = await _getServicesUseCase(
      ServiceRequestEntity(
        serviceRequestId: request.id,
        serviceType: ServiceType.homeService,
        serviceCategoryId: category.id,
        kilometer: request.kilometer,
        planningId: request.planningId,
        defectId: null,
        nationalCode: request.nationalCode,
        carInfoGuid: request.carInfoGuid,
        serviceName: searchText,
        guarantyStartDate: request.garantyStartDate,
      ),
    );

    result.whenOrNull(
      success: (response, failures, resultCode) {
        if (resultCode == 0 && response != null) {
          emit(
            HomeServiceEvaluationState.sheetLoaded(
              sheetType: HomeServiceEvaluationSheetType.package,
              data: data.copyWith(
                serviceResponse: response,
                serviceList: response.serviceList ?? const [],
                packageItems: const [],
                clearSelectedService: true,
                clearPackageDraft: true,
                clearPackageItems: true,
                clearPackageLabors: true,
                clearAvailablePartsForSelectedLabor: true,
              ),
            ),
          );
        } else {
          _emitSheetFailure(
            sheetType: HomeServiceEvaluationSheetType.package,
            message: _failuresToString(failures),
          );
        }
      },
      failure: (error, msg) {
        _emitSheetFailure(
          sheetType: HomeServiceEvaluationSheetType.package,
          message: msg ?? 'خطای جستجوی سرویس',
        );
      },
    );
  }

  Future<void> selectService(EmdadServiceResultEntity service) async {
    final request = data.selectedRequest;
    final category = data.selectedServiceCategory;

    if (request == null || category == null) return;

    emit(
      HomeServiceEvaluationState.sheetLoading(
        sheetType: HomeServiceEvaluationSheetType.package,
        data: data.copyWith(
          selectedService: service,
          clearPackageDraft: true,
          clearPackageItems: true,
          clearPackageLabors: true,
          clearAvailablePartsForSelectedLabor: true,
        ),
      ),
    );

    final result = await _getHomeServicePackageUseCase(
      HomeServicePackageRequestEntity(
        serviceType: ServiceType.homeService.value,
        serviceName: service.serviceTitle,
        serviceCategoryId: category.id,
        nationalCode: request.nationalCode,
        kilometer: request.kilometer,
        carModelId: request.carModelId,
        carModelGuid: request.carInfoGuid,
        latitude: request.latitude,
        longitude: request.longitude,
        chassisNumber: request.chassisNumber,
        cityId: request.cityId,
        hasSubscription: request.isSubscription,
        serviceId: service.serviceId,
        planningId: request.planningId,
        mobileNumber: request.customerMobileNumber,
        serviceRequestId: request.id,
      ),
    );

    result.whenOrNull(
      success: (items, failures, resultCode) {
        if (resultCode == 0) {
          final packageItems =
          items.whereType<HomeServicePackageResponseEntity>().toList();

          emit(
            HomeServiceEvaluationState.sheetLoaded(
              sheetType: HomeServiceEvaluationSheetType.package,
              data: data.copyWith(
                selectedService: service,
                packageItems: _initializeMandatorySelections(packageItems),
              ),
            ),
          );
        } else {
          _emitSheetFailure(
            sheetType: HomeServiceEvaluationSheetType.package,
            message: _failuresToString(failures),
          );
        }
      },
      failure: (error, msg) {
        _emitSheetFailure(
          sheetType: HomeServiceEvaluationSheetType.package,
          message: msg ?? 'خطای دریافت اجرت و قطعه',
        );
      },
    );
  }

  List<HomeServicePackageResponseEntity> _initializeMandatorySelections(
      List<HomeServicePackageResponseEntity> items,) {
    return items.map((item) {
      if (item.partGroups == null || item.partGroups!.isEmpty) {
        return item.copyWith(
          isSelected: item.isMandatory == true || item.isSelected,
        );
      }

      final updatedGroups = item.partGroups!.map((group) {
        final parts = group.parts ?? const <HomeServicePartEntity>[];

        if (parts.isEmpty) return group;

        final hasMandatoryPart = parts.any((part) => part.isMandatory == true);

        if (!hasMandatoryPart) return group;

        return group.copyWith(
          parts: parts.map((part) {
            return part.copyWith(
              isSelected: part.isMandatory == true,
            );
          }).toList(),
        );
      }).toList();

      return item.copyWith(
        isSelected: item.isMandatory == true || item.isSelected,
        partGroups: updatedGroups,
      );
    }).toList();
  }

  void togglePackageLabor({
    required int laborId,
    required bool selected,
  }) {
    final updatedItems = data.packageItems.map((item) {
      if (item.laborId != laborId) return item;
      if (item.isMandatory == true) return item;
      if ((item.partGroups ?? []).isNotEmpty) return item;

      return item.copyWith(isSelected: selected);
    }).toList();

    emit(
      HomeServiceEvaluationState.sheetLoaded(
        sheetType: HomeServiceEvaluationSheetType.package,
        data: data.copyWith(packageItems: updatedItems),
      ),
    );
  }

  void selectPackagePart({
    required int laborId,
    required int partGroupId,
    required int serial,
  }) {
    final updatedItems = data.packageItems.map((item) {
      if (item.laborId != laborId) return item;

      final updatedGroups = item.partGroups?.map((group) {
        if (group.partGroupId != partGroupId) return group;

        final parts = group.parts ?? const <HomeServicePartEntity>[];
        final hasMandatoryPart = parts.any((part) => part.isMandatory == true);

        if (hasMandatoryPart) {
          return group.copyWith(
            parts: parts.map((part) {
              return part.copyWith(
                isSelected: part.isMandatory == true,
              );
            }).toList(),
          );
        }

        return group.copyWith(
          parts: parts.map((part) {
            return part.copyWith(
              isSelected: part.serial == serial,
            );
          }).toList(),
        );
      }).toList();

      return item.copyWith(
        isSelected: true,
        partGroups: updatedGroups,
      );
    }).toList();

    emit(
      HomeServiceEvaluationState.sheetLoaded(
        sheetType: HomeServiceEvaluationSheetType.package,
        data: data.copyWith(packageItems: updatedItems),
      ),
    );
  }

  bool get canConfirmPackageSelection {
    final selectedService = data.selectedService;
    if (selectedService == null) return false;

    return data.packageItems.any(_isPackageItemSelected);
  }

  void confirmPackageSelection() {
    final selectedService = data.selectedService;
    if (selectedService == null || !canConfirmPackageSelection) return;

    final editingLocalId = data.editingPackageLocalId;

    final selectedPackage = SelectedHomeServicePackageViewModel(
      localId: editingLocalId ??
          DateTime
              .now()
              .microsecondsSinceEpoch
              .toString(),
      packageId: selectedService.serviceId ?? 0,
      packageTitle: selectedService.serviceTitle ?? '',
      categoryId: data.selectedServiceCategory?.id,
      categoryTitle: data.selectedServiceCategory?.title,
      labors: _mapSelectedPackageItemsToLabors(data.packageItems),
    );

    final updatedPackages = editingLocalId == null
        ? [...data.selectedPackages, selectedPackage]
        : data.selectedPackages.map((item) {
      if (item.localId != editingLocalId) return item;
      return selectedPackage;
    }).toList();

    emit(
      HomeServiceEvaluationState.loaded(
        data: data.copyWith(
          selectedPackages: updatedPackages,
          packageItems: const [],
          clearPackageItems: true,
          clearPackageDraft: true,
          clearSelectedService: true,
          clearEditingPackageLocalId: true,
          clearAddingPartPackageLocalId: true,
        ),
      ),
    );
  }

  List<SelectedHomeServiceLaborViewModel> _mapSelectedPackageItemsToLabors(
      List<HomeServicePackageResponseEntity> items,) {
    return items
        .where(_isPackageItemSelected)
        .map((item) {
      final selectedParts = <SelectedHomeServicePartViewModel>[];

      for (final group in item.partGroups ??
          const <HomeServicePartGroupEntity>[]) {
        for (final part in group.parts ?? const <HomeServicePartEntity>[]) {
          if (part.isMandatory == true || part.isSelected == true) {
            selectedParts.add(
              SelectedHomeServicePartViewModel(
                id: part.serial ?? 0,
                title: part.partTitle ?? '',
                isRequired: part.isMandatory == true,
              ),
            );
          }
        }
      }

      return SelectedHomeServiceLaborViewModel(
        id: item.laborId ?? 0,
        title: item.laborTitle ?? item.laborDesc ?? '',
        isRequired: item.isMandatory == true,
        parts: selectedParts,
      );
    })
        .toList();
  }

  bool _isPackageItemSelected(HomeServicePackageResponseEntity item) {
    if (item.isMandatory == true || item.isSelected == true) {
      return true;
    }

    return item.partGroups?.any((group) {
      return group.parts?.any((part) {
        return part.isMandatory == true || part.isSelected == true;
      }) ??
          false;
    }) ??
        false;
  }

  Future<void> getLaborParts({
    required int laborId,
  }) async {
    final selectedPackage = data.selectedService;
    final request = data.selectedRequest;
    final labor = _findLaborById(laborId);

    if (selectedPackage == null || labor == null) return;

    emit(
      HomeServiceEvaluationState.sheetLoading(
        sheetType: HomeServiceEvaluationSheetType.packagePart,
        data: data,
      ),
    );

    final result = await _getPartUseCase(
      PartRequestEntity(
        serviceRequestId: request?.id,
        serviceType: ServiceType.homeService,
        emdadServiceId: selectedPackage.serviceId,
        emdadProductId: selectedPackage.productId,
        workOrderCode: selectedPackage.workOrderCode,
        searchText: null,
        hasSubscription: selectedPackage.hasSubscription,
        hasGaranty: request?.isGuaranty,
        laborId: labor.id,
        laborGroupId: labor.laborGroupId,
        kilometer: request?.kilometer,
        guarantyStartDate: request?.garantyStartDate,
        carModelId: request?.carModelId,
        carTipId: request?.garantyCarTipId,
      ),
    );

    result.whenOrNull(
      success: (parts, failures, resultCode) {
        if (resultCode == 0) {
          final validParts = parts.whereType<PartResponseEntity>().toList();

          setLaborParts(
            laborId: laborId,
            parts: validParts,
          );
        } else {
          _emitSheetFailure(
            sheetType: HomeServiceEvaluationSheetType.packagePart,
            message: _failuresToString(failures),
          );
        }
      },
      failure: (error, msg) {
        _emitSheetFailure(
          sheetType: HomeServiceEvaluationSheetType.packagePart,
          message: msg ?? 'خطای دریافت قطعات',
        );
      },
    );
  }

  void setLaborParts({
    required int laborId,
    required List<PartResponseEntity> parts,
  }) {
    final draft = data.packageDraft;
    if (draft == null) return;

    final mappedParts =
    HomeServiceEvaluationSelectionMapper.partsToSelection(parts);

    final updatedLabors = draft.labors.map((labor) {
      if (labor.id != laborId) return labor;

      return labor.copyWith(
        parts: mappedParts,
        isSelected: labor.isRequired,
      );
    }).toList();

    emit(
      HomeServiceEvaluationState.sheetLoaded(
        sheetType: HomeServiceEvaluationSheetType.package,
        data: data.copyWith(
          availablePartsForSelectedLabor: parts,
          packageDraft: draft.copyWith(labors: updatedLabors),
        ),
      ),
    );
  }

  void openEditPackageSheet(String localId) {
    final selectedPackage = _findSelectedPackageByLocalId(localId);

    if (selectedPackage == null) return;

    emit(
      HomeServiceEvaluationState.sheetLoaded(
        sheetType: HomeServiceEvaluationSheetType.package,
        data: data.copyWith(
          editingPackageLocalId: localId,
          packageDraft: HomeServicePackageSelectionViewModel.fromSelectedPackage(
            selectedPackage,
          ),
        ),
      ),
    );
  }

  void removeSelectedPackage(String localId) {
    emit(
      HomeServiceEvaluationState.loaded(
        data: data.copyWith(
          selectedPackages: data.selectedPackages
              .where((item) => item.localId != localId)
              .toList(),
        ),
      ),
    );
  }

  void openAddPartSheet(String packageLocalId) {
    emit(
      HomeServiceEvaluationState.sheetLoaded(
        sheetType: HomeServiceEvaluationSheetType.packagePart,
        data: data.copyWith(
          addingPartPackageLocalId: packageLocalId,
        ),
      ),
    );
  }

  void toggleLabor({
    required int laborId,
    required bool selected,
  }) {
    final draft = data.packageDraft;
    if (draft == null) return;

    final updatedLabors = draft.labors.map((labor) {
      if (labor.id != laborId) return labor;
      if (labor.isRequired) return labor;

      return labor.copyWith(isSelected: selected);
    }).toList();

    emit(
      HomeServiceEvaluationState.sheetLoaded(
        sheetType: HomeServiceEvaluationSheetType.package,
        data: data.copyWith(
          packageDraft: draft.copyWith(labors: updatedLabors),
        ),
      ),
    );
  }

  void togglePart({
    required int laborId,
    required int partId,
    required bool selected,
  }) {
    final draft = data.packageDraft;
    if (draft == null) return;

    final updatedLabors = draft.labors.map((labor) {
      if (labor.id != laborId) return labor;

      final updatedParts = labor.parts.map((part) {
        if (part.id != partId) return part;
        if (part.isRequired) return part;

        return part.copyWith(isSelected: selected);
      }).toList();

      final hasSelectedPart = updatedParts.any((part) => part.isSelected);

      return labor.copyWith(
        parts: updatedParts,
        isSelected: labor.isRequired || hasSelectedPart,
      );
    }).toList();

    emit(
      HomeServiceEvaluationState.sheetLoaded(
        sheetType: HomeServiceEvaluationSheetType.package,
        data: data.copyWith(
          packageDraft: draft.copyWith(labors: updatedLabors),
        ),
      ),
    );
  }

  void confirmPackageDraft() {
    final draft = data.packageDraft;
    if (draft == null || draft.packageId == null) return;

    final editingLocalId = data.editingPackageLocalId;

    final selectedPackage = SelectedHomeServicePackageViewModel.fromDraft(
      draft,
      localId: editingLocalId,
    );

    final updatedPackages = editingLocalId == null
        ? [...data.selectedPackages, selectedPackage]
        : data.selectedPackages.map((item) {
      if (item.localId != editingLocalId) return item;
      return selectedPackage;
    }).toList();

    emit(
      HomeServiceEvaluationState.loaded(
        data: data.copyWith(
          selectedPackages: updatedPackages,
          clearPackageDraft: true,
          clearEditingPackageLocalId: true,
          clearAddingPartPackageLocalId: true,
        ),
      ),
    );
  }

  void openExtraServiceSheet() {
    emit(
      HomeServiceEvaluationState.sheetLoaded(
        sheetType: HomeServiceEvaluationSheetType.extraService,
        data: data,
      ),
    );
  }

  void addExtraService(SelectedExtraServiceViewModel item) {
    emit(
      HomeServiceEvaluationState.loaded(
        data: data.copyWith(
          selectedExtraServices: [
            ...data.selectedExtraServices,
            item,
          ],
        ),
      ),
    );
  }

  void removeExtraService(String localId) {
    emit(
      HomeServiceEvaluationState.loaded(
        data: data.copyWith(
          selectedExtraServices: data.selectedExtraServices
              .where((item) => item.localId != localId)
              .toList(),
        ),
      ),
    );
  }

  Future<void> submitEvaluation() async {
    emit(HomeServiceEvaluationState.submitLoading(data: data));

    // TODO:
    // بعد از کامل شدن UI و فرم، باید builder بسازیم که از:
    // data.selectedRequest
    // data.lastEvaluationEntity
    // data.distanceToCustomerEntity
    // data.selectedPackages
    // data.selectedExtraServices
    // خروجی LastEvaluationEntity بسازد.
    //
    // final payload = HomeServiceEvaluationSubmitBuilder.build(data);
    // final result = await _postEvaluationUseCase(payload);

    emit(
      HomeServiceEvaluationState.submitSuccess(
        data: data,
        message: const BottomSheetMessageModel(
          title: 'موفق',
          message: 'ارزیابی با موفقیت ثبت شد',
        ),
      ),
    );
  }

  void _emitFailure(String message) {
    _errorMessage = message;

    emit(
      HomeServiceEvaluationState.failure(
        data: data,
        message: BottomSheetMessageModel(
          title: 'خطا',
          message: message,
        ),
      ),
    );
  }

  void _emitSheetFailure({
    required HomeServiceEvaluationSheetType sheetType,
    required String message,
  }) {
    _errorMessage = message;

    emit(
      HomeServiceEvaluationState.sheetFailure(
        sheetType: sheetType,
        data: data,
        message: BottomSheetMessageModel(
          title: 'خطا',
          message: message,
        ),
      ),
    );
  }

  String _failuresToString(dynamic failures) {
    if (failures == null) return 'خطای غیر منتظره';

    if (failures is Iterable) {
      return failures.map((item) => item.toString()).join('\n');
    }

    return failures.toString();
  }

  LaborResponseEntity? _findLaborById(int laborId) {
    for (final item in data.packageLabors) {
      if (item.id == laborId) {
        return item;
      }
    }

    return null;
  }

  SelectedHomeServicePackageViewModel? _findSelectedPackageByLocalId(
      String localId,) {
    for (final item in data.selectedPackages) {
      if (item.localId == localId) {
        return item;
      }
    }

    return null;
  }
}