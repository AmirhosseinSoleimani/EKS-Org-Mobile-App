import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_detail_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_reference_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/params/grade_pattern_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/params/grade_pattern_reference_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/use_cases/assign_grade_pattern_reference_use_case.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/use_cases/create_grade_pattern_use_case.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/use_cases/delete_grade_pattern_reference_use_case.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/use_cases/delete_grade_pattern_use_case.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/use_cases/get_grade_pattern_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/use_cases/get_grade_pattern_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/use_cases/get_grade_pattern_references_use_case.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/use_cases/update_grade_pattern_use_case.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/use_cases/validate_grade_pattern_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_enum_item_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/manager/current_session_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'grade_pattern_cubit.freezed.dart';
part 'grade_pattern_state.dart';

enum GradePatternAction {
  create,
  update,
  delete,
  assignReference,
  deleteReference,
}

@injectable
class GradePatternCubit extends Cubit<GradePatternState> {
  GradePatternCubit(
    this._getListUseCase,
    this._getByIdUseCase,
    this._createUseCase,
    this._updateUseCase,
    this._deleteUseCase,
    this._getReferencesUseCase,
    this._assignReferenceUseCase,
    this._deleteReferenceUseCase,
    this._validateUseCase,
    this._currentSessionManager,
  ) : super(const GradePatternState.initial());

  final GetGradePatternListUseCase _getListUseCase;
  final GetGradePatternByIdUseCase _getByIdUseCase;
  final CreateGradePatternUseCase _createUseCase;
  final UpdateGradePatternUseCase _updateUseCase;
  final DeleteGradePatternUseCase _deleteUseCase;
  final GetGradePatternReferencesUseCase _getReferencesUseCase;
  final AssignGradePatternReferenceUseCase _assignReferenceUseCase;
  final DeleteGradePatternReferenceUseCase _deleteReferenceUseCase;
  final ValidateGradePatternUseCase _validateUseCase;
  final CurrentSessionManager _currentSessionManager;

  static const int _pageSize = 10;

  List<GradePatternEntity> items = [];
  List<GradePatternEntity> activePatterns = [];
  List<GradePatternReferenceEntity> references = [];
  GradePatternFilterParamEntity filter =
      const GradePatternFilterParamEntity(pageSize: _pageSize);
  int totalCount = 0;
  bool hasMore = true;
  int? loadingDetailId;
  int? deletingItemId;

