import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/distance_to_customer_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/home_service_package_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/labor_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/last_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_category_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/view_models/home_service_package_selection_view_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/view_models/selected_extra_service_view_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/view_models/selected_home_service_package_view_model.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';

import '../../domain/entity/service_response_entity.dart';

class HomeServiceEvaluationData {
  final EvaluationResponseEntity? lastEvaluationEntity;
  final DistanceToCustomerResponseEntity? distanceToCustomerEntity;
  final HomeServiceRequestEntity? selectedRequest;
  final EmdadgarInfoEntity? emdadgarInfo;

  final HomeServicePackageSelectionViewModel? packageDraft;

  final String? editingPackageLocalId;
  final String? addingPartPackageLocalId;

  final List<SelectedHomeServicePackageViewModel> selectedPackages;
  final List<SelectedExtraServiceViewModel> selectedExtraServices;

  final ServiceResponseEntity? serviceResponse;

  final List<ServiceCategoryResponseEntity> serviceCategories;
  final ServiceCategoryResponseEntity? selectedServiceCategory;

  final List<EmdadServiceResultEntity> serviceList;
  final EmdadServiceResultEntity? selectedService;

  final List<LaborResponseEntity> packageLabors;
  final List<PartResponseEntity> availablePartsForSelectedLabor;
  final List<HomeServicePackageResponseEntity> packageItems;

  const HomeServiceEvaluationData({
    this.selectedRequest,
    this.emdadgarInfo,
    this.packageDraft,
    this.editingPackageLocalId,
    this.addingPartPackageLocalId,
    this.selectedPackages = const [],
    this.selectedExtraServices = const [],
    this.selectedServiceCategory,
    this.availablePartsForSelectedLabor = const [],
    this.packageLabors = const [],
    this.serviceList = const [],
    this.selectedService,
    this.serviceCategories = const [],
    this.serviceResponse,
    this.lastEvaluationEntity,
    this.distanceToCustomerEntity,
    this.packageItems = const [],
  });

  HomeServiceEvaluationData copyWith({
    HomeServiceRequestEntity? selectedRequest,
    EmdadgarInfoEntity? emdadgarInfo,
    HomeServicePackageSelectionViewModel? packageDraft,
    String? editingPackageLocalId,
    String? addingPartPackageLocalId,
    List<SelectedHomeServicePackageViewModel>? selectedPackages,
    List<SelectedExtraServiceViewModel>? selectedExtraServices,
    ServiceResponseEntity? serviceResponse,
    List<ServiceCategoryResponseEntity>? serviceCategories,
    ServiceCategoryResponseEntity? selectedServiceCategory,
    List<EmdadServiceResultEntity>? serviceList,
    EmdadServiceResultEntity? selectedService,
    List<LaborResponseEntity>? packageLabors,
    List<PartResponseEntity>? availablePartsForSelectedLabor,
    List<HomeServicePackageResponseEntity>? packageItems,
    bool clearPackageItems = false,
    bool clearPackageDraft = false,
    bool clearEditingPackageLocalId = false,
    bool clearAddingPartPackageLocalId = false,
    bool clearSelectedServiceCategory = false,
    bool clearSelectedService = false,
    bool clearServiceResponse = false,
    bool clearPackageLabors = false,
    bool clearAvailablePartsForSelectedLabor = false,
    EvaluationResponseEntity? lastEvaluationEntity,
    DistanceToCustomerResponseEntity? distanceToCustomerEntity,
    bool clearLastEvaluationEntity = false,
    bool clearDistanceToCustomerEntity = false,
  }) {
    return HomeServiceEvaluationData(
      selectedRequest: selectedRequest ?? this.selectedRequest,
      emdadgarInfo: emdadgarInfo ?? this.emdadgarInfo,

      packageDraft: clearPackageDraft
          ? null
          : packageDraft ?? this.packageDraft,

      editingPackageLocalId: clearEditingPackageLocalId
          ? null
          : editingPackageLocalId ?? this.editingPackageLocalId,

      addingPartPackageLocalId: clearAddingPartPackageLocalId
          ? null
          : addingPartPackageLocalId ?? this.addingPartPackageLocalId,

      selectedPackages: selectedPackages ?? this.selectedPackages,
      selectedExtraServices:
          selectedExtraServices ?? this.selectedExtraServices,

      serviceResponse: clearServiceResponse
          ? null
          : serviceResponse ?? this.serviceResponse,

      serviceCategories: serviceCategories ?? this.serviceCategories,

      selectedServiceCategory: clearSelectedServiceCategory
          ? null
          : selectedServiceCategory ?? this.selectedServiceCategory,

      serviceList: serviceList ?? this.serviceList,

      selectedService: clearSelectedService
          ? null
          : selectedService ?? this.selectedService,

      packageLabors: clearPackageLabors
          ? const []
          : packageLabors ?? this.packageLabors,

      availablePartsForSelectedLabor: clearAvailablePartsForSelectedLabor
          ? const []
          : availablePartsForSelectedLabor ??
                this.availablePartsForSelectedLabor,
      lastEvaluationEntity: clearLastEvaluationEntity
          ? null
          : lastEvaluationEntity ?? this.lastEvaluationEntity,

      distanceToCustomerEntity: clearDistanceToCustomerEntity
          ? null
          : distanceToCustomerEntity ?? this.distanceToCustomerEntity,
      packageItems: clearPackageItems
          ? const []
          : packageItems ?? this.packageItems,
    );
  }
}
