import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_contract_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_history_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_info_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_info_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/change_agency_status_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/delete_agency_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/change_agency_status_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/delete_agency_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/get_agency_additional_information_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/get_agency_contracts_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/get_agency_history_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/get_agency_info_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/get_agency_info_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/get_agency_info_report_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/get_agency_service_types_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/get_current_agency_persons_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/get_current_agency_vehicles_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/search_agency_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/util/agency_info_excel_exporter.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:open_filex/open_filex.dart';

part 'agency_info_state.dart';

@injectable
class AgencyInfoCubit extends Cubit<AgencyInfoState> {
  AgencyInfoCubit(
    this._getListUseCase,
    this._getByIdUseCase,
    this._searchUseCase,
    this._getReportUseCase,
    this._getContractsUseCase,
    this._getCurrentPersonsUseCase,
    this._getCurrentVehiclesUseCase,
    this._changeStatusUseCase,
    this._deleteAgencyUseCase,
    this._getServiceTypesUseCase,
    this._getAdditionalInformationUseCase,
    this._getHistoryUseCase,
  ) : super(const AgencyInfoState());

  final GetAgencyInfoListUseCase _getListUseCase;
  final GetAgencyInfoByIdUseCase _getByIdUseCase;
  final SearchAgencyInfoUseCase _searchUseCase;
  final GetAgencyInfoReportUseCase _getReportUseCase;
  final GetAgencyContractsUseCase _getContractsUseCase;
  final GetCurrentAgencyPersonsUseCase _getCurrentPersonsUseCase;
  final GetCurrentAgencyVehiclesUseCase _getCurrentVehiclesUseCase;
  final ChangeAgencyStatusUseCase _changeStatusUseCase;
  final DeleteAgencyUseCase _deleteAgencyUseCase;
  final GetAgencyServiceTypesUseCase _getServiceTypesUseCase;
  final GetAgencyAdditionalInformationUseCase _getAdditionalInformationUseCase;
  final GetAgencyHistoryUseCase _getHistoryUseCase;

  final selectorSearchController = TextEditingController();

  VoidCallback? _retryAction;
  static const int _pageSize = 10;

  AgencyInfoStateData get _data => state.data;
  bool get hasRetryAction => _retryAction != null;

  void retryLastAction() => _retryAction?.call();

