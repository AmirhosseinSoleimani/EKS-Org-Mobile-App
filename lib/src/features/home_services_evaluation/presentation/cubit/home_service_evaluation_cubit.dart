import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/active_service_request_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/distance_to_customer_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/labor_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/labor_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/last_evaluation_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_active_service_request_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_distance_to_customer_home_service_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_labor_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_last_evaluation_home_service_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_part_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_services_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/post_evaluation_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/cubit/home_service_evaluation_data.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/cubit/home_service_evaluation_sheet_type.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/cubit/home_service_evaluation_state.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/mappers/home_service_evaluation_selection_mapper.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/view_models/home_service_package_selection_view_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/view_models/selected_extra_service_view_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/view_models/selected_home_service_package_view_model.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
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
  final GetActiveServiceRequestUseCase _getActiveServiceRequestUseCase;

  HomeServiceEvaluationCubit(this._getServicesUseCase,
      this._getLaborUseCase,
      this._getPartUseCase,
      this._getLastEvaluationHomeServiceUseCase,
      this._getDistanceToCustomerHomeServiceUseCase,
      this._getEmdadgarInfoUseCase,
      this._postEvaluationUseCase,
      this._getActiveServiceRequestUseCase,)
      : super(const HomeServiceEvaluationState.idle());

  String? _errorMessage;

  HomeServiceEvaluationData get data => state.data;

  String? get errorMessage => _errorMessage;

  Future<void> init() async {
    emit(
      HomeServiceEvaluationState.loading(
        data: data.copyWith(
          clearPackageDraft: true,
          clearEditingPackageLocalId: true,
          clearAddingPartPackageLocalId: true,
          clearSelectedServiceCategory: true,
          clearSelectedPackage: true,
          clearServiceResponse: true,
          clearPackageLabors: true,
          clearAvailablePartsForSelectedLabor: true,
          clearLastEvaluationEntity: true,
          clearDistanceToCustomerEntity: true,
        ),
      ),
    );

    final selectedRequestLoaded = await _getSelectedRequest();
    if (!selectedRequestLoaded) return;

    final emdadgarInfoLoaded = await _getEmdadgarInfo();
    if (!emdadgarInfoLoaded) return;

    final lastEvaluationLoaded = await _getLastEvaluation();
    if (!lastEvaluationLoaded) return;

    final distanceLoaded = await _getDistanceToCustomer();
    if (!distanceLoaded) return;

    final servicesLoaded = await _getServices();
    if (!servicesLoaded) return;

    emit(HomeServiceEvaluationState.loaded(data: data));
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
    final result = await _getActiveServiceRequestUseCase();

    bool isSuccess = false;

    result.whenOrNull(
      success: (response, failures, resultCode) {
        if (resultCode == 0 && response != null) {
          final selectedRequest = _mapActiveRequestToHomeServiceRequest(
            response,
          );

          emit(
            HomeServiceEvaluationState.loading(
              data: data.copyWith(
                selectedRequest: selectedRequest,
              ),
            ),
          );

          isSuccess = true;
        } else {
          _emitFailure(_failuresToString(failures));
        }
      },
      failure: (error, msg) {
        _emitFailure(msg ?? 'خطای دریافت اطلاعات درخواست');
      },
    );

    return isSuccess;
  }

  HomeServiceRequestEntity _mapActiveRequestToHomeServiceRequest(
      ActiveServiceRequestResponseEntity entity,) {
    return HomeServiceRequestEntity(
      id: entity.id,
      trackCode: entity.trackCode,
      firstName: entity.firstName,
      lastName: entity.lastName,
      latitude: entity.latitude,
      longitude: entity.longitude,
      aidAddress: entity.aidAddress,
      carName: entity.carName,
      licensePlate: entity.licensePlate,
      requestStatus: entity.requestStatus,
      requestStatusTitle: entity.requestStatusTitle,
      requestDateTime: entity.insertDateTime,
      requestDateTimeJalali: entity.requestDateTimeJalali,
      insertDateTime: entity.insertDateTime,
      insertDateTimeJalali: entity.insertDateTimeJalali,
      customerMobileNumber: entity.customerMobileNumber,
      description: entity.description,
      carColorTitle: entity.carColorTitle,
      carEngineNumber: entity.carEngineNumber,
      chassisNumber: entity.chassisNumber ?? entity.vin,
      kilometer: entity.kilometer,
      nationalCode: entity.nationalNumber,
      dispatcher: entity.etmamRequestAuthor,
      emdadgarName: entity.emdadgarFullName,
      emFullName: entity.emdadgarFullName,
      emMobileNumber1: entity.emdadgarMobileNumber,
      emVehicleTypeTitle: entity.emdadgarVehicleType,
      emVehicleType: int.tryParse(entity.emdadgarVehicleType ?? '0'),
      isGuaranty: entity.guaranty,
      isSubscription: entity.subscription,
      serviceType: ServiceType.homeService,
      assignDate: entity.assignDate,
      planningId: entity.planningId,
      carInfoGuid: entity.carGuid,
      carModelId: entity.carModelId,
      emdadgarId: entity.emdadgarId,
      invoiceDocumentGuid: entity.invoiceDocumentGuid,
      vip: entity.vip,
      /*  vipConditionId: entity.vipConditionId,*/
      vipConditionTitle: entity.vipConditionTitle,
      emdadServiceCategoryTitle: entity.serviceCategoryTitle,
      emdadProductTitle: entity.serviceTitles?.isNotEmpty == true
          ? entity.serviceTitles!.join('، ')
          : entity.serviceCategoryGivenTitle,
    );
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

  Future<bool> _getServices() async {
    final request = data.selectedRequest;
    if (request == null) return false;

    final result = await _getServicesUseCase(
      ServiceRequestEntity(
        serviceRequestId: request.id,
        serviceType: ServiceType.homeService,
        serviceCategoryId: null,
        kilometer: request.kilometer,
        planningId: request.planningId,
        defectId: null,
        nationalCode: request.nationalCode,
        carInfoGuid: request.carInfoGuid,
        vipConditionId: null,
        guarantyStartDate: request.garantyStartDate,
      ),
    );

    bool isSuccess = false;

    result.whenOrNull(
      success: (response, failures, resultCode) {
        if (resultCode == 0 && response != null) {
          final categories =
          HomeServiceEvaluationSelectionMapper.extractCategories(response);

          emit(
            HomeServiceEvaluationState.loading(
              data: data.copyWith(
                serviceResponse: response,
                serviceCategories: categories,
                packages: const [],
                clearSelectedServiceCategory: true,
                clearSelectedPackage: true,
                clearPackageDraft: true,
                clearPackageLabors: true,
                clearAvailablePartsForSelectedLabor: true,
              ),
            ),
          );

          isSuccess = true;
        } else {
          _emitFailure(_failuresToString(failures));
        }
      },
      failure: (error, msg) {
        _emitFailure(msg ?? 'خطای دریافت سرویس‌ها');
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

  void selectServiceCategory(EmdadServiceResultEntity category) {
    final packages =
    HomeServiceEvaluationSelectionMapper.extractPackagesByCategory(
      serviceResponse: data.serviceResponse,
      categoryId: category.serviceCategoryId,
    );

    emit(
      HomeServiceEvaluationState.sheetLoaded(
        sheetType: HomeServiceEvaluationSheetType.package,
        data: data.copyWith(
          selectedServiceCategory: category,
          packages: packages,
          clearSelectedPackage: true,
          clearPackageDraft: true,
          clearPackageLabors: true,
          clearAvailablePartsForSelectedLabor: true,
        ),
      ),
    );
  }

  Future<void> selectPackage(EmdadServiceResultEntity package) async {
    emit(
      HomeServiceEvaluationState.sheetLoading(
        sheetType: HomeServiceEvaluationSheetType.package,
        data: data.copyWith(
          selectedPackage: package,
          clearPackageDraft: true,
          clearPackageLabors: true,
          clearAvailablePartsForSelectedLabor: true,
        ),
      ),
    );

    final request = data.selectedRequest;

    final result = await _getLaborUseCase(
      LaborRequestEntity(
        serviceRequestId: request?.id,
        serviceType: ServiceType.homeService,
        emdadServiceId: package.serviceId,
        emdadProductId: package.productId,
        workOrderCode: package.workOrderCode,
        searchText: null,
        hasSubscription: package.hasSubscription,
        hasGaranty: request?.isGuaranty,
        kilometer: request?.kilometer,
        guarantyStartDate: request?.garantyStartDate,
        carModelId: request?.carModelId,
        carTipId: request?.garantyCarTipId,
      ),
    );

    result.whenOrNull(
      success: (labors, failures, resultCode) {
        if (resultCode == 0) {
          final validLabors = labors.whereType<LaborResponseEntity>().toList();

          final mappedLabors = validLabors
              .map(
                (labor) =>
                HomeServiceEvaluationSelectionMapper.laborToSelection(
                  labor: labor,
                ),
          )
              .toList();

          final packageDraft =
          HomeServiceEvaluationSelectionMapper.packageToSelection(
            package: package,
            labors: mappedLabors,
          );

          emit(
            HomeServiceEvaluationState.sheetLoaded(
              sheetType: HomeServiceEvaluationSheetType.package,
              data: data.copyWith(
                selectedPackage: package,
                packageLabors: validLabors,
                packageDraft: packageDraft,
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
          message: msg ?? 'خطای دریافت اجرت‌ها',
        );
      },
    );
  }

  Future<void> getLaborParts({
    required int laborId,
  }) async {
    final selectedPackage = data.selectedPackage;
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