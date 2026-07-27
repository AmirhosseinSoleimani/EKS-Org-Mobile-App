import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/params/create_or_edit_skill_certificate_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/params/skill_certificate_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/params/submit_skill_services_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/usecases/skills_certificates_usecases.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/presentation/utils/skill_certificate_excel_exporter.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:open_filex/open_filex.dart';

part 'skills_certificates_cubit.freezed.dart';
part 'skills_certificates_state.dart';

@injectable
class SkillsCertificatesCubit extends Cubit<SkillsCertificatesState> {
  SkillsCertificatesCubit(
    this._getSkillsCertificatesUseCase,
    this._getSkillCertificateByIdUseCase,
    this._createSkillCertificateUseCase,
    this._editSkillCertificateUseCase,
    this._deleteSkillCertificateUseCase,
    this._getSkillCertificateServicesUseCase,
    this._submitSkillCertificateServicesUseCase,
    this._getSkillCertificatesReportUseCase,
  ) : super(const SkillsCertificatesState.idle());

  final GetSkillsCertificatesUseCase _getSkillsCertificatesUseCase;
  final GetSkillCertificateByIdUseCase _getSkillCertificateByIdUseCase;
  final CreateSkillCertificateUseCase _createSkillCertificateUseCase;
  final EditSkillCertificateUseCase _editSkillCertificateUseCase;
  final DeleteSkillCertificateUseCase _deleteSkillCertificateUseCase;
  final GetSkillCertificateServicesUseCase _getSkillCertificateServicesUseCase;
  final SubmitSkillCertificateServicesUseCase
      _submitSkillCertificateServicesUseCase;
  final GetSkillCertificatesReportUseCase _getSkillCertificatesReportUseCase;

  final TextEditingController titleFilterController = TextEditingController();

  VoidCallback? _retryAction;
  int _skip = 0;
  final int _pageSize = 10;
  bool _isLoadingMore = false;

  bool get hasRetryAction => _retryAction != null;

  SkillsCertificatesStateData get _data => state.data;

  Future<void> init() => fetchSkills();

  void retryLastAction() => _retryAction?.call();

  Future<void> fetchSkills({bool reset = true}) async {
    if (reset) {
      _skip = 0;
      _retryAction = () => fetchSkills(reset: true);
      emit(SkillsCertificatesState.loading(data: _data.copyWith(
        isInitialLoading: true,
        message: null,
      )));
    }

    final result = await _getSkillsCertificatesUseCase(_buildFilterParam());

    result.when(
      success: (data, _, __) {
        final nextItems = reset
            ? data.items
            : <SkillCertificateEntity>[..._data.items, ...data.items];

        emit(SkillsCertificatesState.loaded(
          data: _data.copyWith(
            items: nextItems,
            totalCount: data.totalCount,
            hasMore: nextItems.length < data.totalCount,
            isInitialLoading: false,
            message: null,
          ),
        ));
      },
      failure: (_, message) {
        emit(SkillsCertificatesState.error(
          data: _data.copyWith(isInitialLoading: false),
          message: _message(
            title: 'خطا',
            message: message ?? 'دریافت گواهینامه‌های مهارت با خطا مواجه شد',
          ),
        ));
      },
      expireToken: () {
        emit(SkillsCertificatesState.error(
          data: _data.copyWith(isInitialLoading: false),
          message: _message(
            title: 'خطا',
            message: 'نشست کاربری منقضی شده است',
          ),
        ));
      },
      connectionError: () {
        emit(SkillsCertificatesState.connectionError(
          data: _data.copyWith(isInitialLoading: false),
        ));
      },
    );
  }

  Future<void> loadMore() async {
    if (!_data.hasMore || _isLoadingMore) return;

    _isLoadingMore = true;
    _skip += _pageSize;

    emit(SkillsCertificatesState.loadingMore(data: _data));
    await fetchSkills(reset: false);
    _isLoadingMore = false;
  }

  Future<void> submitFilters() async {
    await fetchSkills();
  }

  Future<void> clearFilters() async {
    titleFilterController.clear();
    emit(SkillsCertificatesState.loaded(
      data: _data.copyWith(activeFilter: null, message: null),
    ));
    await fetchSkills();
  }

  Future<void> changeActiveFilter(bool? value) async {
    emit(SkillsCertificatesState.loaded(
      data: _data.copyWith(
        activeFilter: value,
      ),
    ));
    await fetchSkills();
  }

  Future<SkillCertificateEntity?> getSkillById(int id) async {
    emit(SkillsCertificatesState.loading(data: _data.copyWith(
      isSubmitting: true,
      message: null,
    )));

    final result = await _getSkillCertificateByIdUseCase(id);

    return result.when(
      success: (data, _, __) {
        emit(SkillsCertificatesState.loaded(
          data: _data.copyWith(
            selectedSkill: data,
            isSubmitting: false,
          ),
        ));
        return data;
      },
      failure: (_, message) {
        emit(SkillsCertificatesState.error(
          data: _data.copyWith(isSubmitting: false),
          message: _message(
            title: 'خطا',
            message: message ?? 'دریافت اطلاعات گواهینامه مهارت با خطا مواجه شد',
          ),
        ));
        return null;
      },
      expireToken: () {
        emit(SkillsCertificatesState.loaded(
          data: _data.copyWith(isSubmitting: false),
        ));
        return null;
      },
      connectionError: () {
        emit(SkillsCertificatesState.connectionError(
          data: _data.copyWith(isSubmitting: false),
        ));
        return null;
      },
    );
  }