  Future<void> fetchList({bool refresh = false}) async {
    final nextSkip = refresh ? 0 : items.length;
    filter = filter.copyWith(skip: nextSkip, pageSize: _pageSize);

    if (refresh || items.isEmpty) {
      _safeEmit(GradePatternState.loading(filter: filter));
    } else {
      _safeEmit(GradePatternState.loadingMore(
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

        if (items.isEmpty) {
          _safeEmit(GradePatternState.empty(filter: filter));
        } else {
          _safeEmit(GradePatternState.loaded(
            items: items,
            totalCount: totalCount,
            hasMore: hasMore,
            filter: filter,
          ));
        }
      },
      failure: (error, failures) => _emitFailure(failures),
      expireToken: () => _emitFailure('نشست کاربری منقضی شده است.'),
      connectionError: () => _safeEmit(GradePatternState.connectionError(
        filter: filter,
        items: items,
      )),
    );
  }

  Future<void> applyFilter(GradePatternFilterParamEntity value) async {
    filter = value.copyWith(skip: 0, pageSize: _pageSize);
    await fetchList(refresh: true);
  }

  Future<void> clearFilter() async {
    filter = const GradePatternFilterParamEntity(pageSize: _pageSize);
    await fetchList(refresh: true);
  }

  Future<void> loadDetail(int id) async {
    if (loadingDetailId == id) return;

    loadingDetailId = id;
    _safeEmit(GradePatternState.detailLoading(items: items));
    final result = await _getByIdUseCase(id);
    result.when(
      success: (data, failures, resultCode) {
        loadingDetailId = null;
        final normalized = _withSessionGrades(data);
        _safeEmit(GradePatternState.detailLoaded(item: normalized));
      },
      failure: (error, failures) {
        loadingDetailId = null;
        _emitFailure(failures);
      },
      expireToken: () {
        loadingDetailId = null;
        _emitFailure('نشست کاربری منقضی شده است.');
      },
      connectionError: () {
        loadingDetailId = null;
        _safeEmit(GradePatternState.connectionError(
          filter: filter,
          items: items,
        ));
      },
    );
  }

  GradePatternEntity createDraft() {
    final draft = GradePatternEntity(details: _sessionGradeDetails());
    _safeEmit(GradePatternState.formReady(item: draft));
    return draft;
  }

  Future<void> loadForm({int? id}) async {
    if (id == null) {
      createDraft();
      return;
    }

    _safeEmit(GradePatternState.detailLoading(items: items));
    final result = await _getByIdUseCase(id);
    result.when(
      success: (data, failures, resultCode) {
        _safeEmit(GradePatternState.formReady(item: _withSessionGrades(data)));
      },
      failure: (error, failures) => _emitFailure(failures),
      expireToken: () => _emitFailure('نشست کاربری منقضی شده است.'),
      connectionError: () => _safeEmit(GradePatternState.connectionError(
        filter: filter,
        items: items,
      )),
    );
  }

  Future<bool> submit(GradePatternEntity item) async {
    final validation = await _validateUseCase(item);
    if (!validation.isValid) {
      _emitFailure(validation.message);
      return false;
    }

    _safeEmit(GradePatternState.submitting(item: item));
    final result = item.id == null || item.id == 0
        ? await _createUseCase(item)
        : await _updateUseCase(item);
    final action =
        item.id == null || item.id == 0 ? GradePatternAction.create : GradePatternAction.update;
    return _handlePatternResult(result, action);
  }

  Future<bool> deleteItem(int id) async {
    if (deletingItemId != null) return false;

    deletingItemId = id;
    _safeEmit(GradePatternState.submitting(items: items));
    final result = await _deleteUseCase(id);
    return result.when(
      success: (data, failures, resultCode) async {
        deletingItemId = null;
        _safeEmit(GradePatternState.success(
          action: GradePatternAction.delete,
          message: 'الگوی گرید با موفقیت حذف شد',
          items: items,
        ));
        await fetchList(refresh: true);
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
        _safeEmit(GradePatternState.connectionError(
          filter: filter,
          items: items,
        ));
        return false;
      },
    );
  }

  Future<void> loadActivePatterns() async {
    final result = await _getListUseCase(
      const GradePatternFilterParamEntity(
        isActive: true,
        pageSize: 1000,
      ),
    );
    result.whenOrNull(
      success: (page, failures, resultCode) {
        activePatterns = page.records;
        _safeEmit(GradePatternState.referencesLoaded(
          patterns: activePatterns,
          references: references,
        ));
      },
      failure: (error, failures) => _emitFailure(failures),
    );
  }

  Future<void> loadReferences(int refId) async {
    final result = await _getReferencesUseCase(refId: refId);
    result.when(
      success: (data, failures, resultCode) {
        references = data;
        _safeEmit(GradePatternState.referencesLoaded(
          patterns: activePatterns,
          references: references,
        ));
      },
      failure: (error, failures) => _emitFailure(failures),
      expireToken: () => _emitFailure('نشست کاربری منقضی شده است.'),
      connectionError: () => _safeEmit(GradePatternState.connectionError(
        filter: filter,
        items: items,
      )),
    );
  }

  Future<bool> assignReference(GradePatternReferenceParamEntity param) async {
    _safeEmit(GradePatternState.submitting(items: items));
    final result = await _assignReferenceUseCase(param);
    return result.when(
      success: (data, failures, resultCode) async {
        _safeEmit(const GradePatternState.success(
          action: GradePatternAction.assignReference,
          message: 'الگوی گرید با موفقیت ثبت شد',
        ));
        await loadReferences(param.refId);
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
        _safeEmit(GradePatternState.connectionError(
          filter: filter,
          items: items,
        ));
        return false;
      },
    );
  }

  Future<bool> deleteReference(int id, int refId) async {
    _safeEmit(GradePatternState.submitting(items: items));
    final result = await _deleteReferenceUseCase(id);
    return result.when(
      success: (data, failures, resultCode) async {
        _safeEmit(const GradePatternState.success(
          action: GradePatternAction.deleteReference,
          message: 'الگوی گرید با موفقیت حذف شد',
        ));
        await loadReferences(refId);
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
        _safeEmit(GradePatternState.connectionError(
          filter: filter,
          items: items,
        ));
        return false;
      },
    );
  }

  bool _handlePatternResult(
    ApiResult<GradePatternEntity> result,
    GradePatternAction action,
  ) {
    return result.when(
      success: (data, failures, resultCode) {
        _safeEmit(GradePatternState.success(
          action: action,
          message: action == GradePatternAction.create
              ? 'گرید با موفقیت ثبت شد'
              : 'گرید با موفقیت ویرایش شد',
          items: items,
        ));
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
        _safeEmit(GradePatternState.connectionError(
          filter: filter,
          items: items,
        ));
        return false;
      },
    );
  }

  GradePatternEntity _withSessionGrades(GradePatternEntity item) {
    final enumDetails = _sessionGradeDetails();
    final merged = <GradePatternDetailEntity>[];
    final usedIds = <int>{};

    for (final enumDetail in enumDetails) {
      final existing = _findByGradeId(item.details, enumDetail.gradeId);
      merged.add(existing == null
          ? enumDetail
          : enumDetail.copyWith(
              gradeCode: existing.gradeCode.isNotEmpty
                  ? existing.gradeCode
                  : enumDetail.gradeCode,
              gradeTitle: existing.gradeTitle.isNotEmpty
                  ? existing.gradeTitle
                  : enumDetail.gradeTitle,
              gradeCoefficient: existing.gradeCoefficient,
              managmentCommisionPercent: existing.managmentCommisionPercent,
            ));
      usedIds.add(enumDetail.gradeId);
    }

    for (final detail in item.details) {
      if (!usedIds.contains(detail.gradeId)) {
        merged.add(detail);
      }
    }

    return item.copyWith(details: merged);
  }

  List<GradePatternDetailEntity> _sessionGradeDetails() {
    final grades = _currentSessionManager.currentSession?.enums?.grade ??
        const <CurrentSessionEnumItemEntity>[];
    return grades
        .where((item) => item.value != null)
        .map((item) => GradePatternDetailEntity(
              gradeId: item.value!,
              gradeCode: item.name ?? '',
              gradeTitle: item.title ?? item.name ?? '',
              gradeCoefficient: 0,
              managmentCommisionPercent: 0,
            ))
        .toList();
  }

  GradePatternDetailEntity? _findByGradeId(
    List<GradePatternDetailEntity> details,
    int gradeId,
  ) {
    for (final detail in details) {
      if (detail.gradeId == gradeId) return detail;
    }
    return null;
  }

  void _emitFailure(String? message) {
    _safeEmit(GradePatternState.failure(
      message: message?.trim().isNotEmpty == true
          ? message!
          : 'درخواست شما با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید',
      items: items,
    ));
  }

  void _safeEmit(GradePatternState state) {
    if (!isClosed) emit(state);
  }
}
