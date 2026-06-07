
import 'package:eks_sana_plus_org/src/common/constants/fetch_result_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/emdadgar_service_detail_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/last_evaluation_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/category_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/last_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/service_detail_for_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_categories_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_defects_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_last_evaluation_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_part_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_part_price_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_service_detail_evaluation_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../evaluation/domain/entities/defect_entity.dart';
import 'evaluation_aid_service_form_controller.dart';

part 'evaluation_aid_service_request_cubit.freezed.dart';
part 'evaluation_aid_service_request_state.dart';

@injectable
class EvaluationAidServiceRequestCubit extends Cubit<EvaluationAidServiceRequestState> {
  EvaluationAidServiceRequestCubit(
    this._fetchSelectedRequestItemUseCase,
    this._getReliefRequestByIdUseCase,
    this._getEmdadgarInfoUseCase,
    this._getCategoriesListUseCase,
    this._getPartListUseCase,
    this._getPartPriceListUseCase,
      this._getDefectsListUseCase,
      this._getServiceDetailEvaluationUseCase,
      this._getLastEvaluationUseCase,
  ) : super(const EvaluationAidServiceRequestState.idle());

  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetEmdadgarInfoUseCase _getEmdadgarInfoUseCase;
  final GetCategoriesListUseCase _getCategoriesListUseCase;
  final GetPartListUseCase _getPartListUseCase;
  final GetPartPriceListUseCase _getPartPriceListUseCase;
  final GetDefectsListUseCase _getDefectsListUseCase;
  final GetServiceDetailEvaluationUseCase _getServiceDetailEvaluationUseCase;
  final GetLastEvaluationUseCase _getLastEvaluationUseCase;

  String? _errorMessage;
  ReliefRequestEntity? selectedRequest;
  EmdadgarInfoEntity? emdadgarInfo;
  ResponseLastEvaluationEntity? lastEvaluationEntity;
  EmdadgarServiceDetailEntity? emdadgarServiceDetailEntity;

  final form = EvaluationAidServiceFormController();

  List<DefectEntity> defectList = <DefectEntity>[];
  final selectedDefect = ValueNotifier<DefectEntity?>(null);

  final List<ServiceCategoryEntity> serviceCategoryList = [];
  final selectedServiceCategory = ValueNotifier<ServiceCategoryEntity?>(null);

  VoidCallback? _retryAction;

  Future<void> init() async {
    _retryAction = init;
    final result = await _initializeData();

    switch (result) {
      case FetchResultType.success:
        _safeEmit(const EvaluationAidServiceRequestState.loaded());
        break;

      case FetchResultType.failure:
        _emitError();
        break;

      case FetchResultType.connectionError:
        _safeEmit(const EvaluationAidServiceRequestState.connectionError());
        break;

      case FetchResultType.expireToken:
        _emitError('نشست شما منقضی شده است. لطفا دوباره وارد شوید');
        break;
    }
  }

  Future<FetchResultType> _initializeData() async {
    final selectedResult = await _fetchSelectedRequest();
    if (selectedResult != FetchResultType.success) return selectedResult;

    _safeEmit(const EvaluationAidServiceRequestState.loading());

    final requestResult = await _fetchServiceRequestData();
    if (requestResult != FetchResultType.success) {
      return requestResult;
    }

    final emdadgarResult = await _fetchEmdadgarInfo();
    if (emdadgarResult != FetchResultType.success) {
        return emdadgarResult;
      }

    final defectListResult = await _getDefectList();
    if (defectListResult != FetchResultType.success) {
      return defectListResult;
    }

    final categoryListResult = await getCategoryList();
    if (categoryListResult != FetchResultType.success) {
      return defectListResult;
    }

    final lastEvaluationResult = await getLastEvaluation();
    if (lastEvaluationResult != FetchResultType.success) {
      return lastEvaluationResult;
    }

    final serviceDetailResult = await getServiceDetailEvaluation();
    if (serviceDetailResult != FetchResultType.success) {
      return serviceDetailResult;
    }

    return FetchResultType.success;
  }

  Future<FetchResultType> _fetchSelectedRequest() async {
    try {
      final request = await _fetchSelectedRequestItemUseCase.call();
      if (request is ReliefRequestEntity) {
        selectedRequest = request;
        return FetchResultType.success;
      }
      return FetchResultType.failure;
    } catch (_) {
      _errorMessage = _fallbackError();
      return FetchResultType.failure;
    }
  }

  Future<FetchResultType> _fetchEmdadgarInfo() async {
    final param = ServiceRequestParamEntity(
      serviceRequestId: selectedRequest?.id ?? 0,
      serviceType: selectedRequest?.serviceType?.value ?? 1,
    );
    final result = await _getEmdadgarInfoUseCase(param);

    FetchResultType fetchResult = FetchResultType.failure;

    result.when(
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
      expireToken: () {
        fetchResult = FetchResultType.expireToken;
      },
    );
    return fetchResult;
  }