  Future<bool> saveSkill({
    int? id,
    required String title,
    required bool isActive,
  }) async {
    final normalizedTitle = title.trim();
    if (normalizedTitle.isEmpty) return false;

    emit(SkillsCertificatesState.loading(data: _data.copyWith(
      isSubmitting: true,
      message: null,
    )));

    final param = CreateOrEditSkillCertificateParamEntity(
      id: id,
      title: normalizedTitle,
      isActive: isActive,
    );

    final result = id == null
        ? await _createSkillCertificateUseCase(param)
        : await _editSkillCertificateUseCase(param);

    return result.when<Future<bool>>(
      success: (_, __, ___) async {
        emit(SkillsCertificatesState.loaded(
          data: _data.copyWith(
            isSubmitting: false,
            message: id == null
                ? 'مهارت با موفقیت ثبت شد'
                : 'مهارت با موفقیت ویرایش شد',
          ),
        ));
        await fetchSkills();
        return true;
      },
      failure: (_, message) async {
        emit(SkillsCertificatesState.error(
          data: _data.copyWith(isSubmitting: false),
          message: _message(
            title: 'خطا',
            message: message ?? 'ثبت اطلاعات مهارت با خطا مواجه شد',
          ),
        ));
        return false;
      },
      expireToken: () async {
        emit(SkillsCertificatesState.loaded(
          data: _data.copyWith(isSubmitting: false),
        ));
        return false;
      },
      connectionError: () async {
        emit(SkillsCertificatesState.connectionError(
          data: _data.copyWith(isSubmitting: false),
        ));
        return false;
      },
    );
  }

  Future<void> deleteSkill(SkillCertificateEntity skill) async {
    final id = skill.id;
    if (id == null) return;

    emit(SkillsCertificatesState.loading(data: _data.copyWith(
      deletingSkillId: id,
      message: null,
    )));

    final result = await _deleteSkillCertificateUseCase(id);

    await result.when<Future<void>>(
      success: (_, __, ___) async {
        emit(SkillsCertificatesState.loaded(
          data: _data.copyWith(
            deletingSkillId: null,
            message: 'مهارت با موفقیت حذف شد',
          ),
        ));
        await fetchSkills();
      },
      failure: (_, message) async {
        emit(SkillsCertificatesState.error(
          data: _data.copyWith(deletingSkillId: null),
          message: _message(
            title: 'خطا',
            message: message ?? 'حذف مهارت با خطا مواجه شد',
          ),
        ));
      },
      expireToken: () async {
        emit(SkillsCertificatesState.loaded(
          data: _data.copyWith(deletingSkillId: null),
        ));
      },
      connectionError: () async {
        emit(SkillsCertificatesState.connectionError(
          data: _data.copyWith(deletingSkillId: null),
        ));
      },
    );
  }

  Future<bool> loadServices(SkillCertificateEntity skill) async {
    final id = skill.id;
    if (id == null) return false;

    emit(SkillsCertificatesState.loading(data: _data.copyWith(
      selectedSkill: skill,
      services: const [],
      selectedServiceIds: const <int>{},
      serviceSearchText: '',
      isServicesLoading: true,
      message: null,
    )));

    final result = await _getSkillCertificateServicesUseCase(id);

    return result.when(
      success: (items, _, __) {
        final selectedIds = items
            .where((item) => item.isSelected && item.id != null)
            .map((item) => item.id!)
            .toSet();

        emit(SkillsCertificatesState.loaded(
          data: _data.copyWith(
            services: items,
            selectedServiceIds: selectedIds,
            isServicesLoading: false,
          ),
        ));
        return true;
      },
      failure: (_, message) {
        emit(SkillsCertificatesState.error(
          data: _data.copyWith(isServicesLoading: false),
          message: _message(
            title: 'خطا',
            message: message ?? 'دریافت سرویس‌ها با خطا مواجه شد',
          ),
        ));
        return false;
      },
      expireToken: () {
        emit(SkillsCertificatesState.loaded(
          data: _data.copyWith(isServicesLoading: false),
        ));
        return false;
      },
      connectionError: () {
        emit(SkillsCertificatesState.connectionError(
          data: _data.copyWith(isServicesLoading: false),
        ));
        return false;
      },
    );
  }

  void toggleService(SkillServiceEntity service) {
    final id = service.id;
    if (id == null || _data.isServicesSubmitting) return;

    final selectedIds = Set<int>.from(_data.selectedServiceIds);
    selectedIds.contains(id) ? selectedIds.remove(id) : selectedIds.add(id);

    emit(SkillsCertificatesState.loaded(
      data: _data.copyWith(selectedServiceIds: selectedIds),
    ));
  }

