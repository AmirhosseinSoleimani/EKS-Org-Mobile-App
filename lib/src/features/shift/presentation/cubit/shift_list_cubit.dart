import 'dart:io';

import 'package:eks_sana_plus_org/src/features/shift/domain/entities/params/shift_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/entities/shift_entity.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/use_cases/delete_shift_use_case.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/use_cases/get_shift_list_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_enum_item_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/manager/current_session_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

part 'shift_list_cubit.freezed.dart';
part 'shift_list_state.dart';

enum ShiftListAction { delete, report }

@injectable
class ShiftListCubit extends Cubit<ShiftListState> {
  ShiftListCubit(
    this._getListUseCase,
    this._deleteUseCase,
    this._currentSessionManager,
  ) : super(const ShiftListState.initial());

  static const int _pageSize = 10;
  bool _isExporting = false;
  final GetShiftListUseCase _getListUseCase;
  final DeleteShiftUseCase _deleteUseCase;
  final CurrentSessionManager _currentSessionManager;

  List<ShiftEntity> items = [];
  int totalCount = 0;
  bool hasMore = true;
  int? deletingItemId;
  bool _isFetching = false;

  ShiftFilterParamEntity filter =
      const ShiftFilterParamEntity(pageSize: _pageSize);

  List<CurrentSessionEnumItemEntity> get shiftTypes {
    return _currentSessionManager.currentSession?.enums?.shiftType ??
        const <CurrentSessionEnumItemEntity>[];
  }

  Future<void> fetchList({bool refresh = false}) async {
    if (_isFetching) return;
    _isFetching = true;

    final nextSkip = refresh ? 0 : items.length;
    filter = filter.copyWith(skip: nextSkip, pageSize: _pageSize);

    if (refresh || items.isEmpty) {
      _safeEmit(ShiftListState.loading(filter: filter));
    } else {
      _safeEmit(ShiftListState.loadingMore(
        items: items,
        totalCount: totalCount,
        filter: filter,
      ));
    }

    final result = await _getListUseCase(filter);
    result.when(
      success: (page, failures, resultCode) {
        items = refresh ? page.records : [...items, ...page.records];
        totalCount = page.count;
        hasMore = items.length < totalCount;
        _isFetching = false;

        if (items.isEmpty) {
          _safeEmit(ShiftListState.empty(filter: filter));
        } else {
          _safeEmit(ShiftListState.loaded(
            items: items,
            totalCount: totalCount,
            hasMore: hasMore,
            filter: filter,
          ));
        }
      },
      failure: (error, failures) {
        _isFetching = false;
        _emitFailure(failures);
      },
      expireToken: () {
        _isFetching = false;
        _emitFailure('نشست کاربری منقضی شده است.');
      },
      connectionError: () {
        _isFetching = false;
        _safeEmit(ShiftListState.connectionError(
          filter: filter,
          items: items,
        ));
      },
    );
  }

  Future<void> applyFilter(ShiftFilterParamEntity value) async {
    filter = value.copyWith(skip: 0, pageSize: _pageSize);
    await fetchList(refresh: true);
  }

  Future<void> clearFilter() async {
    filter = const ShiftFilterParamEntity(pageSize: _pageSize);
    await fetchList(refresh: true);
  }

  Future<bool> deleteItem(int id) async {
    if (deletingItemId != null) return false;

    deletingItemId = id;
    _safeEmit(ShiftListState.deleting(items: items, deletingItemId: id));
    final result = await _deleteUseCase(id);

    return result.when(
      success: (data, failures, resultCode) async {
        deletingItemId = null;
        _safeEmit(const ShiftListState.success(
          action: ShiftListAction.delete,
          message: 'شیفت با موفقیت حذف شد',
        ));
        await _reloadAfterDelete();
        return true;
      },
      failure: (error, failures) {
        deletingItemId = null;
        _emitFailure(failures);
        return false;
      },
      expireToken: () {
        deletingItemId = null;
        _emitFailure('نشست کاربری منقضی شده است.');
        return false;
      },
      connectionError: () {
        deletingItemId = null;
        _safeEmit(ShiftListState.connectionError(
          filter: filter,
          items: items,
        ));
        return false;
      },
    );
  }

  Future<void> _reloadAfterDelete() async {
    final nextSkip = items.length == 1 && filter.skip > 0
        ? (filter.skip - _pageSize).clamp(0, filter.skip)
        : 0;
    filter = filter.copyWith(skip: nextSkip);
    await fetchList(refresh: true);
  }

  void _emitFailure(String? message) {
    _safeEmit(ShiftListState.failure(
      message: message?.trim().isNotEmpty == true
          ? message!
          : 'درخواست شما با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید',
      items: items,
    ));
  }

  void _safeEmit(ShiftListState state) {
    if (!isClosed) emit(state);
  }

  Future<void> exportReport() async {
    if (_isExporting) return;
    _isExporting = true;
    _safeEmit(ShiftListState.exporting(items: items, filter: filter));

    final allItems = <ShiftEntity>[];
    var skip = 0;
    const reportPageSize = 1000;

    while (true) {
      final result = await _getListUseCase(filter.copyWith(
        skip: skip,
        pageSize: reportPageSize,
      ));

      final shouldContinue = await result.when(
        success: (page, failures, resultCode) async {
          allItems.addAll(page.records);
          return page.records.length == reportPageSize &&
              allItems.length < page.count;
        },
        failure: (error, failures) async {
          _isExporting = false;
          _emitFailure(failures);
          return false;
        },
        expireToken: () async {
          _isExporting = false;
          _emitFailure('نشست کاربری منقضی شده است.');
          return false;
        },
        connectionError: () async {
          _isExporting = false;
          _safeEmit(ShiftListState.connectionError(
            filter: filter,
            items: items,
          ));
          return false;
        },
      );

      if (!_isExporting || !shouldContinue) break;
      skip += reportPageSize;
    }

    if (!_isExporting) return;

    try {
      final file = await _writeCsvReport(allItems);
      _isExporting = false;
      _safeEmit(const ShiftListState.success(
        action: ShiftListAction.report,
        message: 'گزارش شیفت با موفقیت آماده شد',
      ));
      await OpenFilex.open(file.path);
    } catch (_) {
      _isExporting = false;
      _emitFailure('ذخیره گزارش شیفت با خطا مواجه شد');
    }
  }

  Future<File> _writeCsvReport(List<ShiftEntity> records) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = 'shift_report_${DateTime.now().millisecondsSinceEpoch}.csv';
    final file = File('${directory.path}/$fileName');

    final rows = <List<String>>[
      ['عنوان', 'نوع', 'زمان شروع', 'زمان پایان', 'وضعیت', 'نام ثبت کننده', 'تاریخ و زمان ثبت'],
      ...records.map((item) => [
        item.title ?? '',
        item.typeTitle ?? '',
        item.startTimeStr ?? item.startTime ?? '',
        item.endTimeStr ?? item.endTime ?? '',
        item.isActive ? 'فعال' : 'غیرفعال',
        item.insertUserFullName ?? '',
        item.insertDateTimeJalali ?? '',
      ]),
    ];

    final csv = rows.map((row) => row.map(_csvEscape).join(',')).join('\n');
    return file.writeAsString('\uFEFF$csv');
  }

  String _csvEscape(String value) {
    final normalized = value.replaceAll('"', '""');
    if (normalized.contains(',') || normalized.contains('\n') || normalized.contains('"')) {
      return '"$normalized"';
    }
    return normalized;
  }
}