  Future<void> fetchList({bool refresh = false}) async {
    if (_data.isInitialLoading || _data.isPaginationLoading || _data.isRefreshing) {
      return;
    }

    _retryAction = () => fetchList(refresh: refresh);
    final nextSkip = refresh ? 0 : _data.items.length;
    final filter = _data.filter.copyWith(skip: nextSkip, pageSize: _pageSize);

    final isFirstPage = refresh || _data.items.isEmpty;
    emit(AgencyInfoState(
      status: isFirstPage
          ? AgencyInfoViewStatus.initialLoading
          : AgencyInfoViewStatus.loadingMore,
      data: _data.copyWith(
        filter: filter,
        isInitialLoading: isFirstPage,
        isRefreshing: refresh,
        isPaginationLoading: _data.items.isNotEmpty && !refresh,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    ));

    final result = await _getListUseCase(filter);
    result.when(
      success: (page, failures, resultCode) {
        final records = refresh ? page.records : [..._data.items, ...page.records];
        emit(AgencyInfoState(
          status: records.isEmpty
              ? AgencyInfoViewStatus.empty
              : AgencyInfoViewStatus.loaded,
          data: _data.copyWith(
            items: records,
            totalCount: page.count,
            hasMore: records.length < page.count,
            isInitialLoading: false,
            isRefreshing: false,
            isPaginationLoading: false,
            clearErrorMessage: true,
          ),
        ));
      },
      failure: (error, failures) => _emitFailure(failures),
      expireToken: () => _emitFailure('نشست کاربری منقضی شده است.'),
      connectionError: () => emit(AgencyInfoState(
        status: AgencyInfoViewStatus.connectionError,
        data: _data.copyWith(
          isInitialLoading: false,
          isRefreshing: false,
          isPaginationLoading: false,
        ),
      )),
    );
  }

  Future<void> applyFilter(AgencyInfoFilterParamEntity filter) async {
    emit(AgencyInfoState(
      status: AgencyInfoViewStatus.filterLoading,
      data: _data.copyWith(filter: filter.copyWith(skip: 0, pageSize: _pageSize)),
    ));
    await fetchList(refresh: true);
  }

  Future<void> clearFilter() async {
    emit(AgencyInfoState(
      status: AgencyInfoViewStatus.filterLoading,
      data: _data.copyWith(
        filter: const AgencyInfoFilterParamEntity(pageSize: _pageSize),
      ),
    ));
    await fetchList(refresh: true);
  }

  Future<void> loadDetail(int id) async {
    if (_data.loadingDetailId == id) {
      return;
    }

    _retryAction = () => loadDetail(id);
    emit(AgencyInfoState(
      status: AgencyInfoViewStatus.actionLoading,
      data: _data.copyWith(loadingDetailId: id, clearErrorMessage: true),
    ));

    final result = await _getByIdUseCase(id);
    result.when(
      success: (item, failures, resultCode) {
        emit(AgencyInfoState(
          status: AgencyInfoViewStatus.loaded,
          data: _data.copyWith(
            selectedAgency: item,
            clearLoadingDetailId: true,
            clearErrorMessage: true,
          ),
        ));
      },
      failure: (error, failures) => _emitFailure(failures, clearDetailLoading: true),
      expireToken: () => _emitFailure('نشست کاربری منقضی شده است.', clearDetailLoading: true),
      connectionError: () => emit(AgencyInfoState(
        status: AgencyInfoViewStatus.connectionError,
        data: _data.copyWith(clearLoadingDetailId: true),
      )),
    );
  }

  Future<void> loadActionData(
    AgencyInfoActionType actionType,
    AgencyInfoEntity item,
  ) async {
    final id = item.id;
    if (id == null ||
        actionType == AgencyInfoActionType.delete ||
        state.status == AgencyInfoViewStatus.actionLoading) {
      return;
    }

    _retryAction = () => loadActionData(actionType, item);
    emit(AgencyInfoState(
      status: AgencyInfoViewStatus.actionLoading,
      data: _data.copyWith(
        actionType: actionType,
        actionAgency: item,
        clearActionData: true,
        loadingDetailId: id,
        clearErrorMessage: true,
      ),
    ));

    switch (actionType) {
      case AgencyInfoActionType.contracts:
        final result = await _getContractsUseCase(
          AgencyContractParamEntity(agencyId: id, pageSize: 0),
        );
        result.when(
          success: (data, failures, resultCode) => _emitActionLoaded(
            actionType: actionType,
            agency: item,
            actionData: data,
          ),
          failure: (error, failures) => _emitActionFailure(failures),
          expireToken: () => _emitActionFailure('نشست کاربری منقضی شده است.'),
          connectionError: _emitActionConnectionError,
        );
        return;
      case AgencyInfoActionType.activeReliefWorkers:
        final result = await _getCurrentPersonsUseCase(
          AgencyInfoIdParamEntity(agencyInfoId: id),
        );
        result.when(
          success: (data, failures, resultCode) => _emitActionLoaded(
            actionType: actionType,
            agency: item,
            actionData: data,
          ),
          failure: (error, failures) => _emitActionFailure(failures),
          expireToken: () => _emitActionFailure('نشست کاربری منقضی شده است.'),
          connectionError: _emitActionConnectionError,
        );
        return;
      case AgencyInfoActionType.activeVehicles:
        final result = await _getCurrentVehiclesUseCase(
          AgencyInfoIdParamEntity(agencyInfoId: id),
        );
        result.when(
          success: (data, failures, resultCode) => _emitActionLoaded(
            actionType: actionType,
            agency: item,
            actionData: data,
          ),
          failure: (error, failures) => _emitActionFailure(failures),
          expireToken: () => _emitActionFailure('نشست کاربری منقضی شده است.'),
          connectionError: _emitActionConnectionError,
        );
        return;
      case AgencyInfoActionType.changeStatus:
        final nextStatus = !(item.isActive ?? true);
        final result = await _changeStatusUseCase(
          ChangeAgencyStatusParamEntity(
            agencyInfoId: id,
            status: nextStatus,
          ),
        );
        result.when(
          success: (data, failures, resultCode) {
            final updatedAgency = item.copyWith(isActive: nextStatus);
            final updatedItems = _data.items
                .map((agency) => agency.id == id
                    ? agency.copyWith(isActive: nextStatus)
                    : agency)
                .toList();
            final updatedSelectorItems = _data.selectorItems
                .map((agency) => agency.id == id
                    ? agency.copyWith(isActive: nextStatus)
                    : agency)
                .toList();
            final updatedSelectedAgency = _data.selectedAgency?.id == id
                ? _data.selectedAgency!.copyWith(isActive: nextStatus)
                : _data.selectedAgency;

            emit(AgencyInfoState(
              status: AgencyInfoViewStatus.loaded,
              data: _data.copyWith(
                items: updatedItems,
                selectorItems: updatedSelectorItems,
                selectedAgency: updatedSelectedAgency,
                actionAgency: updatedAgency,
                actionType: actionType,
                clearActionData: true,
                clearLoadingDetailId: true,
                successMessage: nextStatus
                    ? 'نمایندگی با موفقیت فعال شد.'
                    : 'نمایندگی با موفقیت غیرفعال شد.',
                clearErrorMessage: true,
              ),
            ));
          },
          failure: (error, failures) => _emitActionFailure(failures),
          expireToken: () => _emitActionFailure('نشست کاربری منقضی شده است.'),
          connectionError: _emitActionConnectionError,
        );
        return;
      case AgencyInfoActionType.serviceType:
        final result = await _getServiceTypesUseCase(AgencyIdParamEntity(id: id));
        result.when(
          success: (data, failures, resultCode) => _emitActionLoaded(
            actionType: actionType,
            agency: item,
            actionData: data,
          ),
          failure: (error, failures) => _emitActionFailure(failures),
          expireToken: () => _emitActionFailure('نشست کاربری منقضی شده است.'),
          connectionError: _emitActionConnectionError,
        );
        return;
      case AgencyInfoActionType.complementaryInfo:
        final result = await _getAdditionalInformationUseCase(
          AgencyInfoIdParamEntity(agencyInfoId: id),
        );
        result.when(
          success: (data, failures, resultCode) => _emitActionLoaded(
            actionType: actionType,
            agency: item,
            actionData: data,
          ),
          failure: (error, failures) => _emitActionFailure(failures),
          expireToken: () => _emitActionFailure('نشست کاربری منقضی شده است.'),
          connectionError: _emitActionConnectionError,
        );
        return;
      case AgencyInfoActionType.history:
        final result = await _getHistoryUseCase(AgencyHistoryParamEntity(refId: id));
        result.when(
          success: (data, failures, resultCode) => _emitActionLoaded(
            actionType: actionType,
            agency: item,
            actionData: data,
          ),
          failure: (error, failures) => _emitActionFailure(failures),
          expireToken: () => _emitActionFailure('نشست کاربری منقضی شده است.'),
          connectionError: _emitActionConnectionError,
        );
        return;
      case AgencyInfoActionType.delete:
        return;
    }
  }

  Future<bool> deleteAgency(AgencyInfoEntity item) async {
    final id = item.id;
    if (id == null || _data.deletingAgencyId != null) {
      return false;
    }

    _retryAction = () {
      deleteAgency(item);
    };

    emit(AgencyInfoState(
      status: AgencyInfoViewStatus.actionLoading,
      data: _data.copyWith(
        deletingAgencyId: id,
        clearActionAgency: true,
        clearActionType: true,
        clearActionData: true,
        clearLoadingDetailId: true,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    ));

    final result = await _deleteAgencyUseCase(
      DeleteAgencyParamEntity(id: id),
    );

    return result.when(
      success: (data, failures, resultCode) {
        final updatedItems = _data.items
            .where((agency) => agency.id != id)
            .toList(growable: false);
        final updatedSelectorItems = _data.selectorItems
            .where((agency) => agency.id != id)
            .toList(growable: false);
        final updatedTotalCount =
            _data.totalCount > 0 ? _data.totalCount - 1 : 0;

        emit(AgencyInfoState(
          status: updatedItems.isEmpty
              ? AgencyInfoViewStatus.empty
              : AgencyInfoViewStatus.loaded,
          data: _data.copyWith(
            items: updatedItems,
            selectorItems: updatedSelectorItems,
            totalCount: updatedTotalCount,
            hasMore: updatedItems.length < updatedTotalCount,
            clearSelectedAgency: _data.selectedAgency?.id == id,
            clearActionAgency: true,
            clearActionType: true,
            clearActionData: true,
            clearLoadingDetailId: true,
            clearDeletingAgencyId: true,
            successMessage: 'نمایندگی با موفقیت حذف شد.',
            clearErrorMessage: true,
          ),
        ));
        return true;
      },
      failure: (error, failures) {
        _emitDeleteFailure(failures);
        return false;
      },
      expireToken: () {
        _emitDeleteFailure('نشست کاربری منقضی شده است.');
        return false;
      },
      connectionError: () {
        _emitDeleteFailure('اتصال به اینترنت برقرار نیست.');
        return false;
      },
    );
  }

  void _emitDeleteFailure(String? message) {
    emit(AgencyInfoState(
      status: AgencyInfoViewStatus.actionError,
      data: _data.copyWith(
        clearDeletingAgencyId: true,
        errorMessage: message?.trim().isNotEmpty == true
            ? message
            : 'حذف نمایندگی با خطا مواجه شد.',
      ),
    ));
  }

  void _emitActionLoaded({
    required AgencyInfoActionType actionType,
    required AgencyInfoEntity agency,
    Object? actionData,
  }) {
    emit(AgencyInfoState(
      status: AgencyInfoViewStatus.actionDataLoaded,
      data: _data.copyWith(
        actionType: actionType,
        actionAgency: agency,
        actionData: actionData,
        selectedAgency: agency,
        clearLoadingDetailId: true,
        clearErrorMessage: true,
      ),
    ));
  }

  void _emitActionFailure(String? message) {
    _emitFailure(
      message,
      status: AgencyInfoViewStatus.actionError,
      clearDetailLoading: true,
    );
  }

  void _emitActionConnectionError() {
    emit(AgencyInfoState(
      status: AgencyInfoViewStatus.connectionError,
      data: _data.copyWith(clearLoadingDetailId: true),
    ));
  }

  void clearActionData() {
    emit(state.copyWith(
      status: AgencyInfoViewStatus.loaded,
      data: _data.copyWith(
        clearActionAgency: true,
        clearActionType: true,
        clearActionData: true,
        clearLoadingDetailId: true,
      ),
    ));
  }

  Future<void> getReport() async {
    if (_data.isReportLoading) return;

    emit(AgencyInfoState(
      status: AgencyInfoViewStatus.reportLoading,
      data: _data.copyWith(
        isReportLoading: true,
        clearReportFilePath: true,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    ));

    try {
      final result = await _getReportUseCase(_data.filter.copyWith(
        skip: 0,
        pageSize: 0,
      ));

      await result.when<Future<void>>(
        success: (data, failures, resultCode) async {
          final filePath = await AgencyInfoExcelExporter.export(data.items);

          emit(AgencyInfoState(
            status: AgencyInfoViewStatus.reportSuccess,
            data: _data.copyWith(
              isReportLoading: false,
              reportFilePath: filePath,
              successMessage: 'فایل اکسل گزارش نمایندگی‌ها آماده شد.',
              clearErrorMessage: true,
            ),
          ));

          try {
            final openResult = await OpenFilex.open(
              filePath,
              type: 'application/vnd.ms-excel',
            );

            if (openResult.type != ResultType.done) {
              _emitReportSavedButNotOpened(filePath);
            }
          } catch (_) {
            _emitReportSavedButNotOpened(filePath);
          }
        },
        failure: (error, failures) async => _emitFailure(
          failures,
          status: AgencyInfoViewStatus.pageError,
          clearReportLoading: true,
        ),
        expireToken: () async => _emitFailure(
          'نشست کاربری منقضی شده است.',
          status: AgencyInfoViewStatus.pageError,
          clearReportLoading: true,
        ),
        connectionError: () async => emit(AgencyInfoState(
          status: AgencyInfoViewStatus.connectionError,
          data: _data.copyWith(isReportLoading: false),
        )),
      );
    } catch (_) {
      _emitFailure(
        'دریافت گزارش با خطا مواجه شد.',
        status: AgencyInfoViewStatus.pageError,
        clearReportLoading: true,
      );
    } finally {
      if (!isClosed && _data.isReportLoading) {
        emit(state.copyWith(
          data: _data.copyWith(isReportLoading: false),
        ));
      }
    }
  }

  void _emitReportSavedButNotOpened(String filePath) {
    emit(AgencyInfoState(
      status: AgencyInfoViewStatus.loaded,
      data: _data.copyWith(
        isReportLoading: false,
        reportFilePath: filePath,
        successMessage:
            'فایل اکسل ذخیره شد اما برنامه‌ای برای باز کردن آن پیدا نشد.',
        clearErrorMessage: true,
      ),
    ));
  }

  Future<void> searchForSelector(String query) async {
    final normalizedQuery = query.trim();
    selectorSearchController.text = query;

    if (normalizedQuery.length < 2) {
      emit(AgencyInfoState(
        status: AgencyInfoViewStatus.loaded,
        data: _data.copyWith(
          selectorItems: const [],
          selectorSearchText: normalizedQuery,
          isSelectorLoading: false,
          clearErrorMessage: true,
        ),
      ));
      return;
    }

    if (_data.isSelectorLoading) {
      return;
    }

    emit(AgencyInfoState(
      status: AgencyInfoViewStatus.selectorLoading,
      data: _data.copyWith(
        selectorSearchText: normalizedQuery,
        isSelectorLoading: true,
        clearErrorMessage: true,
      ),
    ));

    final result = await _searchUseCase(normalizedQuery);
    result.when(
      success: (items, failures, resultCode) {
        emit(AgencyInfoState(
          status: AgencyInfoViewStatus.loaded,
          data: _data.copyWith(
            selectorItems: items,
            isSelectorLoading: false,
            clearErrorMessage: true,
          ),
        ));
      },
      failure: (error, failures) => _emitFailure(failures, clearSelectorLoading: true),
      expireToken: () => _emitFailure('نشست کاربری منقضی شده است.', clearSelectorLoading: true),
      connectionError: () => emit(AgencyInfoState(
        status: AgencyInfoViewStatus.connectionError,
        data: _data.copyWith(isSelectorLoading: false),
      )),
    );
  }

  void selectAgency(AgencyInfoEntity agency) {
    emit(AgencyInfoState(
      status: AgencyInfoViewStatus.loaded,
      data: _data.copyWith(selectedAgency: agency),
    ));
  }

  void _emitFailure(
    String? message, {
    AgencyInfoViewStatus status = AgencyInfoViewStatus.pageError,
    bool clearDetailLoading = false,
    bool clearSelectorLoading = false,
    bool clearReportLoading = false,
  }) {
    emit(AgencyInfoState(
      status: status,
      data: _data.copyWith(
        isInitialLoading: false,
        isRefreshing: false,
        isPaginationLoading: false,
        isSelectorLoading: clearSelectorLoading ? false : _data.isSelectorLoading,
        isReportLoading: clearReportLoading ? false : _data.isReportLoading,
        clearLoadingDetailId: clearDetailLoading,
        errorMessage: message?.trim().isNotEmpty == true
            ? message
            : 'عملیات با خطا مواجه شد.',
      ),
    ));
  }

  @override
  Future<void> close() {
    selectorSearchController.dispose();
    return super.close();
  }
}
