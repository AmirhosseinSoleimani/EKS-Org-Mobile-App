import 'package:eks_sana_plus_org/src/common/utils/extensions/iterable_ext.dart';
import 'package:eks_sana_plus_org/src/core/uikit/dialog/dialog_data_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/active_service_request_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/cost_center_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_labor_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/last_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_active_service_request_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_last_evaluation_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/cubit/home_service_evaluation_packages_state.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/cubit/home_service_evaluation_second_step_cubit.dart';
import 'package:eks_sana_plus_org/src/features/insert_home_service/domain/entity/insert_home_service_category_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/insert_home_service/domain/entity/insert_home_service_labor_entity.dart';
import 'package:eks_sana_plus_org/src/features/insert_home_service/domain/entity/insert_home_service_package_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/insert_home_service/domain/entity/insert_home_service_package_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/insert_home_service/domain/entity/insert_home_service_part_entity.dart';
import 'package:eks_sana_plus_org/src/features/insert_home_service/domain/entity/insert_home_service_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/insert_home_service/domain/entity/insert_home_service_service_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/insert_home_service/domain/use_case/fetch_insert_home_service_category_use_case.dart';
import 'package:eks_sana_plus_org/src/features/insert_home_service/domain/use_case/fetch_insert_home_service_package_use_case.dart';
import 'package:eks_sana_plus_org/src/features/insert_home_service/domain/use_case/fetch_insert_home_service_service_use_case.dart';
import 'package:eks_sana_plus_org/src/network/network_state/error/network_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';



@injectable
class HomeServiceEvaluationPackagesCubit extends Cubit<HomeServiceEvaluationPackagesState> {
  final FetchInsertHomeServiceCategoryUseCase _fetchInsertHomeServiceCategoryUseCase;
  final FetchInsertHomeServicePackageUseCase _fetchInsertHomeServicePackageUseCase;
  final FetchInsertHomeServiceServiceUseCase _fetchInsertHomeServiceServiceUseCase;
  final GetActiveServiceRequestUseCase _getActiveServiceRequestUseCase;
  final GetLastEvaluationUseCase _getLastEvaluationUseCase;


  HomeServiceEvaluationPackagesCubit(
      this._fetchInsertHomeServicePackageUseCase,
      this._fetchInsertHomeServiceServiceUseCase,
      this._fetchInsertHomeServiceCategoryUseCase,
      this._getActiveServiceRequestUseCase,
      this._getLastEvaluationUseCase,
      ) : super(const HomeServiceEvaluationPackagesState.idle());



  /// Behavior Subject
  final _homeServiceCategoryListSubject = BehaviorSubject<List<InsertHomeServiceCategoryResponseEntity?>>.seeded([]);
  final _homeServicePackageListSubject = BehaviorSubject<List<InsertHomeServicePackageResponseEntity?>>.seeded([]);
  final BehaviorSubject<ActiveServiceRequestResponseEntity?> _activeServiceRequestSubject = BehaviorSubject<ActiveServiceRequestResponseEntity?>();
  final BehaviorSubject<LastEvaluationEntity?> _lastEvaluationSubject = BehaviorSubject<LastEvaluationEntity?>();


  /// Stream
  Stream<List<InsertHomeServiceCategoryResponseEntity?>> get homeServiceCategoryListStream => _homeServiceCategoryListSubject.stream;
  Stream<List<InsertHomeServicePackageResponseEntity?>> get homeServicePackageListStream => _homeServicePackageListSubject.stream;
  Stream<ActiveServiceRequestResponseEntity?> get activeServiceRequestStream => _activeServiceRequestSubject.stream;
  Stream<LastEvaluationEntity?> get lastEvaluationStream => _lastEvaluationSubject.stream;

  /// Notifier
  final ValueNotifier<int?> expandedIdNotifier = ValueNotifier(null);
  final ValueNotifier<int?> packageExpandedIdNotifier = ValueNotifier(null);



