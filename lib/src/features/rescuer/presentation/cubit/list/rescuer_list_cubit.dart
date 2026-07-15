import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/params/get_rescuers_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/rescuer_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/use_cases/delete_rescuer_use_case.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/use_cases/get_rescuers_use_case.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/enums/rescuer_status_filter.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart'
    show ApiResultPatterns;
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'rescuer_list_cubit.freezed.dart';
part 'rescuer_list_state.dart';

@injectable
class RescuerListCubit extends Cubit<RescuerListState> {
  RescuerListCubit(
    this._getRescuersUseCase,
    this._deleteRescuerUseCase,
  ) : super(const RescuerListState.idle());

  final GetRescuersUseCase _getRescuersUseCase;
  final DeleteRescuerUseCase _deleteRescuerUseCase;

  static const int pageSize = 10;

  final nameController = TextEditingController();
  final nationalNumberController = TextEditingController();
  final mobileController = TextEditingController();
  final codeController = TextEditingController();

  final selectedStatusNotifier =
      ValueNotifier<RescuerStatusFilter>(RescuerStatusFilter.all);

  VoidCallback? _retryAction;

  bool get hasRetryAction => _retryAction != null;
  List<RescuerEntity> get items => state.data.items;
  List<RescuerEntity> get filteredItems => state.data.filteredItems;
  int? get deletingRescuerId => state.data.deletingRescuerId;

  void retryLastAction() => _retryAction?.call();

  Future<void> fetchRescuers() async {
    _retryAction = fetchRescuers;
    emit(RescuerListState.loading(data: state.data));

    final result = await _getRescuersUseCase(
      const GetRescuersParamEntity(pageSize: pageSize),
    );

    result.whenOrNull(
      success: (data, failures, resultCode) {
        final immutableItems = List<RescuerEntity>.unmodifiable(data);
        final updatedData = state.data.copyWith(
          items: immutableItems,
          filteredItems: _filterItems(immutableItems),
          deletingRescuerId: null,
        );
        _safeEmit(RescuerListState.loaded(data: updatedData));
      },
      failure: (error, message) {
        _safeEmit(
          RescuerListState.error(
            data: state.data,
            message: _buildErrorMessage(
              title: 'خطا در دریافت امدادرسان‌ها',
              message: message ??
                  error?.toString() ??
                  'دریافت لیست امدادرسان‌ها با خطا مواجه شد.',
            ),
          ),
        );
      },
      connectionError: () {
        _safeEmit(RescuerListState.connectionError(data: state.data));
      },
    );
  }

  void setSelectedStatus(RescuerStatusFilter status) {
    selectedStatusNotifier.value = status;
    _emitFilteredData(selectedStatus: status);
  }

  void applyFilters() {
    _emitFilteredData();
  }

  void clearFilters() {
    nameController.clear();
    nationalNumberController.clear();
    mobileController.clear();
    codeController.clear();
    selectedStatusNotifier.value = RescuerStatusFilter.all;
    _emitFilteredData(selectedStatus: RescuerStatusFilter.all);
  }

  Future<bool> deleteRescuer(int id) async {
    if (state.data.deletingRescuerId != null) return false;

    _retryAction = () {
      deleteRescuer(id);
    };

    emit(
      RescuerListState.actionLoading(
        data: state.data.copyWith(deletingRescuerId: id),
      ),
    );

    var isSuccessful = false;
    final result = await _deleteRescuerUseCase(id);

    result.whenOrNull(
      success: (data, failures, resultCode) {
        isSuccessful = true;
        final updatedItems = state.data.items
            .where((item) => item.id != id)
            .toList(growable: false);
        final updatedData = state.data.copyWith(
          items: List<RescuerEntity>.unmodifiable(updatedItems),
          filteredItems: _filterItems(updatedItems),
          deletingRescuerId: null,
        );
        _safeEmit(RescuerListState.loaded(data: updatedData));
      },
      failure: (error, message) {
        _safeEmit(
          RescuerListState.actionError(
            data: state.data.copyWith(deletingRescuerId: null),
            message: message ??
                error?.toString() ??
                'حذف امدادرسان با خطا مواجه شد.',
          ),
        );
      },
      connectionError: () {
        _safeEmit(
          RescuerListState.actionError(
            data: state.data.copyWith(deletingRescuerId: null),
            message: 'اتصال اینترنت خود را بررسی کنید.',
          ),
        );
      },
    );

    return isSuccessful;
  }

  void _emitFilteredData({RescuerStatusFilter? selectedStatus}) {
    final status = selectedStatus ?? selectedStatusNotifier.value;
    final updatedData = state.data.copyWith(
      selectedStatus: status,
      filteredItems: _filterItems(state.data.items, selectedStatus: status),
    );
    _safeEmit(RescuerListState.loaded(data: updatedData));
  }

  List<RescuerEntity> _filterItems(
    List<RescuerEntity> source, {
    RescuerStatusFilter? selectedStatus,
  }) {
    final name = nameController.text.trim().toLowerCase();
    final nationalNumber = nationalNumberController.text.trim();
    final mobile = mobileController.text.trim();
    final code = codeController.text.trim();
    final status = selectedStatus ?? selectedStatusNotifier.value;

    return List<RescuerEntity>.unmodifiable(
      source.where((item) {
        final matchesName =
            name.isEmpty || item.fullName.toLowerCase().contains(name);
        final matchesNationalNumber = nationalNumber.isEmpty ||
            (item.nationalNumber ?? '').contains(nationalNumber);
        final normalizedMobile = (item.mobile ?? '').replaceFirst('+98', '0');
        final matchesMobile =
            mobile.isEmpty || normalizedMobile.contains(mobile);
        final matchesCode = code.isEmpty || (item.code ?? '').contains(code);

        return matchesName &&
            matchesNationalNumber &&
            matchesMobile &&
            matchesCode &&
            status.matches(item);
      }),
    );
  }

  BottomSheetMessageModel _buildErrorMessage({
    required String title,
    required String message,
  }) {
    return BottomSheetMessageModel(
      title: title,
      message: message,
    );
  }

  void _safeEmit(RescuerListState nextState) {
    if (!isClosed) emit(nextState);
  }

  @override
  Future<void> close() {
    nameController.dispose();
    nationalNumberController.dispose();
    mobileController.dispose();
    codeController.dispose();
    selectedStatusNotifier.dispose();
    return super.close();
  }
}
