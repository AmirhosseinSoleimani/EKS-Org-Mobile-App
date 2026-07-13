import 'dart:convert';
import 'dart:io';

import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_person_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/lookup_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/assign_emdad_unit_person_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/change_emdad_unit_location_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/create_emdad_unit_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/emdad_unit_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/update_emdad_unit_image_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/use_cases/assign_emdad_unit_person_use_case.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/use_cases/change_emdad_unit_location_use_case.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/use_cases/create_emdad_unit_use_case.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/use_cases/delete_emdad_unit_person_use_case.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/use_cases/delete_emdad_unit_use_case.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/use_cases/get_emdad_unit_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/use_cases/get_emdad_unit_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/use_cases/get_emdad_unit_lookups_use_case.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/use_cases/get_emdad_unit_persons_use_case.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/use_cases/update_emdad_unit_image_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'emdad_unit_state.dart';

@injectable
class EmdadUnitCubit extends Cubit<EmdadUnitState> {
  EmdadUnitCubit(
    this._getListUseCase,
    this._getByIdUseCase,
    this._createUseCase,
    this._updateImageUseCase,
    this._deleteUseCase,
    this._getPersonsUseCase,
    this._assignPersonUseCase,
    this._deletePersonUseCase,
    this._changeLocationUseCase,
    this._lookupsUseCase,
  ) : super(const EmdadUnitState());

  final GetEmdadUnitListUseCase _getListUseCase;
  final GetEmdadUnitByIdUseCase _getByIdUseCase;
  final CreateEmdadUnitUseCase _createUseCase;
  final UpdateEmdadUnitImageUseCase _updateImageUseCase;
  final DeleteEmdadUnitUseCase _deleteUseCase;
  final GetEmdadUnitPersonsUseCase _getPersonsUseCase;
  final AssignEmdadUnitPersonUseCase _assignPersonUseCase;
  final DeleteEmdadUnitPersonUseCase _deletePersonUseCase;
  final ChangeEmdadUnitLocationUseCase _changeLocationUseCase;
  final GetEmdadUnitLookupsUseCase _lookupsUseCase;

  final nameController = TextEditingController();
  final agencyController = TextEditingController();
  final vehicleController = TextEditingController();
  final personController = TextEditingController();
  final locationController = TextEditingController();

  VoidCallback? _retryAction;
  static const int _pageSize = 10;
  static const int maxImageSize = 1024 * 1024;

  void retryLastAction() => _retryAction?.call();

  Future<void> fetchList({bool refresh = false}) async {
    if (state.status == EmdadUnitViewStatus.loading ||
        state.status == EmdadUnitViewStatus.loadingMore) {
      return;
    }

    _retryAction = () => fetchList(refresh: refresh);
    final nextSkip = refresh ? 0 : state.items.length;
    final filter = state.filter.copyWith(skip: nextSkip, pageSize: _pageSize);

    emit(state.copyWith(
      status: refresh || state.items.isEmpty
          ? EmdadUnitViewStatus.loading
          : EmdadUnitViewStatus.loadingMore,
      filter: filter,
      clearMessage: true,
    ));

    final result = await _getListUseCase(filter);
    result.when(
      success: (page, failures, resultCode) {
        final records = refresh ? page.records : [...state.items, ...page.records];
        emit(state.copyWith(
          status: records.isEmpty ? EmdadUnitViewStatus.empty : EmdadUnitViewStatus.loaded,
          items: records,
          totalCount: page.count,
          hasMore: records.length < page.count,
          filter: filter,
        ));
      },
      failure: (error, failures) => _emitFailure(failures),
      expireToken: () => _emitFailure('نشست کاربری منقضی شده است.'),
      connectionError: () => emit(state.copyWith(status: EmdadUnitViewStatus.connectionError)),
    );
  }

  Future<void> applyFilter(EmdadUnitFilterParamEntity filter) async {
    emit(state.copyWith(filter: filter.copyWith(skip: 0, pageSize: _pageSize)));
    await fetchList(refresh: true);
  }