  Future<FetchResultType> _getDefectList() async {
    final result = await _getDefectsListUseCase(selectedRequest?.id);
    late FetchResultType fetchResult;

    result.when(
      success: (data, _, _) {
        defectList.clear();
        defectList.addAll(data);
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

  Future<FetchResultType> _fetchServiceRequestData() async {
    final id = selectedRequest?.id ?? 0;

    final result = await _getReliefRequestByIdUseCase(id);

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

  Future<void> submit () async {}

  bool isBottomSheetOpen = false;

  void markBottomSheetOpen() {
    isBottomSheetOpen = true;
  }

  void markBottomSheetClosed() {
    isBottomSheetOpen = false;
  }

  Future<void> selectDefect(DefectEntity defect) async {
    _retryAction = () => selectDefect(defect);

    selectedDefect.value = defect;

    await _getServiceDetailAndHandleResult();
  }

  Future<void> setSelectedServiceCategory(
      ServiceCategoryEntity category,) async {
    _retryAction = () => setSelectedServiceCategory(category);

    selectedServiceCategory.value = category;

    await _getServiceDetailAndHandleResult();
  }

  Future<bool> _getServiceDetailAndHandleResult() async {
    final result = await getServiceDetailEvaluation();

    if (result == FetchResultType.success) {
      return true;
    }

    if (result == FetchResultType.connectionError) {
      _safeEmit(const EvaluationAidServiceRequestState.connectionError());
      return false;
    }

    _emitError(_errorMessage);
    return false;
  }

  Future<FetchResultType> getCategoryList() async {
    _retryAction = getCategoryList;

    final param = CategoryParamEntity(serviceType: ServiceType.reliefService,
        planningId: selectedRequest?.planningId ?? 0);
    final result = await _getCategoriesListUseCase(param);
    ;

    late FetchResultType fetchResult = FetchResultType.failure;
    result.whenOrNull(
      success: (data, _, _) {
        serviceCategoryList.clear();
        serviceCategoryList.addAll(data);
        fetchResult = FetchResultType.success;
      },
      connectionError: () {
        fetchResult = FetchResultType.connectionError;
      },
      failure: (error, failures) {
        _errorMessage = _fallbackError(failures ?? error.toString());
      },
    );

    return fetchResult;
  }

  Future<FetchResultType> getLastEvaluation() async {
    _retryAction = getLastEvaluation;

    final param = LastEvaluationParamEntity(
      serviceType: ServiceType.reliefService,
      emdadgarId: emdadgarInfo?.id,
      serviceRequestId: selectedRequest?.id ?? 0,
    );
    final result = await _getLastEvaluationUseCase(param);

    late FetchResultType fetchResult = FetchResultType.failure;
    result.whenOrNull(
      success: (data, _, _) {
        lastEvaluationEntity = data;
        form.fillFromLastEvaluation(data.lastEvaluation);
        fetchResult = FetchResultType.success;
      },
      connectionError: () {
        fetchResult = FetchResultType.connectionError;
      },
      failure: (error, failures) {
        _errorMessage = _fallbackError(failures ?? error.toString());
      },
    );

    return fetchResult;
  }

  Future<FetchResultType> getServiceDetailEvaluation() async {
    _retryAction = getServiceDetailEvaluation;

    final param = ServiceDetailForEvaluationParamEntity(
      serviceType: ServiceType.reliefService,
      aidServiceRequestId: selectedRequest?.id,
      emdadgarDefectInfoId: selectedRequest?.defectId ?? 0,
      emdadgarServiceCategoryId: selectedRequest?.emdadServiceCategoryId ?? 0,
      serviceRequestId: selectedRequest?.id ?? 0,
      evaluationCustomerKilometer:
      lastEvaluationEntity?.lastEvaluation?.customerKilometer,
    );
    final result = await _getServiceDetailEvaluationUseCase(param);

    late FetchResultType fetchResult = FetchResultType.failure;
    result.whenOrNull(
      success: (data, _, _) {
        emdadgarServiceDetailEntity = data;
        form.setServiceTitle(data.serviceTitle);
        fetchResult = FetchResultType.success;
      },
      connectionError: () {
        fetchResult = FetchResultType.connectionError;
      },
      failure: (error, failures) {
        _errorMessage = _fallbackError(failures ?? error.toString());
      },
    );

    return fetchResult;
  }

  void _safeEmit(EvaluationAidServiceRequestState state) {
    if (!isClosed) emit(state);
  }

  void _emitError([String? message]) {
    _safeEmit(
      EvaluationAidServiceRequestState.error(
        message: BottomSheetMessageModel(
          title: 'خطا',
          message: message ?? _errorMessage ?? _fallbackError(),
        ),
      ),
    );
  }

  String _fallbackError([String? msg]) {
    if (msg
        ?.trim()
        .isNotEmpty == true) {
      return msg!;
    }
    return 'درخواست شما با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';
  }

  void retryLastAction() => _retryAction?.call();

  @override
  Future<void> close() {
    return super.close();
  }
}
