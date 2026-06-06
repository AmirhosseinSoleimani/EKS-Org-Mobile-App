import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/common/constants/fetch_result_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/category_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_categories_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_defects_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_part_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_part_price_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../evaluation/domain/entities/defect_entity.dart';

part 'evaluation_aid_service_request_cubit.freezed.dart';
part 'evaluation_aid_service_request_state.dart';

@injectable
class EvaluationAidServiceRequestCubit extends Cubit<EvaluationAidServiceRequestState> {
  EvaluationAidServiceRequestCubit(
    this._fetchSelectedRequestItemUseCase,
    this._getReliefRequestByIdUseCase,
    this._getHomeServiceRequestByIdUseCase,
    this._getEmdadgarInfoUseCase,
    this._getCategoriesListUseCase,
    this._getPartListUseCase,
    this._getPartPriceListUseCase,
      this._getDefectsListUseCase,
  ) : super(const EvaluationAidServiceRequestState.idle());

  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetHomeServiceRequestByIdUseCase _getHomeServiceRequestByIdUseCase;
  final GetEmdadgarInfoUseCase _getEmdadgarInfoUseCase;
  final GetCategoriesListUseCase _getCategoriesListUseCase;
  final GetPartListUseCase _getPartListUseCase;
  final GetPartPriceListUseCase _getPartPriceListUseCase;
  final GetDefectsListUseCase _getDefectsListUseCase;

  String? _errorMessage;
  BaseRequestEntity? selectedRequest;
  EmdadgarInfoEntity? emdadgarInfo;

  final kilometerController = TextEditingController();
  final customerDistanceController = TextEditingController();

  final assignDateController = TextEditingController();
  final assignTimeController = TextEditingController();
  DateTime? assignDateTime;

  final arriveDateController = TextEditingController();
  final arriveTimeController = TextEditingController();
  DateTime? arriveDateTime;

  final serviceController = TextEditingController();
  final descriptionController = TextEditingController();

  List<DefectEntity> defectList = <DefectEntity>[];
  final selectedDefect = ValueNotifier<DefectEntity?>(null);

  final serviceCategoryList = ValueNotifier<List<ServiceCategoryEntity>>([]);
  final selectedServiceCategory = ValueNotifier<ServiceCategoryEntity?>(null);

  final ValueNotifier<bool> isFreewayTollPaid = ValueNotifier<bool>(false);
  final ValueNotifier<bool> categoriesLoading = ValueNotifier<bool>(false);

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

    if (selectedRequest?.hasEmdadGar ?? false) {
      final emdadgarResult = await _fetchEmdadgarInfo();
      if (emdadgarResult != FetchResultType.success) {
        return emdadgarResult;
      }
    }

    final defectListResult = await _getDefectList();
    if (defectListResult != FetchResultType.success) {
      return defectListResult;
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

    final result = (selectedRequest?.serviceType == ServiceType.homeService)
        ? await _getHomeServiceRequestByIdUseCase(id)
        : await _getReliefRequestByIdUseCase(id);

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



  void setAssignDate(DateTime? date) {
    if (date == null) return;
    final current = assignDateTime ?? DateTime.now();
    assignDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      current.hour,
      current.minute,
    );
  }

  void setAssignTime(DateTime time) {
    final current = assignDateTime ?? DateTime.now();
    assignDateTime = DateTime(
      current.year,
      current.month,
      current.day,
      time.hour,
      time.minute,
    );
  }

  void setArriveDate(DateTime? date) {
    if (date == null) return;
    final current = arriveDateTime ?? DateTime.now();
    arriveDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      current.hour,
      current.minute,
    );
  }

  void setArriveTime(DateTime time) {
    final current = arriveDateTime ?? DateTime.now();
    arriveDateTime = DateTime(
      current.year,
      current.month,
      current.day,
      time.hour,
      time.minute,
    );
  }

  void selectDefect(DefectEntity defect) {
    selectedDefect.value = defect;
    getCategoriesByDefect();
  }

  Future<void> getCategoriesByDefect() async {
    _retryAction = getCategoriesByDefect;
    categoriesLoading.value = true;

    final param = CategoryParamEntity(serviceType: ServiceType.reliefService,
        planningId: selectedRequest?.planningId ?? 0);
    final result = await _getCategoriesListUseCase(param);
    result.whenOrNull(
      success: (data, _, _) {
        serviceCategoryList.value = data;
        selectedServiceCategory.value = null;
      },
      connectionError: () =>
          _safeEmit(const EvaluationAidServiceRequestState.connectionError()),
      failure: (error, failures) => _emitError(failures ?? error.toString()),
    );
    categoriesLoading.value = false;
  }

  void setSelectedServiceCategory(ServiceCategoryEntity category) {
    selectedServiceCategory.value = category;
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
    assignDateController.dispose();
    assignTimeController.dispose();
    arriveDateController.dispose();
    arriveTimeController.dispose();
    descriptionController.dispose();

    return super.close();
  }
}