  Future<void> clearFilter() async {
    nameController.clear();
    agencyController.clear();
    vehicleController.clear();
    personController.clear();
    locationController.clear();
    emit(state.copyWith(filter: const EmdadUnitFilterParamEntity(pageSize: _pageSize)));
    await fetchList(refresh: true);
  }

  Future<void> loadLookups({int? agencyInfoId}) async {
    if (state.isLookupsLoading) return;
    emit(state.copyWith(isLookupsLoading: true, clearMessage: true));

    final agencies = await _lookupsUseCase.getAgencies();
    final locations = await _lookupsUseCase.getActiveLocations();
    List<LookupEntity> persons = state.agencyPersons;
    List<LookupEntity> vehicles = state.agencyVehicles;

    if (agencyInfoId != null && agencyInfoId > 0) {
      final peopleResult = await _lookupsUseCase.getAgencyPersons(agencyInfoId);
      final vehiclesResult = await _lookupsUseCase.getAgencyVehicles(agencyInfoId);
      persons = peopleResult.maybeWhen(success: (data, failures, resultCode) => data, orElse: () => const []);
      vehicles = vehiclesResult.maybeWhen(success: (data, failures, resultCode) => data, orElse: () => const []);
    }

    final agencyList = agencies.maybeWhen(success: (data, failures, resultCode) => data, orElse: () => state.agencies);
    final locationList = locations.maybeWhen(success: (data, failures, resultCode) => data, orElse: () => state.locations);

    emit(state.copyWith(
      isLookupsLoading: false,
      agencies: agencyList,
      locations: locationList,
      agencyPersons: persons,
      agencyVehicles: vehicles,
    ));
  }

  Future<void> loadDetail(int id) async {
    _retryAction = () => loadDetail(id);
    emit(state.copyWith(status: EmdadUnitViewStatus.loading, clearMessage: true));
    final result = await _getByIdUseCase(id);
    result.when(
      success: (item, failures, resultCode) {
        emit(state.copyWith(status: EmdadUnitViewStatus.loaded, selectedItem: item));
      },
      failure: (error, failures) => _emitFailure(failures),
      expireToken: () => _emitFailure('نشست کاربری منقضی شده است.'),
      connectionError: () => emit(state.copyWith(status: EmdadUnitViewStatus.connectionError)),
    );
  }

  Future<bool> create(CreateEmdadUnitParamEntity param) async {
    if (state.status == EmdadUnitViewStatus.submitting) return false;
    emit(state.copyWith(status: EmdadUnitViewStatus.submitting, clearMessage: true));
    final result = await _createUseCase(param);
    return _handleSubmitResult(result, 'واحد امدادی با موفقیت ثبت شد');
  }

  Future<bool> updateImage(UpdateEmdadUnitImageParamEntity param) async {
    if (state.status == EmdadUnitViewStatus.submitting) return false;
    emit(state.copyWith(status: EmdadUnitViewStatus.submitting, clearMessage: true));
    final result = await _updateImageUseCase(param);
    return _handleSubmitResult(result, 'تصویر واحد امدادی با موفقیت ویرایش شد');
  }

  Future<bool> deleteItem(int id) async {
    if (state.status == EmdadUnitViewStatus.submitting) return false;
    emit(state.copyWith(status: EmdadUnitViewStatus.submitting, clearMessage: true));
    final result = await _deleteUseCase(id);
    final ok = _handleVoidResult(result, 'واحد امدادی با موفقیت حذف شد');
    if (ok) await fetchList(refresh: true);
    return ok;
  }

  Future<void> loadPersons(EmdadUnitEntity item) async {
    final id = item.id;
    if (id == null) return;
    emit(state.copyWith(status: EmdadUnitViewStatus.loading, selectedItem: item));
    await loadLookups(agencyInfoId: item.agencyInfoId);
    final result = await _getPersonsUseCase(id);
    result.when(
      success: (persons, failures, resultCode) {
        final primaryPersonId = item.agencyPersonId;
        final eligiblePersons = state.agencyPersons
            .where((person) => person.id != primaryPersonId)
            .toList();
        emit(state.copyWith(
          status: EmdadUnitViewStatus.loaded,
          persons: persons,
          agencyPersons: eligiblePersons,
        ));
      },
      failure: (error, failures) => _emitFailure(failures),
      expireToken: () => _emitFailure('نشست کاربری منقضی شده است.'),
      connectionError: () => emit(state.copyWith(status: EmdadUnitViewStatus.connectionError)),
    );
  }

