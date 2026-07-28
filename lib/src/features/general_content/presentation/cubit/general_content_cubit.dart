import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/params/general_content_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/params/general_content_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/usecases/delete_general_content_use_case.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/usecases/get_general_content_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/usecases/get_general_content_targets_use_case.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/cubit/general_content_state.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_enum_item_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/manager/current_session_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class GeneralContentCubit extends Cubit<GeneralContentState> {
  GeneralContentCubit(
    this._getListUseCase,
    this._getTargetsUseCase,
    this._deleteUseCase,
    this._sessionManager,
  ) : super(const GeneralContentState());

  final GetGeneralContentListUseCase _getListUseCase;
  final GetGeneralContentTargetsUseCase _getTargetsUseCase;
  final DeleteGeneralContentUseCase _deleteUseCase;
  final CurrentSessionManager _sessionManager;

  Future<void> init() async {
    emit(state.copyWith(contentTypeOptions: _readGeneralContentTypes()));
    await fetchList(reset: true);
  }

  Future<void> initTargets(GeneralContentEntity content) async {
    emit(state.copyWith(
      selectedContent: content,
      contentTypeOptions: _readGeneralContentTypes(),
      clearErrorMessage: true,
      clearSuccessMessage: true,
    ));
    await fetchTargets(content);
  }

  Future<void> fetchList({bool reset = false}) async {
    if (state.isInitialLoading || state.isLoadingMore) return;

    final nextSkip = reset ? 0 : state.records.length;
    emit(state.copyWith(
      status: reset ? GeneralContentViewStatus.loading : state.status,
      isLoadingMore: !reset,
      skip: nextSkip,
      clearErrorMessage: true,
      clearSuccessMessage: true,
    ));

    final result = await _getListUseCase(
      GeneralContentFilterParamEntity(
        skip: nextSkip,
        pageSize: state.pageSize,
        title: state.titleFilter,
        contentType: state.contentTypeFilter?.value,
      ),
    );

    result.when(
      success: (page, failures, resultCode) {
        final records = reset
            ? page.records
            : <GeneralContentEntity>[...state.records, ...page.records];
        emit(state.copyWith(
          status: records.isEmpty
              ? GeneralContentViewStatus.empty
              : GeneralContentViewStatus.loaded,
          records: records,
          totalCount: page.count,
          isLoadingMore: false,
          clearErrorMessage: true,
        ));
      },
      failure: (error, failures) => emit(state.copyWith(
        status: reset ? GeneralContentViewStatus.failure : state.status,
        isLoadingMore: false,
        errorMessage: failures ?? 'دریافت لیست بخشنامه‌ها با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        status: reset ? GeneralContentViewStatus.failure : state.status,
        isLoadingMore: false,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        status: reset ? GeneralContentViewStatus.connectionError : state.status,
        isLoadingMore: false,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );
  }

  Future<void> applyFilter({
    String? title,
    CurrentSessionEnumItemEntity? contentType,
  }) async {
    emit(state.copyWith(
      titleFilter: title?.trim(),
      clearTitleFilter: title?.trim().isEmpty ?? true,
      contentTypeFilter: contentType,
      clearContentTypeFilter: contentType == null,
      records: const [],
      totalCount: 0,
    ));
    await fetchList(reset: true);
  }

  void changeStatusFilter(GeneralContentStatusFilter filter) {
    emit(state.copyWith(statusFilter: filter));
  }

  Future<void> fetchTargets(GeneralContentEntity content) async {
    final id = content.id;
    if (id == null) {
      emit(state.copyWith(
        targetStatus: GeneralContentViewStatus.failure,
        errorMessage: 'شناسه بخشنامه برای دریافت گیرندگان یافت نشد.',
      ));
      return;
    }

    emit(state.copyWith(
      targetStatus: GeneralContentViewStatus.loading,
      targets: const [],
      clearErrorMessage: true,
      clearSuccessMessage: true,
    ));

    final result = await _getTargetsUseCase(GeneralContentIdParamEntity(id: id));
    result.when(
      success: (items, failures, resultCode) => emit(state.copyWith(
        targetStatus: items.isEmpty
            ? GeneralContentViewStatus.empty
            : GeneralContentViewStatus.loaded,
        targets: items,
        clearErrorMessage: true,
      )),
      failure: (error, failures) => emit(state.copyWith(
        targetStatus: GeneralContentViewStatus.failure,
        errorMessage: failures ?? 'دریافت لیست گیرندگان با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        targetStatus: GeneralContentViewStatus.failure,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        targetStatus: GeneralContentViewStatus.connectionError,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );
  }

  Future<bool> deleteContent(GeneralContentEntity content) async {
    final id = content.id;
    if (id == null || state.isDeleting) return false;

    emit(state.copyWith(
      isDeleting: true,
      deletingId: id,
      clearErrorMessage: true,
      clearSuccessMessage: true,
    ));

    var success = false;
    final result = await _deleteUseCase(GeneralContentIdParamEntity(id: id));
    result.when(
      success: (data, failures, resultCode) {
        success = true;
        emit(state.copyWith(
          isDeleting: false,
          clearDeletingId: true,
          successMessage: 'بخشنامه با موفقیت حذف شد.',
        ));
      },
      failure: (error, failures) => emit(state.copyWith(
        isDeleting: false,
        clearDeletingId: true,
        errorMessage: failures ?? 'حذف بخشنامه با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        isDeleting: false,
        clearDeletingId: true,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        isDeleting: false,
        clearDeletingId: true,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );

    if (success) {
      await fetchList(reset: true);
    }
    return success;
  }

  List<CurrentSessionEnumItemEntity> _readGeneralContentTypes() {
    return _sessionManager.currentSession?.enums?.generalContentType ??
        const <CurrentSessionEnumItemEntity>[];
  }
}