  Future<void> init() async {
    emit(const HomeServiceEvaluationPackagesState.loading());
    final activeServiceRequestResult = await _getActiveServiceRequest();
    final getLastEvaluationResult = await _getLastEvaluation();
    final getHomeServiceCategoriesResult = await _getHomeServiceCategories();
    if(getLastEvaluationResult && activeServiceRequestResult && getHomeServiceCategoriesResult) {
      emit(const HomeServiceEvaluationPackagesState.success());
    }
  }

  @override
  Future<void> close() async {
    await _homeServiceCategoryListSubject.close();
    await _homeServicePackageListSubject.close();
    await _activeServiceRequestSubject.close();
    await _lastEvaluationSubject.close();
    return super.close();
  }

  Future<bool> _getActiveServiceRequest() async {
    bool resultValue = false;
    final result = await _getActiveServiceRequestUseCase.call();
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          _activeServiceRequestSubject.value = data;
          resultValue = true;
        } else {
          emit(
            HomeServiceEvaluationPackagesState.error(
              dialogDataModel: DialogDataModel(title: '', description: failures?.listToString() ?? ''),
            ),
          );
          resultValue = false;
        }
      },
      failure: (NetworkExceptions error, msg) {
        emit(
          HomeServiceEvaluationPackagesState.error(dialogDataModel: DialogDataModel(title: '', description: msg ?? ''),),
        );
        resultValue = false;
      },
    );
    return resultValue;
  }

  Future<bool> _getLastEvaluation() async {
    bool resultValue = false;
    final result = await _getLastEvaluationUseCase.call();
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          _lastEvaluationSubject.add(data);
          resultValue = true;
        } else {
          emit(
            HomeServiceEvaluationPackagesState.error(
              dialogDataModel: DialogDataModel(
                  title: '', description: failures?.listToString() ?? ''),
            ),
          );
          resultValue = false;
        }
      },
      failure: (NetworkExceptions error, msg) {
        emit(
          HomeServiceEvaluationPackagesState.error(
            dialogDataModel: DialogDataModel(title: '', description: msg ?? ''),
          ),
        );
        resultValue = false;
      },
    );
    return resultValue;
  }

  Future<bool> _getHomeServiceCategories() async {
    bool resultValue = false;
    final result = await _fetchInsertHomeServiceCategoryUseCase();
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          _homeServiceCategoryListSubject.valueOrNull?.addAll(data ?? []);
          resultValue = true;
        } else {
          emit(
            HomeServiceEvaluationPackagesState.error(
              dialogDataModel: DialogDataModel(
                  title: '',
                  description: failures?.listToString() ?? "خطای غیر منتظره"),
            ),
          );
          resultValue = false;
        }
      },
      failure: (NetworkExceptions error, msg) {
        emit(
          HomeServiceEvaluationPackagesState.error(
            dialogDataModel: DialogDataModel(
                title: '', description: msg ?? "خطای غیر منتظره"),
          ),
        );
        resultValue = false;
      },
    );
    return resultValue;
  }

  Future<void> fetchHomeServiceServices({int? id}) async {
    emit(HomeServiceEvaluationPackagesState.servicesLoading(id: id ?? 0));
    final currentList = _homeServiceCategoryListSubject.valueOrNull;
    if (currentList == null) return;
    final index = currentList.indexWhere((e) => e?.categoryId == id);
    if (index == -1) return;
    final oldItem = currentList[index];
    if (oldItem == null) return;

    if(oldItem.homeServices?.isNotEmpty ?? false) {
      emit(HomeServiceEvaluationPackagesState.servicesSuccess(id: id ?? 0));
      return;
    }
    final result = await _fetchInsertHomeServiceServiceUseCase.call(
      InsertHomeServiceServiceRequestEntity(
        serviceType: 2,
        serviceCategoryId: id,
        serviceRequestId: _activeServiceRequestSubject.valueOrNull?.id,
        kilometer: _lastEvaluationSubject.valueOrNull?.customerKilometer,
        carModelId: _activeServiceRequestSubject.valueOrNull?.carModelId,
        carModelGuid: _activeServiceRequestSubject.valueOrNull?.carGuid,
      ),
    );
    result.whenOrNull(
      success: (data, failures, resultCode) {
        if (resultCode == 0) {
          final updatedItem = oldItem.copyWith(
            homeServices: [
              ...?oldItem.homeServices,
              ...?data?.services,
            ],
          );
          final updatedList = List<InsertHomeServiceCategoryResponseEntity?>.from(currentList);
          updatedList[index] = updatedItem;
          _homeServiceCategoryListSubject.add(updatedList);
          emit(HomeServiceEvaluationPackagesState.servicesSuccess(id: id ?? 0));
        } else {
          emit(HomeServiceEvaluationPackagesState.notice(
            dialogDataModel: DialogDataModel(title: '',
                description: failures?.listToString() ?? "خطای غیر منتظره"),),);
        }
      },
      failure: (NetworkExceptions error, msg) {
        emit(HomeServiceEvaluationPackagesState.notice(
            dialogDataModel:
            DialogDataModel(title: '', description: msg ?? "خطای غیر منتظره")));
      },
    );
  }
  EvaluationServiceEntity mapToEvaluationService(InsertHomeServiceServiceItemResponseEntity service) {
    final category = _homeServiceCategoryListSubject.value.firstWhere(
          (category) => category?.categoryId == service.categoryId,
      orElse: () => null,
    );
    return EvaluationServiceEntity(
      serviceCategoryTitle: category?.categoryTitle,
      serviceId: service.id,
      serviceTitle: service.title,
      serviceCategoryId: service.categoryId,
      isImageMandatory: service.isImageMandatory,
      hasSubscription: service.hasSubscription,
      serviceType: service.serviceTypeId,
      productId: service.productId,
      evaluationLabors: service.labors?.map(mapToEvaluationLabor).toList(),
      isCustomerSelected: service.isSelected,
    );
  }

  EvaluationLaborResponseEntity mapToEvaluationLabor(InsertHomeServiceLaborEntity labor) {
    return EvaluationLaborResponseEntity(
      isImageMandatory: labor.isImageMandatory,
      laborId: labor.laborId,
      laborCode: labor.laborCode,
      laborName: labor.laborDesc,
      laborPrice: labor.laborPrice,
      laborGroupId: labor.laborGroupId,
      laborGroupDesc: labor.laborDesc,
      parts: labor.parts?.map(mapToEvaluationPart).toList(),
      costCenterObject: labor.costCenter != null
          ? CostCenterEntity(
          code: labor.costCenter?.code,
          id: labor.costCenter?.id,
          name: labor.costCenter?.name
      ) : null,
    );
  }

  EvaluationPartResponseEntity mapToEvaluationPart(InsertHomeServicePartEntity part) {
    return EvaluationPartResponseEntity(
      partGroupId: part.partGroupId,
      partGroupName: part.partGroupName,
      serial: part.serial,
      partName: part.partTitle,
      partPrice: part.partPrice,
      count: 1,
      mark: part.mark,
      isCausing: false,
      isReusable: part.hasReusable,
      hasReusable: part.hasReusable,
      reusablePrice: part.reusablePrice,
      laborId: part.laborId,
      costCenterObject: part.partCostCenter != null ? CostCenterEntity(
        code: part.partCostCenter?.code,
        id: part.partCostCenter?.id,
        name: part.partCostCenter?.name
      ) : null,
    );
  }

  Future<void> validateServices() async {
    emit(const HomeServiceEvaluationPackagesState.validateServicesLoading());
    if (_homeServiceCategoryListSubject.valueOrNull?.isEmpty ?? true) {
      emit(HomeServiceEvaluationPackagesState.notice(
        dialogDataModel: DialogDataModel(
            title: '', description: 'لطفا یک سرویس را انتخاب نمائید'),),);
      return;
    }
    final rawList = _homeServiceCategoryListSubject.value;
    if (rawList == null || rawList.isEmpty) return;
    final validServices = rawList.where((category) {
      final homeServices = category?.homeServices;
      if (homeServices == null || homeServices.isEmpty) return false;
      return homeServices.any((service) {
        final labors = service.labors;
        return labors != null && labors.isNotEmpty;
      });
    }).expand((category) => category!.homeServices!)
        .where((service) => service.labors != null && service.labors!.isNotEmpty)
        .toList();
    List<EvaluationServiceEntity> mappedList = validServices.map(mapToEvaluationService).toList();
    HomeServiceEvaluationSecondStepCubit.customerServiceList?.addAll(mappedList);
    emit(const HomeServiceEvaluationPackagesState.validateServicesSuccess());
  }

  void toggleServiceCheckBox({required int categoryId, required int serviceId}) {
    final currentList = _homeServiceCategoryListSubject.valueOrNull;
    if (currentList == null) return;
    final updatedList = currentList.map((category) {
      if (category?.categoryId == categoryId) {
        final updatedServices = category?.homeServices?.map((service) {
          if (service.id == serviceId) {
            if (service.isSelected) {
              final bool hasLabors = service.labors?.isNotEmpty ?? false;
              return service.copyWith(
                isSelected: false,
                labors: hasLabors ? [] : service.labors,
              );
            } else {
              return service.copyWith(isSelected: true);
            }

          }
          return service;
        }).toList();
        return category?.copyWith(homeServices: updatedServices);
      }
      return category;
    }).toList();
    _homeServiceCategoryListSubject.add(updatedList);
  }

  void toggleLaborCheckBox({required int laborId}) {
    final currentPackageList = _homeServicePackageListSubject.valueOrNull;
    if (currentPackageList == null) return;
    final updatedPackageList = currentPackageList.map((labor) {
      if(labor?.id == laborId) {
        return labor?.copyWith(isSelected: !(labor.isSelected));
      } else {
        return labor;
      }}).toList();
    _homeServicePackageListSubject.add(updatedPackageList);
  }

  void togglePartCheckBox({required int laborId, required int partGroupId, required int partIndex}) {
    final packageList = _homeServicePackageListSubject.valueOrNull;
    if (packageList == null) return;

    final updatedList = packageList.map((package) {
      if (package == null || package.id != laborId) return package;

      final updatedGroups = package.partGroups?.map((group) {
        if (group.partGroupId != partGroupId) return group;

        final originalParts = group.parts;
        if (originalParts == null || partIndex >= originalParts.length) return group;

        final updatedParts = originalParts.asMap().entries.map((entry) {
          final index = entry.key;
          final part = entry.value;
          if(index == partIndex) {
            final shouldSelect = (package.isPartMandatory ?? false) ? true : !(part.isSelected ?? false);
            return part.copyWith(isSelected: shouldSelect);
          } else {
            return part.copyWith(isSelected: false);
          }
        }).toList();

        return group.copyWith(parts: updatedParts);
      }).toList();

      return package.copyWith(partGroups: updatedGroups?.whereType<InsertHomeServicePartGroupEntity>().toList());
    }).toList();

    _homeServicePackageListSubject.add(updatedList);
  }

  void initializeMandatoryPartSelection() {
    final currentList = _homeServicePackageListSubject.valueOrNull;
    if (currentList == null) return;
    final updatedList = currentList.map((pkg) {
      if (pkg == null) return pkg;
      if(pkg.isPartMandatory == true && (pkg.partGroups?.isNotEmpty ?? false)) {
        final firstPartGroup = pkg.partGroups?.first;
        final updatedParts = firstPartGroup?.parts?.asMap().entries.map((entry) {
          final index = entry.key;
          final part = entry.value;
          return part.copyWith(isSelected: index == 0);
        }).toList();
        final updatedPartGroup = firstPartGroup?.copyWith(parts: updatedParts);
        final updatedGroups = [updatedPartGroup, ...?pkg.partGroups?.skip(1)];
        return pkg.copyWith(partGroups: updatedGroups.whereType<InsertHomeServicePartGroupEntity>().toList());
      }
      return pkg;
    }).toList();
    _homeServicePackageListSubject.add(updatedList);
  }

  void closePackageService({required int categoryId, required int serviceId}) {
    final currentList = _homeServiceCategoryListSubject.valueOrNull;
    if (currentList == null) return;
    final updatedList = currentList.map((category) {
      if (category?.categoryId == categoryId) {
        final updatedServices = category?.homeServices?.map((service) {
          if (service.id == serviceId) {
            if(service.labors?.isNotEmpty ?? false) {
              return service;
            } else {
              return service.copyWith(isSelected: false);
            }
          }
          return service;
        }).toList();
        return category?.copyWith(homeServices: updatedServices);
      }
      return category;
    }).toList();
    _homeServiceCategoryListSubject.add(updatedList);
  }

  void addSelectedPackagesToHomeServices({required int categoryId, required int serviceId}) {
    final currentCategoryList = _homeServiceCategoryListSubject.valueOrNull;
    final currentPackageList = _homeServicePackageListSubject.valueOrNull;
    if (currentCategoryList == null || currentPackageList == null) return;
    final updatedCategories = currentCategoryList.map((category) {
      if(category?.categoryId != categoryId) return category;
      final updatedServices = category?.homeServices?.map((service) {
        if (service.id != serviceId) return service;
        final newLaborEntities = <InsertHomeServiceLaborEntity>[];
        final existingLabors = service.labors ?? [];
        final filteredLabors = existingLabors.where((labor) {
          bool belongsToSelectedPackage = currentPackageList.any((pkg) {
            if (pkg == null) return false;
            return labor.laborId == pkg.id;
          });
          return !belongsToSelectedPackage;
        }).toList();
        for(final pkg in currentPackageList) {
          if(pkg == null) continue;
          final partGroups = pkg.partGroups;
          if(partGroups == null || partGroups.isEmpty) {
            if(pkg.isSelected == true) {
              final labor = convertLaborToHomeServiceLabor(pkg);
              newLaborEntities.add(labor);
            }
          } else {
            final selectedParts = partGroups
                .expand((group) => group.parts ?? [])
                .where((part) => part.isSelected == true)
                .toList();
            if (selectedParts.isNotEmpty) {
              final labor = convertLaborAndPartToHomeServiceLabor(pkg);
              newLaborEntities.add(labor);
            }
          }
        }
        return service.copyWith(
          labors: [
            ...filteredLabors,
            ...newLaborEntities,
          ],
        );
      }).toList();
      return category?.copyWith(homeServices: updatedServices?.whereType<InsertHomeServiceServiceItemResponseEntity>().toList());
    }).toList();
    _homeServiceCategoryListSubject.add(updatedCategories);
  }

  void removedLaborFromService({required int categoryId, required int serviceId, required int laborId}) {
    final currentList = _homeServiceCategoryListSubject.valueOrNull;
    if (currentList == null) return;
    final updatedList = currentList.map((category) {
      if (category?.categoryId != categoryId) return category;
      final updatedServices = category?.homeServices?.map((service) {
        if (service.id != serviceId) return service;
        final updatedLabors = (service.labors ?? []).where((labor) => labor.laborId != laborId).toList();
        final isSelected = updatedLabors.isNotEmpty ? service.isSelected : false;

        return service.copyWith(
          labors: updatedLabors,
          isSelected: isSelected,
        );
      }).toList();

      return category?.copyWith(homeServices: updatedServices);
    }).toList();

    _homeServiceCategoryListSubject.add(updatedList);
  }

  InsertHomeServiceLaborEntity convertLaborToHomeServiceLabor(InsertHomeServicePackageResponseEntity? entity) {
    return InsertHomeServiceLaborEntity(
        serviceId: entity?.serviceId,
        laborCode: entity?.laborCode,
        laborId: entity?.laborId,
        laborDesc: entity?.laborDesc,
        laborGroupId: entity?.laborGroupId,
        laborPrice: entity?.laborPrice,
        costCenter: entity?.laborCostCenter,
        isMandatory: entity?.isMandatory,
        isImageMandatory: entity?.isImageMandatory,
        parts: []

    );
  }

  InsertHomeServiceLaborEntity convertLaborAndPartToHomeServiceLabor(InsertHomeServicePackageResponseEntity? entity, ) {
    final selectedParts = <InsertHomeServicePartEntity>[];
    if (entity != null || (entity?.partGroups?.isNotEmpty ?? false)) {
      for (final group in entity!.partGroups!) {
        if (group.parts != null) {
          final selected = group.parts!.where((p) => p.isSelected == true);
          selectedParts.addAll(selected);
        }
      }
    }
    return InsertHomeServiceLaborEntity(
      laborId: entity?.laborId,
      laborGroupId: entity?.laborGroupId,
      laborDesc: entity?.laborDesc,
      laborCode: entity?.laborCode,
      laborPrice: entity?.laborPrice,
      serviceId: entity?.serviceId,
      costCenter: entity?.laborCostCenter,
      isMandatory: entity?.isMandatory,
      parts: selectedParts.isNotEmpty ? selectedParts : null,
    );
  }

  Future<void> fetchHomeServicePackage({InsertHomeServiceServiceItemResponseEntity? entity}) async {
    emit(const HomeServiceEvaluationPackagesState.servicePackageLoading());
    if(entity?.labors?.isNotEmpty ?? false) {
      emit(const HomeServiceEvaluationPackagesState.servicePackageSuccess());
      return;
    }
    final result = await _fetchInsertHomeServicePackageUseCase.call(
      InsertHomeServicePackageRequestEntity(
        serviceType: 2,
        serviceCategoryId: entity?.categoryId,
        serviceId: entity?.id,
        serviceName: entity?.title,
        kilometer: _lastEvaluationSubject.valueOrNull?.customerKilometer,
        carModelId: _activeServiceRequestSubject.valueOrNull?.carModelId,
        carModelGuid: _activeServiceRequestSubject.valueOrNull?.carGuid,
        chassisNumber: _activeServiceRequestSubject.valueOrNull?.chassisNumber,
        cityId: _activeServiceRequestSubject.valueOrNull?.cityId,
        latitude: _activeServiceRequestSubject.valueOrNull?.latitude,
        longitude: _activeServiceRequestSubject.valueOrNull?.longitude,
        nationalCode: _activeServiceRequestSubject.valueOrNull?.nationalNumber,
        hasSubscription: entity?.hasSubscription,
        planningId: _activeServiceRequestSubject.valueOrNull?.planningId,
        mobileNumber: _activeServiceRequestSubject.valueOrNull?.customerMobileNumber,
        serviceRequestId: _activeServiceRequestSubject.valueOrNull?.id
      ),
    );
    result.whenOrNull(
      success: (data, failures, resultCode) {
        if(resultCode == 0) {
          _homeServicePackageListSubject..add([])..add(data);
          initializeMandatoryPartSelection();
          if((data.isNotEmpty) && (data[0]?.id != null)) {
            packageExpandedIdNotifier.value = data[0]?.id;
          }
          emit(const HomeServiceEvaluationPackagesState.servicePackageSuccess());
        } else {
          emit(HomeServiceEvaluationPackagesState.error(dialogDataModel: DialogDataModel(title: '', description: failures?.listToString() ?? "خطای غیر منتظره"),),);
        }
      },
      failure: (NetworkExceptions error, msg) {
        emit(HomeServiceEvaluationPackagesState.error(
            dialogDataModel: DialogDataModel(title: '', description: msg ?? "خطای غیر منتظره")));
      },
    );
  }


}