  Future<bool> assignPerson(int agencyPersonId) async {
    final itemId = state.selectedItem?.id;
    if (itemId == null || state.status == EmdadUnitViewStatus.submitting) {
      return false;
    }
    emit(state.copyWith(status: EmdadUnitViewStatus.submitting, clearMessage: true));
    final result = await _assignPersonUseCase(
      AssignEmdadUnitPersonParamEntity(
        agencyPersonId: agencyPersonId,
        emdadUnitId: itemId,
      ),
    );
    final ok = _handleVoidResult(result, 'امدادرسان با موفقیت ثبت شد');
    if (ok && state.selectedItem != null) await loadPersons(state.selectedItem!);
    return ok;
  }

  Future<bool> deletePerson(int id) async {
    if (state.status == EmdadUnitViewStatus.submitting) return false;
    emit(state.copyWith(status: EmdadUnitViewStatus.submitting, clearMessage: true));
    final result = await _deletePersonUseCase(id);
    final ok = _handleVoidResult(result, 'امدادرسان با موفقیت حذف شد');
    if (ok && state.selectedItem != null) await loadPersons(state.selectedItem!);
    return ok;
  }

  Future<bool> changeLocation(ChangeEmdadUnitLocationParamEntity param) async {
    if (state.status == EmdadUnitViewStatus.submitting) return false;
    emit(state.copyWith(status: EmdadUnitViewStatus.submitting, clearMessage: true));
    final result = await _changeLocationUseCase(param);
    final ok = _handleVoidResult(result, 'عملیات با موفقیت انجام شد');
    if (ok) await fetchList(refresh: true);
    return ok;
  }

  Future<String?> imageFileToBase64(File file) async {
    final length = await file.length();
    if (length > maxImageSize) {
      return null;
    }
    final bytes = await file.readAsBytes();
    final extension = file.path.toLowerCase().endsWith('.png') ? 'png' : 'jpeg';
    return 'data:image/$extension;base64,${base64Encode(bytes)}';
  }

  bool _handleSubmitResult(ApiResult<EmdadUnitEntity> result, String successMessage) {
    return result.when(
      success: (data, failures, resultCode) {
        emit(state.copyWith(status: EmdadUnitViewStatus.success, message: successMessage));
        return true;
      },
      failure: (error, failures) {
        _emitFailure(failures);
        return false;
      },
      expireToken: () {
        _emitFailure('نشست کاربری منقضی شده است.');
        return false;
      },
      connectionError: () {
        emit(state.copyWith(status: EmdadUnitViewStatus.connectionError));
        return false;
      },
    );
  }

  bool _handleVoidResult(ApiResult<void> result, String successMessage) {
    return result.when(
      success: (data, failures, resultCode) {
        emit(state.copyWith(status: EmdadUnitViewStatus.success, message: successMessage));
        return true;
      },
      failure: (error, failures) {
        _emitFailure(failures);
        return false;
      },
      expireToken: () {
        _emitFailure('نشست کاربری منقضی شده است.');
        return false;
      },
      connectionError: () {
        emit(state.copyWith(status: EmdadUnitViewStatus.connectionError));
        return false;
      },
    );
  }

  void _emitFailure(String? message) {
    emit(state.copyWith(
      status: EmdadUnitViewStatus.failure,
      message: message?.trim().isNotEmpty == true
          ? message
          : 'عملیات با خطا مواجه شد.',
    ));
  }

  @override
  Future<void> close() {
    nameController.dispose();
    agencyController.dispose();
    vehicleController.dispose();
    personController.dispose();
    locationController.dispose();
    return super.close();
  }
}
