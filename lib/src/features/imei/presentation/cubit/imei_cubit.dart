import 'package:eks_sana_plus_org/src/features/imei/domain/entities/device_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/imei_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/params/imei_info_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/params/imei_info_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/params/imei_info_mutation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/usecases/add_imei_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/usecases/delete_imei_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/usecases/get_device_info_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/usecases/get_imei_info_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/usecases/get_imei_info_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/usecases/update_imei_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/imei/presentation/cubit/imei_state.dart';
import 'package:eks_sana_plus_org/src/features/imei/presentation/util/imei_excel_exporter.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ImeiCubit extends Cubit<ImeiState> {
  ImeiCubit(
    this._getListUseCase,
    this._getDeviceInfoListUseCase,
    this._getByIdUseCase,
    this._addUseCase,
    this._updateUseCase,
    this._deleteUseCase,
  ) : super(const ImeiState());

  static const int _pageSize = 10;

  final GetImeiInfoListUseCase _getListUseCase;
  final GetDeviceInfoListUseCase _getDeviceInfoListUseCase;
  final GetImeiInfoByIdUseCase _getByIdUseCase;
  final AddImeiInfoUseCase _addUseCase;
  final UpdateImeiInfoUseCase _updateUseCase;
  final DeleteImeiInfoUseCase _deleteUseCase;

  final filterSimNumberController = TextEditingController();
  final filterAvlSerialController = TextEditingController();
  final filterImeiController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final simNumberController = TextEditingController();
  final avlSerialController = TextEditingController();
  final imeiController = TextEditingController();

  DeviceInfoEntity? selectedFilterDevice;
  bool? selectedFilterStatus;

  Future<void> init() async {
    await Future.wait([
      fetchDeviceTypes(),
      fetchList(refresh: true),
    ]);
  }

  Future<void> initForm({ImeiInfoEntity? item}) async {
    await fetchDeviceTypes();
    if (item == null) {
      prepareAddForm();
      return;
    }

    await fetchDetailForEdit(item);
  }

  Future<void> fetchDeviceTypes() async {
    if (state.isDeviceTypesLoading) return;

    emit(state.copyWith(
      isDeviceTypesLoading: true,
      clearErrorMessage: true,
    ));

    final result = await _getDeviceInfoListUseCase();
    result.when(
      success: (items, failures, resultCode) {
        emit(state.copyWith(
          deviceTypes: items,
          isDeviceTypesLoading: false,
          clearErrorMessage: true,
        ));
      },
      failure: (error, failures) => emit(state.copyWith(
        isDeviceTypesLoading: false,
        errorMessage: failures ?? 'دریافت لیست نوع دستگاه با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        isDeviceTypesLoading: false,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        isDeviceTypesLoading: false,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );
  }

  Future<void> fetchList({bool refresh = false}) async {
    if (state.isInitialLoading || state.isLoadingMore) return;

    final skip = refresh ? 0 : state.records.length;
    final filter = state.filter.copyWith(
      pageSize: _pageSize,
      skip: skip,
    );

    emit(state.copyWith(
      status: refresh || state.records.isEmpty
          ? ImeiViewStatus.loading
          : ImeiViewStatus.loadingMore,
      filter: filter,
      clearErrorMessage: true,
      clearSuccessMessage: true,
      clearReportPath: true,
    ));

    final result = await _getListUseCase(filter);
    result.when(
      success: (page, failures, resultCode) {
        final records = refresh
            ? page.records
            : <ImeiInfoEntity>[...state.records, ...page.records];

        emit(state.copyWith(
          status: records.isEmpty ? ImeiViewStatus.empty : ImeiViewStatus.loaded,
          records: records,
          totalCount: page.count,
          filter: filter,
          clearErrorMessage: true,
        ));
      },
      failure: (error, failures) => emit(state.copyWith(
        status: ImeiViewStatus.failure,
        errorMessage: failures ?? 'دریافت لیست IMEI با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        status: ImeiViewStatus.failure,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        status: ImeiViewStatus.connectionError,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;
    await fetchList();
  }

  Future<void> applyFilters() async {
    final filter = ImeiInfoFilterParamEntity(
      simNumber: filterSimNumberController.text.trim(),
      avlSerial: filterAvlSerialController.text.trim(),
      imei: filterImeiController.text.trim(),
      deviceId: selectedFilterDevice?.id,
      isActive: selectedFilterStatus,
      pageSize: _pageSize,
      skip: 0,
    );

    emit(state.copyWith(filter: filter));
    await fetchList(refresh: true);
  }

  Future<void> clearFilters() async {
    filterSimNumberController.clear();
    filterAvlSerialController.clear();
    filterImeiController.clear();
    selectedFilterDevice = null;
    selectedFilterStatus = null;

    emit(state.copyWith(
      filter: const ImeiInfoFilterParamEntity(pageSize: _pageSize),
      clearPageStatusFilter: true,
    ));
    await fetchList(refresh: true);
  }

  void setPageStatusFilter(bool? value) {
    emit(state.copyWith(
      pageStatusFilter: value,
      clearPageStatusFilter: value == null,
    ));
  }

  Future<ImeiInfoEntity?> fetchDetailForEdit(ImeiInfoEntity item) async {
    final id = item.id;
    if (id == null || state.isGettingDetail) return null;

    emit(state.copyWith(
      isGettingDetail: true,
      clearErrorMessage: true,
    ));

    ImeiInfoEntity? fetchedItem;
    final result = await _getByIdUseCase(ImeiInfoIdParamEntity(id: id));
    result.when(
      success: (data, failures, resultCode) {
        fetchedItem = data;
        _fillForm(data);
        emit(state.copyWith(
          selectedItem: data,
          isGettingDetail: false,
          clearErrorMessage: true,
        ));
      },
      failure: (error, failures) => emit(state.copyWith(
        isGettingDetail: false,
        errorMessage: failures ?? 'دریافت اطلاعات IMEI با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        isGettingDetail: false,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        isGettingDetail: false,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );

    return fetchedItem;
  }

  void prepareAddForm() {
    formKey.currentState?.reset();
    simNumberController.clear();
    avlSerialController.clear();
    imeiController.clear();

    emit(state.copyWith(
      clearSelectedItem: true,
      clearSelectedFormDevice: true,
      selectedFormStatus: true,
      clearErrorMessage: true,
      clearSuccessMessage: true,
    ));
  }

  void setFormDevice(DeviceInfoEntity? value) {
    emit(state.copyWith(selectedFormDevice: value));
  }

  void setFormStatus(bool value) {
    emit(state.copyWith(selectedFormStatus: value));
  }

  void setFilterDevice(DeviceInfoEntity? value) {
    selectedFilterDevice = value;
  }

  void setFilterStatus(bool? value) {
    selectedFilterStatus = value;
  }

  Future<bool> submitForm({
    required bool isEdit,
    bool refreshAfterSuccess = true,
  }) async {
    if (state.isSubmitting) return false;
    if (formKey.currentState?.validate() != true) return false;

    final deviceId = state.selectedFormDevice?.id;
    if (deviceId == null) {
      emit(state.copyWith(errorMessage: 'نوع دستگاه را انتخاب کنید.'));
      return false;
    }

    final selectedId = state.selectedItem?.id;
    if (isEdit && selectedId == null) {
      emit(state.copyWith(errorMessage: 'شناسه IMEI معتبر نیست.'));
      return false;
    }

    emit(state.copyWith(
      isSubmitting: true,
      clearErrorMessage: true,
      clearSuccessMessage: true,
    ));

    final param = ImeiInfoMutationParamEntity(
      id: isEdit ? selectedId : null,
      simNumber: simNumberController.text.trim(),
      deviceId: deviceId,
      imei: imeiController.text.trim(),
      avlSerial: avlSerialController.text.trim(),
      isActive: state.selectedFormStatus,
    );

    final result = isEdit ? await _updateUseCase(param) : await _addUseCase(param);
    var success = false;
    result.when(
      success: (data, failures, resultCode) {
        success = true;
        emit(state.copyWith(
          isSubmitting: false,
          successMessage: isEdit
              ? 'IMEI با موفقیت ویرایش شد.'
              : 'IMEI با موفقیت ثبت شد.',
          clearErrorMessage: true,
        ));
      },
      failure: (error, failures) => emit(state.copyWith(
        isSubmitting: false,
        errorMessage: failures ?? 'ثبت اطلاعات IMEI با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        isSubmitting: false,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        isSubmitting: false,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );

    if (success && refreshAfterSuccess) {
      await fetchList(refresh: true);
    }
    return success;
  }

  Future<void> deleteItem(ImeiInfoEntity item) async {
    final id = item.id;
    if (id == null || state.isDeleting) return;

    emit(state.copyWith(
      isDeleting: true,
      clearErrorMessage: true,
      clearSuccessMessage: true,
    ));

    final result = await _deleteUseCase(ImeiInfoIdParamEntity(id: id));
    var success = false;
    result.when(
      success: (data, failures, resultCode) {
        success = true;
        emit(state.copyWith(
          isDeleting: false,
          successMessage: 'IMEI با موفقیت حذف شد.',
          clearErrorMessage: true,
        ));
      },
      failure: (error, failures) => emit(state.copyWith(
        isDeleting: false,
        errorMessage: failures ?? 'حذف IMEI با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        isDeleting: false,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        isDeleting: false,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );

    if (success) await fetchList(refresh: true);
  }

  Future<void> exportReport() async {
    if (state.isReporting) return;

    emit(state.copyWith(
      isReporting: true,
      clearErrorMessage: true,
      clearSuccessMessage: true,
      clearReportPath: true,
    ));

    final result = await _getListUseCase(
      state.filter.copyWith(
        skip: 0,
        pageSize: state.totalCount > 0 ? state.totalCount : 10000,
      ),
    );

    List<ImeiInfoEntity>? reportItems;
    result.when(
      success: (page, failures, resultCode) {
        reportItems = page.records;
      },
      failure: (error, failures) => emit(state.copyWith(
        isReporting: false,
        errorMessage: failures ?? 'گزارش‌گیری با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        isReporting: false,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        isReporting: false,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );

    final items = reportItems;
    if (items == null) return;

    final path = await ImeiExcelExporter.export(items);
    emit(state.copyWith(
      isReporting: false,
      reportPath: path,
      successMessage: 'گزارش IMEI با موفقیت ذخیره شد.',
      clearErrorMessage: true,
    ));
  }

  String? validateRequired(String? value) {
    return value?.trim().isNotEmpty == true ? null : 'این فیلد اجباری است';
  }

  void _fillForm(ImeiInfoEntity item) {
    simNumberController.text = item.simNumber ?? '';
    avlSerialController.text = item.avlSerial ?? '';
    imeiController.text = item.imei ?? '';
    DeviceInfoEntity? device;
    for (final itemDevice in state.deviceTypes) {
      if (itemDevice.id == item.deviceId) {
        device = itemDevice;
        break;
      }
    }
    emit(state.copyWith(
      selectedFormDevice: device,
      selectedFormStatus: item.isActive ?? true,
    ));
  }

  @override
  Future<void> close() {
    filterSimNumberController.dispose();
    filterAvlSerialController.dispose();
    filterImeiController.dispose();
    simNumberController.dispose();
    avlSerialController.dispose();
    imeiController.dispose();
    return super.close();
  }
}
