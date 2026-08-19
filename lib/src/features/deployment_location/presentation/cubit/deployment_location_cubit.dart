import 'dart:math' as math;

import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/deployment_location_entity.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/params/deployment_location_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/params/deployment_location_form_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/params/deployment_location_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/usecases/create_deployment_location_use_case.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/usecases/delete_deployment_location_use_case.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/usecases/get_deployment_location_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/usecases/get_deployment_location_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/usecases/update_deployment_location_use_case.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/presentation/cubit/deployment_location_state.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/presentation/services/deployment_location_excel_report_factory.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/usecase/export_excel_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/usecase/get_province_with_city_list_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/request/latest_request_guard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeploymentLocationCubit extends Cubit<DeploymentLocationState> with LatestRequestGuard {
  DeploymentLocationCubit(
    this._getListUseCase,
    this._getByIdUseCase,
    this._createUseCase,
    this._updateUseCase,
    this._deleteUseCase,
    this._getProvinceWithCityListUseCase,
    this._exportExcelUseCase,
  ) : super(const DeploymentLocationState());

  final GetDeploymentLocationListUseCase _getListUseCase;
  final GetDeploymentLocationByIdUseCase _getByIdUseCase;
  final CreateDeploymentLocationUseCase _createUseCase;
  final UpdateDeploymentLocationUseCase _updateUseCase;
  final DeleteDeploymentLocationUseCase _deleteUseCase;
  final GetProvinceWithCityListUseCase _getProvinceWithCityListUseCase;
  final ExportExcelUseCase _exportExcelUseCase;

  Future<void> initList() async {
    await fetchList(reset: true);
  }

  Future<void> initializeForm({int? id}) async {
    emit(
      state.copyWith(
        isFormLoading: true,
        formLoadFailed: false,
        clearFormLocation: true,
        clearErrorMessage: true,
      ),
    );

    await fetchProvinceCities();
    if (state.provinceCities.isEmpty) {
      emit(
        state.copyWith(
          isFormLoading: false,
          formLoadFailed: true,
          errorMessage: state.errorMessage ??
              'دریافت لیست استان و شهر با خطا مواجه شد.',
        ),
      );
      return;
    }
    if (id == null) {
      emit(state.copyWith(isFormLoading: false));
      return;
    }
    await fetchById(id);
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
        status: reset ? DeploymentLocationViewStatus.loading : state.status,
        isLoadingMore: !reset,
        skip: nextSkip,
        clearErrorMessage: true,
        clearSuccessMessage: true,
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
            : <DeploymentLocationEntity>[...state.records, ...page.records];
        emit(
          state.copyWith(
            status: records.isEmpty
                ? DeploymentLocationViewStatus.empty
                : DeploymentLocationViewStatus.loaded,
            records: records,
            totalCount: page.count,
            isLoadingMore: false,
            clearErrorMessage: true,
          ),
        );
      },
      failure: (error, failures) => emit(
        state.copyWith(
          status: reset ? DeploymentLocationViewStatus.failure : state.status,
          isLoadingMore: false,
          errorMessage:
              failures ?? 'دریافت لیست محل‌های استقرار با خطا مواجه شد.',
        ),
      ),
      expireToken: () => emit(
        state.copyWith(
          status: reset ? DeploymentLocationViewStatus.failure : state.status,
          isLoadingMore: false,
          errorMessage: 'نشست کاربری منقضی شده است.',
        ),
      ),
      connectionError: () => emit(
        state.copyWith(
          status: reset
              ? DeploymentLocationViewStatus.connectionError
              : state.status,
          isLoadingMore: false,
          errorMessage: 'اتصال به اینترنت برقرار نیست.',
        ),
      ),
    );
  }

  Future<void> refreshCurrentList() async {
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
        clearErrorMessage: true,
        clearSuccessMessage: true,
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
              ? DeploymentLocationViewStatus.empty
              : DeploymentLocationViewStatus.loaded,
          records: page.records,
          totalCount: page.count,
          skip: 0,
          isRefreshing: false,
          clearErrorMessage: true,
        ),
      ),
      failure: (error, failures) => emit(
        state.copyWith(
          isRefreshing: false,
          errorMessage:
              failures ?? 'به‌روزرسانی لیست محل‌های استقرار با خطا مواجه شد.',
        ),
      ),
      expireToken: () => emit(
        state.copyWith(
          isRefreshing: false,
          errorMessage: 'نشست کاربری منقضی شده است.',
        ),
      ),
      connectionError: () => emit(
        state.copyWith(
          isRefreshing: false,
          errorMessage: 'اتصال به اینترنت برقرار نیست.',
        ),
      ),
    );
  }

  Future<void> applyFilter({
    String? title,
    String? provinceTitle,
    String? cityTitle,
    String? address,
    bool? isActive,
  }) async {
    emit(
      state.copyWith(
        titleFilter: title?.trim(),
        clearTitleFilter: title?.trim().isEmpty ?? true,
        provinceTitleFilter: provinceTitle?.trim(),
        clearProvinceTitleFilter: provinceTitle?.trim().isEmpty ?? true,
        cityTitleFilter: cityTitle?.trim(),
        clearCityTitleFilter: cityTitle?.trim().isEmpty ?? true,
        addressFilter: address?.trim(),
        clearAddressFilter: address?.trim().isEmpty ?? true,
        isActiveFilter: isActive,
        clearIsActiveFilter: isActive == null,
        records: const [],
        totalCount: 0,
      ),
    );
    await fetchList(reset: true);
  }

  void setPageStatusFilter(bool? value) {
    emit(
      state.copyWith(
        pageStatusFilter: value,
        clearPageStatusFilter: value == null,
      ),
    );
  }

  Future<void> fetchProvinceCities() async {
    if (state.isAreasLoading || state.provinceCities.isNotEmpty) return;
    emit(state.copyWith(isAreasLoading: true, clearErrorMessage: true));

    final result = await _getProvinceWithCityListUseCase();
    result.when(
      success: (items, failures, resultCode) => emit(
        state.copyWith(
          provinceCities: items,
          isAreasLoading: false,
          clearErrorMessage: true,
        ),
      ),
      failure: (error, failures) => emit(
        state.copyWith(
          isAreasLoading: false,
          errorMessage: failures ?? 'دریافت لیست استان و شهر با خطا مواجه شد.',
        ),
      ),
      expireToken: () => emit(
        state.copyWith(
          isAreasLoading: false,
          errorMessage: 'نشست کاربری منقضی شده است.',
        ),
      ),
      connectionError: () => emit(
        state.copyWith(
          isAreasLoading: false,
          errorMessage: 'اتصال به اینترنت برقرار نیست.',
        ),
      ),
    );
  }

  Future<void> fetchById(int id) async {
    emit(
      state.copyWith(
        isFormLoading: true,
        formLoadFailed: false,
        clearErrorMessage: true,
      ),
    );

    final result = await _getByIdUseCase(
      DeploymentLocationIdParamEntity(id: id),
    );

    result.when(
      success: (item, failures, resultCode) => emit(
        state.copyWith(
          formLocation: item,
          isFormLoading: false,
          formLoadFailed: false,
          clearErrorMessage: true,
        ),
      ),
      failure: (error, failures) => emit(
        state.copyWith(
          isFormLoading: false,
          formLoadFailed: true,
          errorMessage:
              failures ?? 'دریافت اطلاعات محل استقرار با خطا مواجه شد.',
        ),
      ),
      expireToken: () => emit(
        state.copyWith(
          isFormLoading: false,
          formLoadFailed: true,
          errorMessage: 'نشست کاربری منقضی شده است.',
        ),
      ),
      connectionError: () => emit(
        state.copyWith(
          isFormLoading: false,
          formLoadFailed: true,
          errorMessage: 'اتصال به اینترنت برقرار نیست.',
        ),
      ),
    );
  }

  Future<bool> submitForm(DeploymentLocationFormParamEntity param) async {
    if (state.isFormSubmitting) return false;
    emit(
      state.copyWith(
        isFormSubmitting: true,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );

    final result = param.id == null
        ? await _createUseCase(param)
        : await _updateUseCase(param);
    var success = false;

    result.when(
      success: (data, failures, resultCode) {
        success = true;
        emit(
          state.copyWith(
            isFormSubmitting: false,
            clearErrorMessage: true,
          ),
        );
      },
      failure: (error, failures) => emit(
        state.copyWith(
          isFormSubmitting: false,
          errorMessage: failures ?? 'ثبت محل استقرار با خطا مواجه شد.',
        ),
      ),
      expireToken: () => emit(
        state.copyWith(
          isFormSubmitting: false,
          errorMessage: 'نشست کاربری منقضی شده است.',
        ),
      ),
      connectionError: () => emit(
        state.copyWith(
          isFormSubmitting: false,
          errorMessage: 'اتصال به اینترنت برقرار نیست.',
        ),
      ),
    );
    return success;
  }

  Future<bool> deleteLocation(DeploymentLocationEntity item) async {
    final id = item.id;
    if (id == null || state.isDeleting) return false;

    emit(
      state.copyWith(
        isDeleting: true,
        deletingId: id,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );

    var success = false;
    final result = await _deleteUseCase(
      DeploymentLocationIdParamEntity(id: id),
    );

    result.when(
      success: (data, failures, resultCode) {
        success = true;
        final records = state.records
            .where((record) => record.id != id)
            .toList(growable: false);
        emit(
          state.copyWith(
            status: records.isEmpty
                ? DeploymentLocationViewStatus.empty
                : DeploymentLocationViewStatus.loaded,
            records: records,
            totalCount: math.max(0, state.totalCount - 1),
            isDeleting: false,
            clearDeletingId: true,
            successMessage: 'محل استقرار حذف شد.',
          ),
        );
      },
      failure: (error, failures) => emit(
        state.copyWith(
          isDeleting: false,
          clearDeletingId: true,
          errorMessage: failures ?? 'حذف محل استقرار با خطا مواجه شد.',
        ),
      ),
      expireToken: () => emit(
        state.copyWith(
          isDeleting: false,
          clearDeletingId: true,
          errorMessage: 'نشست کاربری منقضی شده است.',
        ),
      ),
      connectionError: () => emit(
        state.copyWith(
          isDeleting: false,
          clearDeletingId: true,
          errorMessage: 'اتصال به اینترنت برقرار نیست.',
        ),
      ),
    );
    return success;
  }

  Future<void> exportReport() async {
    if (state.isReportLoading) return;

    emit(state.copyWith(
      isReportLoading: true,
      clearErrorMessage: true,
      clearSuccessMessage: true,
    ));

    final result = await _getListUseCase(
      _buildFilterParam(
        skip: 0,
        pageSize: 0,
        isActiveOverride: state.pageStatusFilter ?? state.isActiveFilter,
      ),
    );

    await result.when<Future<void>>(
      success: (page, failures, resultCode) async {
        if (page.records.isEmpty) {
          emit(state.copyWith(
            isReportLoading: false,
            errorMessage: 'داده‌ای برای تهیه گزارش وجود ندارد.',
          ));
          return;
        }

        final exportResult = await _exportExcelUseCase(
          DeploymentLocationExcelReportFactory.create(page.records),
        );
        exportResult.when(
          success: (data, failures, resultCode) => emit(state.copyWith(
            isReportLoading: false,
            successMessage: data.isBrowserDownload
                ? 'دانلود فایل گزارش آغاز شد.'
                : 'فایل گزارش با موفقیت ذخیره شد.',
            clearErrorMessage: true,
          )),
          failure: (error, failures) => emit(state.copyWith(
            isReportLoading: false,
            errorMessage: failures ?? 'ذخیره فایل گزارش با خطا مواجه شد.',
          )),
          expireToken: () => emit(state.copyWith(
            isReportLoading: false,
            errorMessage: 'نشست کاربری منقضی شده است.',
          )),
          connectionError: () => emit(state.copyWith(
            isReportLoading: false,
            errorMessage: 'ذخیره فایل گزارش با خطا مواجه شد.',
          )),
        );
      },
      failure: (error, failures) async => emit(state.copyWith(
        isReportLoading: false,
        errorMessage: failures ?? 'دریافت گزارش محل‌های استقرار ناموفق بود.',
      )),
      expireToken: () async => emit(state.copyWith(
        isReportLoading: false,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () async => emit(state.copyWith(
        isReportLoading: false,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );
  }
  DeploymentLocationFilterParamEntity _buildFilterParam({
    required int skip,
    required int pageSize,
    bool? isActiveOverride,
  }) {
    return DeploymentLocationFilterParamEntity(
      skip: skip,
      pageSize: pageSize,
      title: state.titleFilter,
      provinceTitle: state.provinceTitleFilter,
      cityTitle: state.cityTitleFilter,
      address: state.addressFilter,
      isActive: isActiveOverride ?? state.isActiveFilter,
    );
  }

  void clearErrorMessage() {
    emit(state.copyWith(clearErrorMessage: true));
  }

  void clearSuccessMessage() {
    emit(state.copyWith(clearSuccessMessage: true));
  }
}
