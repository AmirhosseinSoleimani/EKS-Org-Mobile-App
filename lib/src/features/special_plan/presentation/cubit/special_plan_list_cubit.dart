import 'dart:math' as math;

import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/params/special_plan_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/params/special_plan_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/usecases/delete_special_plan_use_case.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/usecases/get_special_plan_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/usecases/get_special_plan_products_use_case.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/cubit/special_plan_list_state.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/usecase/get_province_lookup_list_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/request/latest_request_guard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SpecialPlanListCubit extends Cubit<SpecialPlanListState> with LatestRequestGuard {
  SpecialPlanListCubit(
    this._getListUseCase,
    this._getProductsUseCase,
    this._deleteUseCase,
    this._getProvinceListUseCase,
  ) : super(const SpecialPlanListState());

  final GetSpecialPlanListUseCase _getListUseCase;
  final GetSpecialPlanProductsUseCase _getProductsUseCase;
  final DeleteSpecialPlanUseCase _deleteUseCase;
  final GetProvinceLookupListUseCase _getProvinceListUseCase;

  Future<void> init() async {
    await Future.wait([
      fetchList(reset: true),
      fetchProducts(),
      fetchProvinces(),
    ]);
  }

  Future<void> fetchList({bool reset = false}) async {
    if (!reset &&
        (state.isInitialLoading || state.isLoadingMore || state.isRefreshing)) {
      return;
    }
    final requestVersion = beginLatestRequest('list');

    final nextSkip = reset ? 0 : state.records.length;
    emit(
      state.copyWith(
        status: reset ? SpecialPlanViewStatus.loading : state.status,
        isLoadingMore: !reset,
        skip: nextSkip,
        errorMessage: null,
        successMessage: null,
      ),
    );

    final result = await _getListUseCase(
      _buildFilterParam(skip: nextSkip, pageSize: state.pageSize),
    );
    if (!isLatestRequest(requestVersion, 'list') || isClosed) return;
    result.when(
      success: (page, failures, resultCode) {
        final records = reset
            ? page.records
            : <SpecialPlanEntity>[...state.records, ...page.records];
        emit(
          state.copyWith(
            status: records.isEmpty
                ? SpecialPlanViewStatus.empty
                : SpecialPlanViewStatus.loaded,
            records: records,
            totalCount: page.count,
            isLoadingMore: false,
            errorMessage: null,
          ),
        );
      },
      failure: (error, failures) => _emitListError(
        reset: reset,
        message: failures ?? 'دریافت لیست طرح‌ها با خطا مواجه شد.',
      ),
      expireToken: () => _emitListError(
        reset: reset,
        message: 'نشست کاربری منقضی شده است.',
      ),
      connectionError: () => emit(
        state.copyWith(
          status: reset
              ? SpecialPlanViewStatus.connectionError
              : state.status,
          isLoadingMore: false,
          errorMessage: 'اتصال به اینترنت برقرار نیست.',
        ),
      ),
    );
  }

  Future<void> refresh() async {
    if (state.isInitialLoading || state.isLoadingMore || state.isRefreshing) {
      return;
    }
    final requestVersion = beginLatestRequest('list');

    final requestedPageSize = math.max(
      state.pageSize,
      state.records.isEmpty ? state.pageSize : state.records.length + 1,
    );
    emit(
      state.copyWith(
        isRefreshing: true,
        errorMessage: null,
        successMessage: null,
      ),
    );

    final result = await _getListUseCase(
      _buildFilterParam(skip: 0, pageSize: requestedPageSize),
    );
    if (!isLatestRequest(requestVersion, 'list') || isClosed) return;
    result.when(
      success: (page, failures, resultCode) => emit(
        state.copyWith(
          status: page.records.isEmpty
              ? SpecialPlanViewStatus.empty
              : SpecialPlanViewStatus.loaded,
          records: page.records,
          totalCount: page.count,
          skip: 0,
          isRefreshing: false,
          errorMessage: null,
        ),
      ),
      failure: (error, failures) => _emitRefreshError(
        failures ?? 'به‌روزرسانی لیست طرح‌ها ناموفق بود.',
      ),
      expireToken: () =>
          _emitRefreshError('نشست کاربری منقضی شده است.'),
      connectionError: () =>
          _emitRefreshError('اتصال به اینترنت برقرار نیست.'),
    );
  }

  Future<bool> fetchProducts({bool showError = true}) async {
    if (state.products.isNotEmpty) return true;
    if (state.isProductsLoading) return false;
    emit(state.copyWith(isProductsLoading: true, errorMessage: null));

    var loaded = false;
    final result = await _getProductsUseCase();
    result.when(
      success: (items, failures, resultCode) {
        loaded = true;
        emit(
          state.copyWith(
            products: items
                .where((item) => item.id > 0 && item.title.trim().isNotEmpty)
                .toList(growable: false),
            isProductsLoading: false,
            errorMessage: null,
          ),
        );
      },
      failure: (error, failures) => emit(
        state.copyWith(
          isProductsLoading: false,
          errorMessage: showError
              ? failures ?? 'دریافت لیست محصولات با خطا مواجه شد.'
              : null,
        ),
      ),
      expireToken: () => emit(
        state.copyWith(
          isProductsLoading: false,
          errorMessage: showError ? 'نشست کاربری منقضی شده است.' : null,
        ),
      ),
      connectionError: () => emit(
        state.copyWith(
          isProductsLoading: false,
          errorMessage: showError ? 'اتصال به اینترنت برقرار نیست.' : null,
        ),
      ),
    );
    return loaded;
  }

  Future<bool> fetchProvinces({bool showError = true}) async {
    if (state.provinces.isNotEmpty) return true;
    if (state.isProvincesLoading) return false;
    emit(state.copyWith(isProvincesLoading: true, errorMessage: null));

    var loaded = false;
    final result = await _getProvinceListUseCase();
    result.when(
      success: (items, failures, resultCode) {
        loaded = true;
        emit(
          state.copyWith(
            provinces: items
                .where(
                  (item) =>
                      item.isActive &&
                      item.id > 0 &&
                      item.name.trim().isNotEmpty,
                )
                .toList(growable: false),
            isProvincesLoading: false,
            errorMessage: null,
          ),
        );
      },
      failure: (error, failures) => emit(
        state.copyWith(
          isProvincesLoading: false,
          errorMessage: showError
              ? failures ?? 'دریافت لیست استان‌ها با خطا مواجه شد.'
              : null,
        ),
      ),
      expireToken: () => emit(
        state.copyWith(
          isProvincesLoading: false,
          errorMessage: showError ? 'نشست کاربری منقضی شده است.' : null,
        ),
      ),
      connectionError: () => emit(
        state.copyWith(
          isProvincesLoading: false,
          errorMessage: showError ? 'اتصال به اینترنت برقرار نیست.' : null,
        ),
      ),
    );
    return loaded;
  }

  Future<void> applyFilter({
    String? title,
    int? productId,
    bool? hasHighPriority,
    DateTime? startDate,
    DateTime? endDate,
    int? orderNo,
    String? provinceTitle,
    String? cityTitle,
    bool? isActive,
    bool? onlySaipaCars,
  }) async {
    emit(
      state.copyWith(
        titleFilter: _clean(title),
        productIdFilter: productId,
        hasHighPriorityFilter: hasHighPriority,
        startDateFilter: startDate,
        endDateFilter: endDate,
        orderNoFilter: orderNo,
        provinceTitleFilter: _clean(provinceTitle),
        cityTitleFilter: _clean(cityTitle),
        isActiveFilter: isActive,
        onlySaipaCarsFilter: onlySaipaCars,
        records: const [],
        totalCount: 0,
      ),
    );
    await fetchList(reset: true);
  }

  Future<void> setStatusFilter(bool? value) async {
    if (state.pageStatusFilter == value) return;
    emit(
      state.copyWith(
        pageStatusFilter: value,
        records: const [],
        totalCount: 0,
      ),
    );
    await fetchList(reset: true);
  }

  Future<bool> deletePlan(SpecialPlanEntity item) async {
    final id = item.id;
    if (id == null || state.isDeleting) return false;
    emit(
      state.copyWith(
        isDeleting: true,
        deletingId: id,
        errorMessage: null,
        successMessage: null,
      ),
    );

    var success = false;
    final result = await _deleteUseCase(SpecialPlanIdParamEntity(id: id));
    result.when(
      success: (data, failures, resultCode) {
        success = true;
        final records = state.records
            .where((record) => record.id != id)
            .toList(growable: false);
        emit(
          state.copyWith(
            status: records.isEmpty
                ? SpecialPlanViewStatus.empty
                : SpecialPlanViewStatus.loaded,
            records: records,
            totalCount: math.max(0, state.totalCount - 1),
            isDeleting: false,
            deletingId: null,
            successMessage: 'طرح حذف شد.',
          ),
        );
      },
      failure: (error, failures) => _emitDeleteError(
        failures ?? 'حذف طرح با خطا مواجه شد.',
      ),
      expireToken: () =>
          _emitDeleteError('نشست کاربری منقضی شده است.'),
      connectionError: () =>
          _emitDeleteError('اتصال به اینترنت برقرار نیست.'),
    );
    return success;
  }

  SpecialPlanFilterParamEntity get reportFilter =>
      _buildFilterParam(skip: 0, pageSize: 0);

  SpecialPlanFilterParamEntity _buildFilterParam({
    required int skip,
    required int pageSize,
    bool? isActiveOverride,
  }) {
    return SpecialPlanFilterParamEntity(
      skip: skip,
      pageSize: pageSize,
      title: state.titleFilter,
      productId: state.productIdFilter,
      hasHighPriority: state.hasHighPriorityFilter,
      startDate: state.startDateFilter,
      endDate: state.endDateFilter,
      orderNo: state.orderNoFilter,
      provinceTitle: state.provinceTitleFilter,
      cityTitle: state.cityTitleFilter,
      isActive: isActiveOverride ??
          state.pageStatusFilter ??
          state.isActiveFilter,
      onlySaipaCars: state.onlySaipaCarsFilter,
    );
  }

  void _emitListError({required bool reset, required String message}) {
    emit(
      state.copyWith(
        status: reset ? SpecialPlanViewStatus.failure : state.status,
        isLoadingMore: false,
        errorMessage: message,
      ),
    );
  }

  void _emitRefreshError(String message) {
    emit(state.copyWith(isRefreshing: false, errorMessage: message));
  }

  void _emitDeleteError(String message) {
    emit(
      state.copyWith(
        isDeleting: false,
        deletingId: null,
        errorMessage: message,
      ),
    );
  }

  String? _clean(String? value) {
    final result = value?.trim();
    return result == null || result.isEmpty ? null : result;
  }

  void clearErrorMessage() => emit(state.copyWith(errorMessage: null));

  void clearSuccessMessage() => emit(state.copyWith(successMessage: null));
}
