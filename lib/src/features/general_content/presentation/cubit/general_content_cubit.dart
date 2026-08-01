import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_target_entity.dart';
// ignore: unused_import
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/params/general_content_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/params/general_content_form_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/params/general_content_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/params/general_content_target_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/usecases/add_general_content_target_use_case.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/usecases/add_general_content_use_case.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/usecases/delete_general_content_use_case.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/usecases/get_general_content_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/usecases/get_general_content_targets_use_case.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/usecases/update_general_content_use_case.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/cubit/general_content_state.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/fake/general_content_fake_data.dart';
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
    this._addUseCase,
    this._updateUseCase,
    this._addTargetUseCase,
    this._deleteUseCase,
    this._sessionManager,
  ) : super(const GeneralContentState());

  // These use cases are kept for restoring the real methods below.
  // ignore: unused_field
  final GetGeneralContentListUseCase _getListUseCase;

  // ignore: unused_field
  final GetGeneralContentTargetsUseCase _getTargetsUseCase;

  final AddGeneralContentUseCase _addUseCase;
  final UpdateGeneralContentUseCase _updateUseCase;
  final AddGeneralContentTargetUseCase _addTargetUseCase;
  final DeleteGeneralContentUseCase _deleteUseCase;
  final CurrentSessionManager _sessionManager;

  Future<void> init() async {
    emit(
      state.copyWith(
        contentTypeOptions: _readGeneralContentTypes(),
        receiverTypeOptions: _readGeneralContentReceiverTypes(),
      ),
    );
    await fetchList(reset: true);
  }

  void initForm([GeneralContentEntity? content]) {
    final contentTypes = _includeSelectedOption(
      _readGeneralContentTypes(),
      value: content?.contentType,
      title: content?.contentTypeText,
    );
    final receiverTypes = _includeSelectedOption(
      _readGeneralContentReceiverTypes(),
      value: content?.receiverType,
      title: content?.receiverTypeText,
    );

    emit(
      state.copyWith(
        contentTypeOptions: contentTypes,
        receiverTypeOptions: receiverTypes,
        selectedContent: content,
        clearSelectedContent: content == null,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );
  }

  Future<void> initTargets(GeneralContentEntity content) async {
    emit(
      state.copyWith(
        selectedContent: content,
        contentTypeOptions: _readGeneralContentTypes(),
        targetTypeOptions: _readGeneralContentTargetTypes(),
        targetBoundaryTypeOptions: _readGeneralContentBoundaryTypes(),
        logicalOperatorTypeOptions: _readGeneralContentOperatorTypes(),
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );
    await fetchTargets(content);
  }

  void initTargetForm(GeneralContentEntity content) {
    final targetTypes = _readGeneralContentTargetTypes();
    final initialTargetType = targetTypes.isEmpty ? null : targetTypes.first.value;

    emit(
      state.copyWith(
        selectedContent: content,
        targetTypeOptions: targetTypes,
        targetBoundaryTypeOptions: _readGeneralContentBoundaryTypes(),
        logicalOperatorTypeOptions: _readGeneralContentOperatorTypes(),
        targetCategoryOptions: GeneralContentFakeData.targetCategories(initialTargetType),
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );
  }

  void changeTargetType(int? targetType) {
    emit(
      state.copyWith(
        targetCategoryOptions: GeneralContentFakeData.targetCategories(targetType),
      ),
    );
  }

  void clearMessages() {
    emit(
      state.copyWith(
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );
  }

  // TODO: realMethod
  /*
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
  */

  // TODO: fakeMethod
  Future<void> fetchList({bool reset = false}) async {
    if (state.isInitialLoading || state.isLoadingMore) return;

    final nextSkip = reset ? 0 : state.records.length;
    emit(
      state.copyWith(
        status: reset ? GeneralContentViewStatus.loading : state.status,
        isLoadingMore: !reset,
        skip: nextSkip,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );

    await Future<void>.delayed(const Duration(milliseconds: 500));

    final titleFilter = state.titleFilter?.trim().toLowerCase();
    final contentTypeValue = state.contentTypeFilter?.value;

    final filteredRecords = GeneralContentFakeData.buildContents(
      contentTypes: state.contentTypeOptions,
      receiverTypes: state.receiverTypeOptions,
    ).where((item) {
      final matchesTitle = titleFilter == null ||
          titleFilter.isEmpty ||
          (item.title ?? '').toLowerCase().contains(titleFilter);
      final matchesContentType =
          contentTypeValue == null || item.contentType == contentTypeValue;

      return matchesTitle && matchesContentType;
    }).toList();

    final pageRecords = filteredRecords
        .skip(nextSkip)
        .take(state.pageSize)
        .toList(growable: false);

    final records = reset
        ? pageRecords
        : <GeneralContentEntity>[...state.records, ...pageRecords];

    emit(
      state.copyWith(
        status: records.isEmpty
            ? GeneralContentViewStatus.empty
            : GeneralContentViewStatus.loaded,
        records: records,
        totalCount: filteredRecords.length,
        isLoadingMore: false,
        clearErrorMessage: true,
      ),
    );
  }

  Future<void> applyFilter({
    String? title,
    CurrentSessionEnumItemEntity? contentType,
  }) async {
    emit(
      state.copyWith(
        titleFilter: title?.trim(),
        clearTitleFilter: title?.trim().isEmpty ?? true,
        contentTypeFilter: contentType,
        clearContentTypeFilter: contentType == null,
        records: const [],
        totalCount: 0,
      ),
    );
    await fetchList(reset: true);
  }

  void changeStatusFilter(GeneralContentStatusFilter filter) {
    emit(state.copyWith(statusFilter: filter));
  }

  // TODO: realMethod
  /*
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
  */

  // TODO: fakeMethod
  Future<void> fetchTargets(GeneralContentEntity content) async {
    final id = content.id;
    if (id == null) {
      emit(
        state.copyWith(
          targetStatus: GeneralContentViewStatus.failure,
          errorMessage: 'شناسه بخشنامه برای دریافت گیرندگان یافت نشد.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        targetStatus: GeneralContentViewStatus.loading,
        targets: const [],
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );

    await Future<void>.delayed(const Duration(milliseconds: 400));

    final targets = GeneralContentFakeData.buildTargets(contentId: id);
    emit(
      state.copyWith(
        targetStatus: targets.isEmpty
            ? GeneralContentViewStatus.empty
            : GeneralContentViewStatus.loaded,
        targets: targets,
        clearErrorMessage: true,
      ),
    );
  }

  Future<bool> submitContent(GeneralContentFormParamEntity param) async {
    if (state.isSubmitting) return false;

    emit(
      state.copyWith(
        isSubmitting: true,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );

    var success = false;
    final result = param.id == null
        ? await _addUseCase(param)
        : await _updateUseCase(param);

    result.when(
      success: (data, failures, resultCode) {
        success = true;
        emit(
          state.copyWith(
            isSubmitting: false,
            successMessage: param.id == null
                ? 'بخشنامه با موفقیت ثبت شد.'
                : 'بخشنامه با موفقیت ویرایش شد.',
          ),
        );
      },
      failure: (error, failures) => emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: failures ??
              (param.id == null
                  ? 'ثبت بخشنامه با خطا مواجه شد.'
                  : 'ویرایش بخشنامه با خطا مواجه شد.'),
        ),
      ),
      expireToken: () => emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: 'نشست کاربری منقضی شده است.',
        ),
      ),
      connectionError: () => emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: 'اتصال به اینترنت برقرار نیست.',
        ),
      ),
    );

    return success;
  }

  Future<bool> submitTarget(GeneralContentTargetParamEntity param) async {
    if (state.isSubmitting) return false;

    emit(
      state.copyWith(
        isSubmitting: true,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );

    var success = false;
    final result = await _addTargetUseCase(param);

    result.when(
      success: (data, failures, resultCode) {
        success = true;
        emit(
          state.copyWith(
            isSubmitting: false,
            successMessage: 'گیرنده با موفقیت افزوده شد.',
          ),
        );
      },
      failure: (error, failures) => emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: failures ?? 'افزودن گیرنده با خطا مواجه شد.',
        ),
      ),
      expireToken: () => emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: 'نشست کاربری منقضی شده است.',
        ),
      ),
      connectionError: () => emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: 'اتصال به اینترنت برقرار نیست.',
        ),
      ),
    );

    return success;
  }

  Future<bool> deleteContent(GeneralContentEntity content) async {
    final id = content.id;
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
    final result = await _deleteUseCase(GeneralContentIdParamEntity(id: id));
    result.when(
      success: (data, failures, resultCode) {
        success = true;
        emit(
          state.copyWith(
            isDeleting: false,
            clearDeletingId: true,
            successMessage: 'بخشنامه با موفقیت حذف شد.',
          ),
        );
      },
      failure: (error, failures) => emit(
        state.copyWith(
          isDeleting: false,
          clearDeletingId: true,
          errorMessage: failures ?? 'حذف بخشنامه با خطا مواجه شد.',
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

    if (success) {
      await fetchList(reset: true);
    }
    return success;
  }

  List<CurrentSessionEnumItemEntity> _readGeneralContentTypes() {
    return _validOptions(
      _sessionManager.currentSession?.enums?.generalContentType,
      GeneralContentFakeData.contentTypes,
    );
  }

  List<CurrentSessionEnumItemEntity> _readGeneralContentReceiverTypes() {
    return _validOptions(
      _sessionManager.currentSession?.enums?.generalContentReceiverType,
      GeneralContentFakeData.receiverTypes,
    );
  }

  List<CurrentSessionEnumItemEntity> _readGeneralContentTargetTypes() {
    return _validOptions(
      _sessionManager.currentSession?.enums?.generalContentTargetType,
      GeneralContentFakeData.targetTypes,
    );
  }

  List<CurrentSessionEnumItemEntity> _readGeneralContentBoundaryTypes() {
    return _validOptions(
      _sessionManager.currentSession?.enums?.generalContentTargetBoundaryType,
      GeneralContentFakeData.boundaryTypes,
    );
  }

  List<CurrentSessionEnumItemEntity> _readGeneralContentOperatorTypes() {
    return _validOptions(
      _sessionManager.currentSession?.enums?.generalContentLogicalOperatorType,
      GeneralContentFakeData.operatorTypes,
    );
  }

  List<CurrentSessionEnumItemEntity> _includeSelectedOption(
    List<CurrentSessionEnumItemEntity> options, {
    required int? value,
    required String? title,
  }) {
    if (value == null || options.any((item) => item.value == value)) {
      return options;
    }

    return <CurrentSessionEnumItemEntity>[
      ...options,
      CurrentSessionEnumItemEntity(
        value: value,
        title: title?.trim().isNotEmpty == true ? title : 'مقدار فعلی',
      ),
    ];
  }

  List<CurrentSessionEnumItemEntity> _validOptions(
    List<CurrentSessionEnumItemEntity>? source,
    List<CurrentSessionEnumItemEntity> fallback,
  ) {
    final validItems = source
            ?.where(
              (item) =>
                  item.value != null &&
                  ((item.title?.trim().isNotEmpty ?? false) ||
                      (item.name?.trim().isNotEmpty ?? false)),
            )
            .toList(growable: false) ??
        const <CurrentSessionEnumItemEntity>[];

    return validItems.isEmpty ? fallback : validItems;
  }
}
