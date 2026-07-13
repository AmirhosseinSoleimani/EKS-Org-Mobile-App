import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_info_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/get_agency_info_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/get_agency_info_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/search_agency_info_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'agency_info_cubit.freezed.dart';
part 'agency_info_state.dart';

@injectable
class AgencyInfoCubit extends Cubit<AgencyInfoState> {
  AgencyInfoCubit(
    this._getListUseCase,
    this._getByIdUseCase,
    this._searchUseCase,
  ) : super(const AgencyInfoState.idle());

  final GetAgencyInfoListUseCase _getListUseCase;
  final GetAgencyInfoByIdUseCase _getByIdUseCase;
  final SearchAgencyInfoUseCase _searchUseCase;

  final nameController = TextEditingController();
  final codeController = TextEditingController();
  final managerController = TextEditingController();
  final cityController = TextEditingController();
  final mobileController = TextEditingController();
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

    emit(AgencyInfoState.loading(
      data: _data.copyWith(
        filter: filter,
        isInitialLoading: _data.items.isEmpty && !refresh,
        isRefreshing: refresh,
        isPaginationLoading: _data.items.isNotEmpty && !refresh,
        errorMessage: null,
      ),
    ));

    final result = await _getListUseCase(filter);
    result.when(
      success: (page, failures, resultCode) {
        final records = refresh ? page.records : [..._data.items, ...page.records];
        emit(AgencyInfoState.loaded(
          data: _data.copyWith(
            items: records,
            totalCount: page.count,
            hasMore: records.length < page.count,
            isInitialLoading: false,
            isRefreshing: false,
            isPaginationLoading: false,
            errorMessage: null,
          ),
        ));
      },
      failure: (error, failures) => _emitFailure(failures),
      expireToken: () => _emitFailure('نشست کاربری منقضی شده است.'),
      connectionError: () => emit(AgencyInfoState.connectionError(
        data: _data.copyWith(
          isInitialLoading: false,
          isRefreshing: false,
          isPaginationLoading: false,
        ),
      )),
    );
  }

  Future<void> applyFilter(AgencyInfoFilterParamEntity filter) async {
    emit(AgencyInfoState.loaded(
      data: _data.copyWith(filter: filter.copyWith(skip: 0, pageSize: _pageSize)),
    ));
    await fetchList(refresh: true);
  }

  Future<void> clearFilter() async {
    nameController.clear();
    codeController.clear();
    managerController.clear();
    cityController.clear();
    mobileController.clear();

    emit(AgencyInfoState.loaded(
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
    emit(AgencyInfoState.loading(
      data: _data.copyWith(loadingDetailId: id, errorMessage: null),
    ));

    final result = await _getByIdUseCase(id);
    result.when(
      success: (item, failures, resultCode) {
        emit(AgencyInfoState.loaded(
          data: _data.copyWith(
            selectedAgency: item,
            loadingDetailId: null,
            errorMessage: null,
          ),
        ));
      },
      failure: (error, failures) => _emitFailure(failures, clearDetailLoading: true),
      expireToken: () => _emitFailure('نشست کاربری منقضی شده است.', clearDetailLoading: true),
      connectionError: () => emit(AgencyInfoState.connectionError(
        data: _data.copyWith(loadingDetailId: null),
      )),
    );
  }

  Future<void> searchForSelector(String query) async {
    final normalizedQuery = query.trim();
    selectorSearchController.text = query;

    if (normalizedQuery.length < 2) {
      emit(AgencyInfoState.loaded(
        data: _data.copyWith(
          selectorItems: const [],
          selectorSearchText: normalizedQuery,
          isSelectorLoading: false,
          errorMessage: null,
        ),
      ));
      return;
    }

    if (_data.isSelectorLoading) {
      return;
    }

    emit(AgencyInfoState.loading(
      data: _data.copyWith(
        selectorSearchText: normalizedQuery,
        isSelectorLoading: true,
        errorMessage: null,
      ),
    ));

    final result = await _searchUseCase(normalizedQuery);
    result.when(
      success: (items, failures, resultCode) {
        emit(AgencyInfoState.loaded(
          data: _data.copyWith(
            selectorItems: items,
            isSelectorLoading: false,
            errorMessage: null,
          ),
        ));
      },
      failure: (error, failures) => _emitFailure(failures, clearSelectorLoading: true),
      expireToken: () => _emitFailure('نشست کاربری منقضی شده است.', clearSelectorLoading: true),
      connectionError: () => emit(AgencyInfoState.connectionError(
        data: _data.copyWith(isSelectorLoading: false),
      )),
    );
  }

  void selectAgency(AgencyInfoEntity agency) {
    emit(AgencyInfoState.loaded(data: _data.copyWith(selectedAgency: agency)));
  }

  void _emitFailure(
    String? message, {
    bool clearDetailLoading = false,
    bool clearSelectorLoading = false,
  }) {
    emit(AgencyInfoState.failure(
      data: _data.copyWith(
        isInitialLoading: false,
        isRefreshing: false,
        isPaginationLoading: false,
        isSelectorLoading: clearSelectorLoading ? false : _data.isSelectorLoading,
        loadingDetailId: clearDetailLoading ? null : _data.loadingDetailId,
        errorMessage: message?.trim().isNotEmpty == true
            ? message
            : 'عملیات با خطا مواجه شد.',
      ),
    ));
  }

  @override
  Future<void> close() {
    nameController.dispose();
    codeController.dispose();
    managerController.dispose();
    cityController.dispose();
    mobileController.dispose();
    selectorSearchController.dispose();
    return super.close();
  }
}
