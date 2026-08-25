import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/common/utils/extensions/iterable_ext.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/evaluation_part_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/active_service_request_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/cost_center_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/labor_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/labor_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/last_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_mark_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_mark_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_price_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/reusable_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_active_service_request_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_labor_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_last_evaluation_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_part_mark_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_part_price_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_part_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_reusable_price_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/cubit/home_service_evaluation_second_step_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/cubit/labors_and_parts_state.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/error_handling/user_facing_error_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class LaborsAndPartsCubit extends Cubit<LaborsAndPartsState> {
  final GetActiveServiceRequestUseCase _getActiveServiceRequestUseCase;
  final GetLastEvaluationUseCase _getLastEvaluationUseCase;
  final GetLaborUseCase _getLaborUseCase;
  final GetPartUseCase _getPartUseCase;
  final GetPartMarkHomeServiceUseCase _getPartMarkHomeServiceUseCase;
  final GetPartPriceHomeServiceUseCase _getPartPriceHomeServiceUseCase;
  final GetReusablePriceUseCase _getReusablePriceUseCase;

  LaborsAndPartsCubit(
    this._getLaborUseCase,
    this._getPartUseCase,
    this._getPartMarkHomeServiceUseCase,
    this._getLastEvaluationUseCase,
    this._getActiveServiceRequestUseCase,
    this._getPartPriceHomeServiceUseCase,
    this._getReusablePriceUseCase,
  ) : super(const LaborsAndPartsState.idle());

  final TextEditingController searchLaborController = TextEditingController();
  final TextEditingController searchPartController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController countController = TextEditingController(
    text: '1',
  );
  final TextEditingController reusableTitleController = TextEditingController();
  final TextEditingController reusablePriceController = TextEditingController();
  final TextEditingController searchReusablePartController =
      TextEditingController();

  final BehaviorSubject<ActiveServiceRequestResponseEntity?>
  _activeServiceRequestSubject =
      BehaviorSubject<ActiveServiceRequestResponseEntity?>();

  BehaviorSubject<ActiveServiceRequestResponseEntity?>
  get activeServiceRequestSubject => _activeServiceRequestSubject;

  final BehaviorSubject<LastEvaluationEntity?> _lastEvaluationSubject =
      BehaviorSubject<LastEvaluationEntity?>();

  BehaviorSubject<LastEvaluationEntity?> get lastEvaluationSubject =>
      _lastEvaluationSubject;

  final BehaviorSubject<List<LaborResponseEntity?>> _laborResponseListSubject =
      BehaviorSubject<List<LaborResponseEntity?>>();

  BehaviorSubject<List<LaborResponseEntity?>> get laborResponseListSubject =>
      _laborResponseListSubject;

  final BehaviorSubject<List<PartResponseEntity?>> _partResponseListSubject =
      BehaviorSubject<List<PartResponseEntity?>>();

  BehaviorSubject<List<PartResponseEntity?>> get partResponseListSubject =>
      _partResponseListSubject;

  final BehaviorSubject<String> _priceLaborSubject =
      BehaviorSubject<String>.seeded('');

  BehaviorSubject<String?> get priceLaborSubject => _priceLaborSubject;

  final BehaviorSubject<String> _pricePartSubject =
      BehaviorSubject<String>.seeded('');

  BehaviorSubject<String?> get pricePartSubject => _pricePartSubject;

  final BehaviorSubject<ReusableEntity?> _reusableSubject =
      BehaviorSubject<ReusableEntity?>();

  BehaviorSubject<ReusableEntity?> get reusableSubject => _reusableSubject;

  LaborResponseEntity? selectLaborResponseEntity = LaborResponseEntity();
  CostCenterEntity? selectLaborCostCenterEntity = CostCenterEntity();
  ValueNotifier<PartResponseEntity?>  selectPartResponseEntity = ValueNotifier(PartResponseEntity());

  ValueNotifier<CostCenterEntity?> selectPartCostCenterEntity = ValueNotifier<CostCenterEntity?>(null);
  final  ValueNotifier<List<PartMarkResponseEntity>> markList = ValueNotifier([]);
  final  ValueNotifier<PartMarkResponseEntity?> selectedMark = ValueNotifier(null);
  List<String> overlapCodes = [];
  String? maxPartPrice;

  @override
  close() async {
    super.close();
    _activeServiceRequestSubject.close();
    _reusableSubject.close();
    _priceLaborSubject.close();
    _partResponseListSubject.close();
    _lastEvaluationSubject.close();
    _laborResponseListSubject.close();
    _pricePartSubject.close();
  }

  Future<void> initState() async {
    emit(const LaborsAndPartsState.loading());
    final activeServiceRequestResult = await _getActiveServiceRequest();
    final lastEvaluationResult = await _getLastEvaluation();
    if (activeServiceRequestResult != 'Success') {
      return emit(
        LaborsAndPartsState.error(
          message: BottomSheetMessageModel(
            title: '',
            message: activeServiceRequestResult,
          ),
        ),
      );
    } else if (lastEvaluationResult != 'Success') {
      return emit(
        LaborsAndPartsState.error(
          message: BottomSheetMessageModel(
            title: '',
            message: lastEvaluationResult,
          ),
        ),
      );
    } else {
      emit(const LaborsAndPartsState.success());
    }
  }

  Future<String> _getActiveServiceRequest() async {
    String resultMessage = '';
    final result = await _getActiveServiceRequestUseCase.call();
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          _activeServiceRequestSubject.value = data;
          resultMessage = 'Success';
        } else {
          resultMessage = failures?.listToString() ?? '';
        }
      },
      failure: (error, msg) {
        resultMessage = msg ?? '';
      },
    );
    return resultMessage;
  }

  Future<String> _getLastEvaluation() async {
    String resultMessage = '';
    final result = await _getLastEvaluationUseCase.call();
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          _lastEvaluationSubject.value = data;
          resultMessage = 'Success';
        } else {
          resultMessage = failures?.listToString() ?? '';
        }
      },
      failure: (error, msg) {
        resultMessage = msg ?? '';
      },
    );
    return resultMessage;
  }

  void selectLabor({LaborResponseEntity? entity}) {
    selectLaborResponseEntity = entity;
    if (selectLaborResponseEntity?.allowableCostCenterList?.isNotEmpty ??
        false) {
      (selectLaborResponseEntity?.allowableCostCenterList?[0].id == 0)
          ? _priceLaborSubject.add(
              selectLaborResponseEntity?.customerPrice.toString() ?? '0',
            )
          : _priceLaborSubject.add(entity?.companyPrice.toString() ?? '0');
      selectLaborCostCenterEntity =
          selectLaborResponseEntity?.allowableCostCenterList?[0];
    } else {
      _priceLaborSubject.add('0');
    }
  }

  Future<void> selectPart({
    PartResponseEntity? partResponseEntity,
    EvaluationPartResponseEntity? evaluationPartEntity,
    bool? isEditablePart,
  }) async {
    emit(const LaborsAndPartsState.loading());
    final activeServiceRequestResult = await _getActiveServiceRequest();
    if (activeServiceRequestResult != 'Success') {
      return emit(
        LaborsAndPartsState.error(
          message: BottomSheetMessageModel(
            title: '',
            message: activeServiceRequestResult,
          ),
        ),
      );
    }
    final lastEvaluationResult = await _getLastEvaluation();
    if (lastEvaluationResult != 'Success') {
      return emit(
        LaborsAndPartsState.error(
          message: BottomSheetMessageModel(
            title: '',
            message: lastEvaluationResult,
          ),
        ),
      );
    }
    final preferredMark = (isEditablePart ?? false)
        ? evaluationPartEntity?.mark
        : null;

    _resetReusableSelection();

    if (isEditablePart ?? false) {
      _hydrateReusableSelection(evaluationPartEntity);
      priceController.text = evaluationPartEntity?.partPrice?.toString() ?? '';
      countController.text = evaluationPartEntity?.count?.toString() ?? '1';
      selectPartResponseEntity.value = PartResponseEntity(
        name: evaluationPartEntity?.partName ?? '',
        serial: evaluationPartEntity?.serial.toString(),
        partGroupId: evaluationPartEntity?.partGroupId,
        partGroupName: evaluationPartEntity?.partGroupName,
        allowableCostCenterList: [
          evaluationPartEntity?.costCenterObject ?? CostCenterEntity(),
        ],
        mark: evaluationPartEntity?.mark,
        garantyDurationDayKilometer:
            evaluationPartEntity?.garantyDurationDayKilometer,
        garantyKilometerKilometer:
            evaluationPartEntity?.garantyKilometerKilometer,
      );
      selectPartCostCenterEntity.value =
          evaluationPartEntity?.costCenterObject ?? CostCenterEntity();
    } else {
      selectPartResponseEntity.value = partResponseEntity;
      if (selectPartResponseEntity.value?.allowableCostCenterList?.isNotEmpty ??
          false) {
        selectPartCostCenterEntity.value =
            selectPartResponseEntity.value?.allowableCostCenterList?.first;
      }
    }

    final partMarkResult = await _getPartMark(preferredMark: preferredMark);
    if (partMarkResult == 'Success') {
      return emit(const LaborsAndPartsState.success());
    } else {
      return emit(
        LaborsAndPartsState.error(
          message: BottomSheetMessageModel(
            title: 'مارک قطعه',
            message: partMarkResult,
          ),
        ),
      );
    }
  }

  Future<void> getLabors({
    required String value,
    required int serviceIndex,
  }) async {
    emit(const LaborsAndPartsState.laborLoading());
    final evaluationService =
        HomeServiceEvaluationSecondStepCubit.selectedServiceList?[serviceIndex];
    final laborRequestEntity = LaborRequestEntity(
      serviceType: ServiceType.homeService,
      searchText: value,
      serviceRequestId: _activeServiceRequestSubject.valueOrNull?.id,
      kilometer: _lastEvaluationSubject.valueOrNull?.customerKilometer,
      hasGaranty: evaluationService?.hasGaranty,
      guarantyStartDate: evaluationService?.garantyStartDate,
      hasSubscription: evaluationService?.hasSubscription,
      workOrderCode: evaluationService?.defectInfoProblemOrEzharCode,
      emdadProductId: evaluationService?.productId,
      emdadServiceId: evaluationService?.serviceId,
    );
    final result = await _getLaborUseCase.call(laborRequestEntity);
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          _laborResponseListSubject.add(data);
          emit(const LaborsAndPartsState.success());
        } else {
          emit(
            LaborsAndPartsState.error(
              message: BottomSheetMessageModel(
                title: 'خطا',
                message: UserFacingErrorMessage.resolve(
                  failures?.listToString(),
                  fallback: 'دریافت قیمت قطعه با خطا مواجه شد.',
                ),
              ),
            ),
          );
        }
      },
      failure: (error, msg) {
        emit(
          LaborsAndPartsState.error(
            message: BottomSheetMessageModel(
              title: '',
              message: msg ?? 'بروز خطا در سیستم',
            ),
          ),
        );
      },
    );
  }

  Future<void> getPart({
    required String value,
    required int laborIndex,
    required int serviceIndex,
  }) async {
    emit(const LaborsAndPartsState.loading());
    final evaluationService =
        HomeServiceEvaluationSecondStepCubit.selectedServiceList?[serviceIndex];
    final partRequestEntity = PartRequestEntity(
      serviceType: ServiceType.homeService,
      serviceRequestId: _activeServiceRequestSubject.valueOrNull?.id,
      searchText: value,
      laborId: evaluationService?.evaluationLabors?[laborIndex].laborId,
      laborGroupId:
          evaluationService?.evaluationLabors?[laborIndex].laborGroupId,
      guarantyStartDate: evaluationService?.garantyStartDate,
      hasGaranty: evaluationService?.hasGaranty,
      hasSubscription: evaluationService?.hasSubscription,
      kilometer: _lastEvaluationSubject.valueOrNull?.customerKilometer,
      emdadProductId: evaluationService?.productId,
      emdadServiceId: evaluationService?.serviceId,
      workOrderCode: evaluationService?.serviceCode,
    );
    final result = await _getPartUseCase.call(partRequestEntity);
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          _partResponseListSubject.add(data);
          emit(const LaborsAndPartsState.success());
        } else {
          emit(
            LaborsAndPartsState.error(
              message: BottomSheetMessageModel(
                title: '',
                message: failures?.listToString() ?? 'بروز خطا در سیستم',
              ),
            ),
          );
        }
      },
      failure: (error, msg) {
        emit(
          LaborsAndPartsState.error(
            message: BottomSheetMessageModel(
              title: '',
              message: msg ?? 'بروز خطا در سیستم',
            ),
          ),
        );
      },
    );
  }

  Future<void> getCustomerPart({
    required String value,
    required int laborIndex,
    required int serviceIndex,
  }) async {
    emit(const LaborsAndPartsState.partLoading());
    final evaluationService =
        HomeServiceEvaluationSecondStepCubit.customerServiceList?[serviceIndex];
    final partRequestEntity = PartRequestEntity(
      serviceType: ServiceType.homeService,
      serviceRequestId: _activeServiceRequestSubject.valueOrNull?.id,
      searchText: value,
      laborId: evaluationService?.evaluationLabors?[laborIndex].laborId,
      laborGroupId:
          evaluationService?.evaluationLabors?[laborIndex].laborGroupId,
      guarantyStartDate: evaluationService?.garantyStartDate,
      hasGaranty: evaluationService?.hasGaranty,
      hasSubscription: evaluationService?.hasSubscription,
      kilometer: _lastEvaluationSubject.valueOrNull?.customerKilometer,
      emdadProductId: evaluationService?.productId,
      emdadServiceId: evaluationService?.serviceId,
      workOrderCode: evaluationService?.serviceCode,
    );
    final result = await _getPartUseCase.call(partRequestEntity);
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          _partResponseListSubject.add(data);
          emit(const LaborsAndPartsState.success());
        } else {
          emit(
            LaborsAndPartsState.error(
              message: BottomSheetMessageModel(
                title: '',
                message: failures?.listToString() ?? 'بروز خطا در سیستم',
              ),
            ),
          );
        }
      },
      failure: (error, msg) {
        emit(
          LaborsAndPartsState.error(
            message: BottomSheetMessageModel(
              title: '',
              message: msg ?? 'بروز خطا در سیستم',
            ),
          ),
        );
      },
    );
  }

  Future<void> submitCustomerPart({
    required int serviceIndex,
    required int laborIndex,
    required int partIndex,
    bool? isEditablePart,
  }) async {
    emit(const LaborsAndPartsState.submitLoading());
    if (selectPartResponseEntity.value?.mark == 'لطفا یک گزینه را انتخاب کنید') {
      emit(
        LaborsAndPartsState.notice(
          message: BottomSheetMessageModel(
            title: '',
            message: 'انتخاب مارک اجباری می باشد',
          ),
        ),
      );
      return;
    }
    if (!_validateReusableSelection()) return;

    if (isEditablePart ?? false) {
      final partsEvaluation = HomeServiceEvaluationSecondStepCubit
          .customerServiceList?[serviceIndex]
          .evaluationLabors?[laborIndex]
          .parts;
      final partSelected = partsEvaluation?[partIndex];
      partSelected?.mark = selectPartResponseEntity.value?.mark;
      partSelected?.partPrice = _parseInt(priceController.text);
      partSelected?.count = _parseInt(countController.text);
      _applyReusableFields(partSelected);
      emit(const LaborsAndPartsState.submitEditPartMarkSuccess());
    } else {
      HomeServiceEvaluationSecondStepCubit
          .customerServiceList?[serviceIndex]
          .evaluationLabors?[laborIndex]
          .parts?[partIndex] = EvaluationPartResponseModel(
        mark: selectPartResponseEntity.value?.mark,
        partPrice: _parseInt(priceController.text),
        partGroupId: selectPartResponseEntity.value?.partGroupId,
        partGroupName: selectPartResponseEntity.value?.partGroupName,
        partName: selectPartResponseEntity.value?.name,
        laborCode: HomeServiceEvaluationSecondStepCubit
            .customerServiceList?[serviceIndex]
            .evaluationLabors?[laborIndex]
            .laborCode,
        laborName: HomeServiceEvaluationSecondStepCubit
            .customerServiceList?[serviceIndex]
            .evaluationLabors?[laborIndex]
            .laborName,
        laborId: HomeServiceEvaluationSecondStepCubit
            .customerServiceList?[serviceIndex]
            .evaluationLabors?[laborIndex]
            .laborId,
        costCenterObject: selectPartCostCenterEntity.value,
        count: _parseInt(countController.text),
        costCenterList: selectPartResponseEntity.value?.allowableCostCenterList,
        reusablePartName: _reusablePartName,
        reusablePartSerial: _reusablePartSerial,
        reusablePrice: _reusablePartPrice,
        garantyKilometerKilometer:
            selectPartResponseEntity.value?.garantyKilometerKilometer,
        garantyDurationDayKilometer:
            selectPartResponseEntity.value?.garantyDurationDayKilometer,
        isReusable: _isReusableActive,
        hasReusable: _hasReusable,
        serial: int.tryParse(selectPartResponseEntity.value?.serial ?? '0'),
      );
      emit(const LaborsAndPartsState.submitAddPartMarkSuccess());
    }
  }

  Future<String> _getPartMark({String? preferredMark}) async {
    emit(const LaborsAndPartsState.markLoading());
    String resultMessage = '';
    final entity = PartMarkRequestEntity(
      serial: selectPartResponseEntity.value?.serial,
      serviceRequestId: _activeServiceRequestSubject.valueOrNull?.id,
      defectId: _activeServiceRequestSubject.valueOrNull?.defectId,
      partGroupId: selectPartResponseEntity.value?.partGroupId,
      serviceType: 2,
    );
    final result = await _getPartMarkHomeServiceUseCase.call(entity);
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode != 0) {
          resultMessage = failures?.listToString() ?? '';
          return;
        }

        final marks = data.whereType<PartMarkResponseEntity>().toList();
        if (marks.isEmpty) {
          markList.value = const [];
          selectedMark.value = null;
          resultMessage = 'برای قطعه انتخاب‌شده مارکی تعریف نشده است.';
          return;
        }

        final normalizedPreferredMark = preferredMark?.trim() ?? '';
        if (normalizedPreferredMark.isNotEmpty) {
          var selected = marks.firstWhere(
            (item) => item.mark == normalizedPreferredMark,
            orElse: () => PartMarkResponseEntity(mark: normalizedPreferredMark),
          );

          if (!marks.any((item) => item.mark == normalizedPreferredMark)) {
            marks.insert(0, selected);
          }

          markList.value = marks;
          selectedMark.value = selected;
          selectPartResponseEntity.value = selectPartResponseEntity.value?.copyWith(
            mark: selected.mark,
          );
        } else {
          const placeholder = PartMarkResponseEntity(
            mark: 'لطفا یک گزینه را انتخاب کنید',
          );
          markList.value = [placeholder, ...marks];
          selectedMark.value = placeholder;
          selectPartResponseEntity.value = selectPartResponseEntity.value?.copyWith(
            mark: placeholder.mark,
          );
        }

        resultMessage = 'Success';
      },
      failure: (error, msg) {
        resultMessage = UserFacingErrorMessage.resolve(
          msg,
          fallback: 'دریافت مارک قطعه با خطا مواجه شد.',
        );
      },
    );
    return resultMessage;
  }

  Future<void> getPartPrice({String? mark}) async {
    emit(const LaborsAndPartsState.partPriceLoading());
    selectPartResponseEntity.value?.mark = mark;
    final result = await _getPartPriceHomeServiceUseCase.call(
      PartPriceRequestEntity(
        mark: mark,
        serviceType: 2,
        serial: selectPartResponseEntity.value?.serial,
      ),
    );
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          maxPartPrice = data?.price.toString();
          reusableTitleController.clear();
          reusablePriceController.clear();
          _reusableSubject.add(
            ReusableEntity(
              hasReusable: data?.hasReusable ?? false,
              isActive: data?.hasReusable ?? false,
              price: -1,
            ),
          );
          if (mark == '500') {
            priceController.text = '';
          } else {
            priceController.text = data?.price.toString() ?? '-';
            _pricePartSubject.add(priceController.text);
          }
          emit(const LaborsAndPartsState.partPriceSuccess());
        } else {
          emit(
            LaborsAndPartsState.error(
              message: BottomSheetMessageModel(
                title: 'خطا',
                message: UserFacingErrorMessage.resolve(
                  failures?.listToString(),
                  fallback: 'دریافت قیمت قطعه با خطا مواجه شد.',
                ),
              ),
            ),
          );
        }
      },
      failure: (error, msg) {
        emit(
          LaborsAndPartsState.error(
            message: BottomSheetMessageModel(
              title: 'خطا',
              message: UserFacingErrorMessage.resolve(
                msg,
                fallback: 'دریافت قیمت قطعه با خطا مواجه شد.',
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> getReusablePrice({String? serial, String? name}) async {
    emit(const LaborsAndPartsState.reusablePriceLoading());
    final result = await _getReusablePriceUseCase.call(
      PartPriceRequestEntity(serial: serial ?? '', serviceType: 2),
    );
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          final reusableName = _cleanOptionalText(name);
          reusablePriceController.text = data?.reusablePrice.toString() ?? '-';
          reusableTitleController.text = reusableName ?? '';
          reusableSubject.add(
            ReusableEntity(
              name: reusableName,
              price: data?.reusablePrice,
              isActive: true,
              hasReusable: true,
              serial: serial,
            ),
          );
          emit(const LaborsAndPartsState.reusablePriceSuccess());
        } else {
          emit(
            LaborsAndPartsState.error(
              message: BottomSheetMessageModel(
                title: 'داغی قطعه',
                message: UserFacingErrorMessage.resolve(
                  failures?.listToString(),
                  fallback: 'دریافت قیمت قطعه داغی با خطا مواجه شد.',
                ),
              ),
            ),
          );
        }
      },
      failure: (error, msg) {
        emit(
          LaborsAndPartsState.error(
            message: BottomSheetMessageModel(
              title: 'داغی قطعه',
              message: UserFacingErrorMessage.resolve(
                msg,
                fallback: 'دریافت قیمت قطعه داغی با خطا مواجه شد.',
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> submitPart({
    required int serviceIndex,
    required int laborIndex,
    required int partIndex,
    bool? isEditablePart,
  }) async {
    emit(const LaborsAndPartsState.submitLoading());
    if (selectPartResponseEntity.value?.mark == 'لطفا یک گزینه را انتخاب کنید') {
      emit(
        LaborsAndPartsState.notice(
          message: BottomSheetMessageModel(
            title: '',
            message: 'انتخاب مارک اجباری می باشد',
          ),
        ),
      );
      return;
    }
    if (!_validateReusableSelection()) return;

    if (isEditablePart ?? false) {
      final partsEvaluation = HomeServiceEvaluationSecondStepCubit
          .customerServiceList?[serviceIndex]
          .evaluationLabors?[laborIndex]
          .parts;
      final partSelected = partsEvaluation?[partIndex];
      partSelected?.mark = selectPartResponseEntity.value?.mark;
      partSelected?.partPrice = _parseInt(priceController.text);
      partSelected?.count = _parseInt(countController.text);
      _applyReusableFields(partSelected);
      emit(const LaborsAndPartsState.submitEditPartMarkSuccess());
    } else {
      HomeServiceEvaluationSecondStepCubit
          .selectedServiceList?[serviceIndex]
          .evaluationLabors?[laborIndex]
          .parts
          ?.add(
            EvaluationPartResponseEntity(
              mark: selectPartResponseEntity.value?.mark,
              partPrice: _parseInt(priceController.text),
              partGroupId: selectPartResponseEntity.value?.partGroupId,
              partGroupName: selectPartResponseEntity.value?.partGroupName,
              partName: selectPartResponseEntity.value?.name,
              laborCode: HomeServiceEvaluationSecondStepCubit
                  .selectedServiceList?[serviceIndex]
                  .evaluationLabors?[laborIndex]
                  .laborCode,
              laborName: HomeServiceEvaluationSecondStepCubit
                  .selectedServiceList?[serviceIndex]
                  .evaluationLabors?[laborIndex]
                  .laborName,
              laborId: HomeServiceEvaluationSecondStepCubit
                  .selectedServiceList?[serviceIndex]
                  .evaluationLabors?[laborIndex]
                  .laborId,
              costCenterObject: selectPartCostCenterEntity.value,
              count: _parseInt(countController.text),
              costCenterList: selectPartResponseEntity.value?.allowableCostCenterList,
              reusablePartName: _reusablePartName,
              reusablePartSerial: _reusablePartSerial,
              reusablePrice: _reusablePartPrice,
              garantyKilometerKilometer:
                  selectPartResponseEntity.value?.garantyKilometerKilometer,
              garantyDurationDayKilometer:
                  selectPartResponseEntity.value?.garantyDurationDayKilometer,
              isReusable: _isReusableActive,
              hasReusable: _hasReusable,
              serial: int.tryParse(selectPartResponseEntity.value?.serial ?? '0'),
            ),
          );
      emit(const LaborsAndPartsState.submitAddPartMarkSuccess());
    }
  }

  void prepareReusableSearch() {
    searchReusablePartController.clear();
    _partResponseListSubject.add(const <PartResponseEntity?>[]);
  }

  void setReusableActive(bool? value) {
    final reusable = _reusableSubject.valueOrNull;
    if (reusable?.hasReusable != true) return;

    if (value == true) {
      _reusableSubject.add(reusable!.copyWith(isActive: true));
      return;
    }

    reusableTitleController.clear();
    reusablePriceController.clear();
    _reusableSubject.add(
      const ReusableEntity(
        hasReusable: true,
        isActive: false,
        price: -1,
      ),
    );
  }

  void _resetReusableSelection() {
    reusableTitleController.clear();
    reusablePriceController.clear();
    _reusableSubject.add(
      const ReusableEntity(
        hasReusable: false,
        isActive: false,
        price: -1,
      ),
    );
  }

  void _hydrateReusableSelection(EvaluationPartResponseEntity? part) {
    final hasReusable = part?.hasReusable == true || part?.isReusable == true;
    final isActive = hasReusable && part?.isReusable == true;
    final name = isActive ? _cleanOptionalText(part?.reusablePartName) : null;
    final serial = isActive ? _cleanOptionalText(part?.reusablePartSerial) : null;
    final price = isActive ? part?.reusablePrice : null;

    reusableTitleController.text = name ?? '';
    reusablePriceController.text = price?.toString() ?? '';
    _reusableSubject.add(
      ReusableEntity(
        hasReusable: hasReusable,
        isActive: isActive,
        name: name,
        serial: serial,
        price: price ?? -1,
      ),
    );
  }

  bool _validateReusableSelection() {
    if (!_isReusableActive || _reusablePartName != null) return true;

    emit(
      LaborsAndPartsState.notice(
        message: const BottomSheetMessageModel(
          title: 'داغی قطعه',
          message: 'قطعه داغی اجباری می باشد',
        ),
      ),
    );
    return false;
  }

  void _applyReusableFields(EvaluationPartResponseEntity? part) {
    if (part == null) return;

    part.hasReusable = _hasReusable;
    part.isReusable = _isReusableActive;
    part.reusablePartName = _reusablePartName;
    part.reusablePartSerial = _reusablePartSerial;
    part.reusablePrice = _reusablePartPrice;
  }

  bool get _hasReusable =>
      _reusableSubject.valueOrNull?.hasReusable == true;

  bool get _isReusableActive =>
      _hasReusable && _reusableSubject.valueOrNull?.isActive == true;

  String? get _reusablePartName => _isReusableActive
      ? _cleanOptionalText(_reusableSubject.valueOrNull?.name)
      : null;

  String? get _reusablePartSerial => _isReusableActive
      ? _cleanOptionalText(_reusableSubject.valueOrNull?.serial)
      : null;

  int? get _reusablePartPrice =>
      _isReusableActive ? _reusableSubject.valueOrNull?.price : null;

  String? _cleanOptionalText(Object? value) {
    final text = value?.toString().trim();
    if (text == null || text.isEmpty || text.toLowerCase() == 'null') {
      return null;
    }
    return text;
  }

  int? _parseInt(String value) {
    return int.tryParse(value.replaceAll(',', '').trim());
  }

}
