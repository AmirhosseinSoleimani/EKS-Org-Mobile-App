import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/add_agency_vehicle_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/vehicle_info_search_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/vehicle_info_search_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/add_agency_vehicle_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/search_vehicle_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/add_vehicle/add_agency_vehicle_state.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

@injectable
class AddAgencyVehicleCubit extends Cubit<AddAgencyVehicleState> {
  AddAgencyVehicleCubit(
    this._searchVehicleInfoUseCase,
    this._addAgencyVehicleUseCase,
  ) : super(const AddAgencyVehicleState()) {
    searchController.addListener(_keepSearchSingleLine);
  }

  final SearchVehicleInfoUseCase _searchVehicleInfoUseCase;
  final AddAgencyVehicleUseCase _addAgencyVehicleUseCase;

  final formKey = GlobalKey<FormState>();
  final searchController = TextEditingController();
  final contractCodeController = TextEditingController();
  final contractStartDateController = TextEditingController();
  final contractEndDateController = TextEditingController();
  final startBimeDateController = TextEditingController();
  final endBimeDateController = TextEditingController();
  final installTypeDateController = TextEditingController();
  final labelAgencyCodeController = TextEditingController();

  String? contractStartDateApi;
  String? contractEndDateApi;
  String? startBimeDateApi;
  String? endBimeDateApi;
  String? installTypeDateApi;

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
    contractStartDateApi = _apiDate(value.toDateTime());
  }

  void setContractEndDate(Jalali? value) {
    if (value == null) return;
    contractEndDateApi = _apiDate(value.toDateTime());
  }

  void setStartBimeDate(Jalali? value) {
    if (value == null) return;
    startBimeDateApi = _apiDate(value.toDateTime());
  }

  void setEndBimeDate(Jalali? value) {
    if (value == null) return;
    endBimeDateApi = _apiDate(value.toDateTime());
  }

  void setInstallTypeDate(Jalali? value) {
    if (value == null) return;
    installTypeDateApi = _apiDate(value.toDateTime());
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
        replacementDate: installTypeDateApi,
        labelAgencyCode: labelAgencyCodeController.text.trim(),
        contractType: state.contractType,
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
  Future<void> close() {
    searchController.removeListener(_keepSearchSingleLine);
    searchController.dispose();
    contractCodeController.dispose();
    contractStartDateController.dispose();
    contractEndDateController.dispose();
    startBimeDateController.dispose();
    endBimeDateController.dispose();
    installTypeDateController.dispose();
    labelAgencyCodeController.dispose();
    return super.close();
  }

  String _apiDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}
