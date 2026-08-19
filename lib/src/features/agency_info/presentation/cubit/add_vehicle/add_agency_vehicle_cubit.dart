import 'dart:async';

import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/add_agency_vehicle_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/vehicle_info_search_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/vehicle_info_search_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/add_agency_vehicle_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/search_vehicle_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/add_vehicle/add_agency_vehicle_state.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_enum_item_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/manager/current_session_manager.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/use_cases/sync_current_session_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

@injectable
class AddAgencyVehicleCubit extends Cubit<AddAgencyVehicleState> {
  AddAgencyVehicleCubit(
    this._searchVehicleInfoUseCase,
    this._addAgencyVehicleUseCase,
    this._currentSessionManager,
    this._syncCurrentSessionUseCase,
  ) : super(const AddAgencyVehicleState()) {
    searchController.addListener(_keepSearchSingleLine);
    _sessionSubscription = _currentSessionManager.currentSessionStream.listen(
      _applyContractTypes,
    );
    unawaited(_loadContractTypes());
  }

  final SearchVehicleInfoUseCase _searchVehicleInfoUseCase;
  final AddAgencyVehicleUseCase _addAgencyVehicleUseCase;
  final CurrentSessionManager _currentSessionManager;
  final SyncCurrentSessionUseCase _syncCurrentSessionUseCase;
  StreamSubscription<CurrentSessionEntity?>? _sessionSubscription;

  final formKey = GlobalKey<FormState>();
  final searchController = TextEditingController();
  final contractCodeController = TextEditingController();
  final contractStartDateController = TextEditingController();
  final contractEndDateController = TextEditingController();
  final startBimeDateController = TextEditingController();
  final endBimeDateController = TextEditingController();
  final replacementDateController = TextEditingController();
  final labelAgencyCodeController = TextEditingController();

  String? contractStartDateApi;
  String? contractEndDateApi;
  String? startBimeDateApi;
  String? endBimeDateApi;
  String? replacementDateApi;

  Future<void> _loadContractTypes() async {
    if (_applyContractTypes(_currentSessionManager.currentSession)) return;

    final syncResult = await _syncCurrentSessionUseCase(
      clearOnFailure: false,
      forceRefresh: true,
      maxAge: Duration.zero,
      minRequestInterval: Duration.zero,
    );

    if (isClosed) return;
    _applyContractTypes(
      syncResult.session ?? _currentSessionManager.currentSession,
    );
  }

  bool _applyContractTypes(CurrentSessionEntity? session) {
    final items = session?.enums?.agencyVehicleContractType ??
        const <CurrentSessionEnumItemEntity>[];
    if (isClosed) return items.isNotEmpty;

    final selectedValue = _selectedContractTypeValue(items);
    emit(state.copyWith(
      contractTypeItems: items,
      contractType: selectedValue,
      clearErrorMessage: true,
    ));

    return items.isNotEmpty;
  }

  int? _selectedContractTypeValue(
    List<CurrentSessionEnumItemEntity> items,
  ) {
    if (items.isEmpty) return state.contractType;

    final currentValue = state.contractType;
    if (currentValue != null &&
        items.any((item) => item.value == currentValue)) {
      return currentValue;
    }

    for (final item in items) {
      final value = item.value;
      if (value != null) return value;
    }

    return null;
  }

  void _keepSearchSingleLine() {
    final text = searchController.text;
    if (!text.contains('\n')) return;

    final normalized = text.replaceAll('\n', ' ').trimLeft();
    searchController.value = TextEditingValue(
      text: normalized,
      selection: TextSelection.collapsed(offset: normalized.length),
    );
  }