  void setAllServices(bool selected) {
    if (_data.isServicesSubmitting) return;

    final selectedIds = selected
        ? _data.services
            .where((service) => service.id != null)
            .map((service) => service.id!)
            .toSet()
        : <int>{};

    emit(SkillsCertificatesState.loaded(
      data: _data.copyWith(selectedServiceIds: selectedIds),
    ));
  }

  void filterServices(String query) {
    emit(SkillsCertificatesState.loaded(
      data: _data.copyWith(serviceSearchText: query),
    ));
  }

  Future<bool> submitServices() async {
    final skillId = _data.selectedSkill?.id;
    if (skillId == null || _data.isServicesSubmitting) return false;

    emit(SkillsCertificatesState.loading(data: _data.copyWith(
      isServicesSubmitting: true,
      message: null,
    )));

    final selectedIds = _data.selectedServiceIds.toList()..sort();
    final result = await _submitSkillCertificateServicesUseCase(
      SubmitSkillServicesParamEntity(
        skillCertificateId: skillId,
        emdadServiceIds: selectedIds,
      ),
    );

    return result.when<Future<bool>>(
      success: (_, __, ___) async {
        emit(SkillsCertificatesState.loaded(
          data: _data.copyWith(
            isServicesSubmitting: false,
            message: 'سرویس‌های گواهینامه با موفقیت ثبت شد',
          ),
        ));
        return true;
      },
      failure: (_, message) async {
        emit(SkillsCertificatesState.error(
          data: _data.copyWith(isServicesSubmitting: false),
          message: _message(
            title: 'خطا',
            message: message ?? 'ثبت سرویس‌ها با خطا مواجه شد',
          ),
        ));
        return false;
      },
      expireToken: () async {
        emit(SkillsCertificatesState.loaded(
          data: _data.copyWith(isServicesSubmitting: false),
        ));
        return false;
      },
      connectionError: () async {
        emit(SkillsCertificatesState.connectionError(
          data: _data.copyWith(isServicesSubmitting: false),
        ));
        return false;
      },
    );
  }

  Future<void> exportReport() async {
    emit(SkillsCertificatesState.loading(data: _data.copyWith(
      isReportLoading: true,
      reportFilePath: null,
      message: null,
    )));

    final result = await _getSkillCertificatesReportUseCase(
      _buildFilterParam(pageSize: 0),
    );

    await result.when<Future<void>>(
      success: (items, _, __) async {
        final filePath = await SkillCertificateExcelExporter.export(items);
        emit(SkillsCertificatesState.loaded(
          data: _data.copyWith(
            isReportLoading: false,
            reportFilePath: filePath,
            message: 'فایل اکسل گزارش گواهینامه مهارت آماده شد',
          ),
        ));

        final openResult = await OpenFilex.open(
          filePath,
          type: 'application/vnd.ms-excel',
        );

        if (openResult.type != ResultType.done) {
          emit(SkillsCertificatesState.loaded(
            data: _data.copyWith(
              isReportLoading: false,
              reportFilePath: filePath,
              message: 'فایل اکسل ذخیره شد اما برنامه‌ای برای باز کردن آن پیدا نشد',
            ),
          ));
        }
      },
      failure: (_, message) async {
        emit(SkillsCertificatesState.error(
          data: _data.copyWith(isReportLoading: false),
          message: _message(
            title: 'خطا',
            message: message ?? 'دریافت گزارش با خطا مواجه شد',
          ),
        ));
      },
      expireToken: () async {
        emit(SkillsCertificatesState.loaded(
          data: _data.copyWith(isReportLoading: false),
        ));
      },
      connectionError: () async {
        emit(SkillsCertificatesState.connectionError(
          data: _data.copyWith(isReportLoading: false),
        ));
      },
    );
  }


  bool get areAllServicesSelected {
    final selectableIds = _data.services
        .where((service) => service.id != null)
        .map((service) => service.id!)
        .toSet();

    return selectableIds.isNotEmpty &&
        _data.selectedServiceIds.containsAll(selectableIds);
  }

  List<SkillServiceEntity> get filteredServices {
    final query = _data.serviceSearchText.trim().toLowerCase();

    if (query.isEmpty) {
      return _data.services;
    }

    return _data.services.where((item) {
      return item.displayTitle.toLowerCase().contains(query);
    }).toList();
  }



  SkillCertificateFilterParamEntity _buildFilterParam({int? pageSize}) {
    return SkillCertificateFilterParamEntity(
      skip: _skip,
      pageSize: pageSize ?? _pageSize,
      title: titleFilterController.text,
      isActive: _data.activeFilter,
    );
  }

  BottomSheetMessageModel _message({
    required String title,
    required String message,
  }) {
    return BottomSheetMessageModel(title: title, message: message);
  }

  @override
  Future<void> close() {
    titleFilterController.dispose();
    return super.close();
  }
}