  Future<void> search() async {
    final query = searchController.text.trim();
    if (query.isEmpty || state.isSearching) return;

    emit(state.copyWith(
      status: AddAgencyVehicleStatus.searching,
      clearErrorMessage: true,
    ));

    final result = await _searchVehicleInfoUseCase(
      VehicleInfoSearchParamEntity(searchValue: query),
    );

    result.when(
      success: (data, failures, resultCode) {
        final records = data.records ?? const <VehicleInfoSearchEntity>[];
        emit(state.copyWith(
          status: records.isEmpty
              ? AddAgencyVehicleStatus.searchEmpty
              : AddAgencyVehicleStatus.searchLoaded,
          vehicles: records,
          searchCount: (data.count ?? 0) > 0 ? data.count! : records.length,
          clearErrorMessage: true,
        ));
      },
      failure: (error, failures) => emit(state.copyWith(
        status: AddAgencyVehicleStatus.failure,
        errorMessage: failures ?? 'جستجوی خودرو با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        status: AddAgencyVehicleStatus.failure,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        status: AddAgencyVehicleStatus.connectionError,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );
  }

  void selectVehicle(VehicleInfoSearchEntity vehicle) {
    emit(state.copyWith(
      selectedVehicle: vehicle,
      clearErrorMessage: true,
    ));
  }

  void setContractStartDate(Jalali? value) {
    if (value == null) return;
    contractStartDateApi = JalaliDateHelper.formatServerDateOnly(value.toDateTime());
  }

  void setContractEndDate(Jalali? value) {
    if (value == null) return;
    contractEndDateApi = JalaliDateHelper.formatServerDateOnly(value.toDateTime());
  }

  void setStartBimeDate(Jalali? value) {
    if (value == null) return;
    startBimeDateApi = JalaliDateHelper.formatServerDateOnly(value.toDateTime());
  }

  void setEndBimeDate(Jalali? value) {
    if (value == null) return;
    endBimeDateApi = JalaliDateHelper.formatServerDateOnly(value.toDateTime());
  }

  void setReplacementDate(Jalali? value) {
    if (value == null) return;
    replacementDateApi = JalaliDateHelper.formatServerDateOnly(value.toDateTime());
  }

  void setContractType(int value) {
    emit(state.copyWith(contractType: value, clearErrorMessage: true));
  }

  void setIsActive(bool value) {
    emit(state.copyWith(isActive: value, clearErrorMessage: true));
  }

  Future<void> submit(AgencyInfoEntity agency) async {
    if (state.isSubmitting) return;

    final agencyId = agency.id;
    final vehicleId = state.selectedVehicle?.id;
    if (agencyId == null || vehicleId == null) {
      emit(state.copyWith(
        status: AddAgencyVehicleStatus.failure,
        errorMessage: 'شناسه نمایندگی یا خودرو معتبر نیست.',
      ));
      return;
    }

    if (formKey.currentState?.validate() != true) return;

    final contractType = state.contractType;
    if (contractType == null) return;

    emit(state.copyWith(
      status: AddAgencyVehicleStatus.submitting,
      clearErrorMessage: true,
    ));

    final result = await _addAgencyVehicleUseCase(
      AddAgencyVehicleParamEntity(
        agencyInfoId: agencyId,
        vehicleInfoId: vehicleId,
        contractCode: contractCodeController.text.trim(),
        contractStartDate: contractStartDateApi ?? '',
        contractEndDate: contractEndDateApi,
        startBimeDate: startBimeDateApi,
        endBimeDate: endBimeDateApi,
        replacementDate: replacementDateApi,
        labelAgencyCode: labelAgencyCodeController.text.trim(),
        contractType: contractType,
        isActive: state.isActive,
      ),
    );

    result.when(
      success: (data, failures, resultCode) {
        emit(state.copyWith(
          status: AddAgencyVehicleStatus.submitSuccess,
          createdId: data.id,
          clearErrorMessage: true,
        ));
      },
      failure: (error, failures) => emit(state.copyWith(
        status: AddAgencyVehicleStatus.failure,
        errorMessage: failures ?? 'ثبت خودرو با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        status: AddAgencyVehicleStatus.failure,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        status: AddAgencyVehicleStatus.connectionError,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );
  }

  String? validateRequired(String? value) {
    return value?.trim().isNotEmpty == true ? null : 'این فیلد اجباری است';
  }

  @override
  Future<void> close() async {
    await _sessionSubscription?.cancel();
    searchController.removeListener(_keepSearchSingleLine);
    searchController.dispose();
    contractCodeController.dispose();
    contractStartDateController.dispose();
    contractEndDateController.dispose();
    startBimeDateController.dispose();
    endBimeDateController.dispose();
    replacementDateController.dispose();
    labelAgencyCodeController.dispose();
    return super.close();
  }
}
