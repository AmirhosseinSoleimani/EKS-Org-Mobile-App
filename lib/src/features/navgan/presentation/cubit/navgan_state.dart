import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/grade_pattern_reference_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_service_group_entity.dart';

enum NavganViewStatus {
  initial,
  loading,
  loaded,
  empty,
  failure,
  connectionError,
}

class NavganState {
  const NavganState({
    this.status = NavganViewStatus.initial,
    this.records = const [],
    this.selectedNavgan,
    this.gradePatterns = const [],
    this.gradeReferences = const [],
    this.selectedGradePattern,
    this.gradePatternDetail,
    this.loadingGradeDetailId,
    this.serviceGroups = const [],
    this.selectedServiceCategory,
    this.defects = const [],
    this.committedDefects = const [],
    this.loadingDefectServiceCategoryId,
    this.errorMessage,
    this.successMessage,
    this.isGradePatternsLoading = false,
    this.isGradeReferencesLoading = false,
    this.isGradeDetailLoading = false,
    this.isGradeSubmitting = false,
    this.isGradeDeleting = false,
    this.isServiceGroupsLoading = false,
    this.isServicesSubmitting = false,
    this.isDefectsLoading = false,
    this.isDefectsSubmitting = false,
  });

  final NavganViewStatus status;
  final List<NavganEntity> records;
  final NavganEntity? selectedNavgan;
  final List<GradePatternEntity> gradePatterns;
  final List<GradePatternReferenceEntity> gradeReferences;
  final GradePatternEntity? selectedGradePattern;
  final GradePatternEntity? gradePatternDetail;
  final int? loadingGradeDetailId;
  final List<NavganServiceGroupEntity> serviceGroups;
  final EmdadServiceCategoryEntity? selectedServiceCategory;
  final List<NavganDefectEntity> defects;
  final List<NavganDefectEntity> committedDefects;
  final int? loadingDefectServiceCategoryId;
  final String? errorMessage;
  final String? successMessage;
  final bool isGradePatternsLoading;
  final bool isGradeReferencesLoading;
  final bool isGradeDetailLoading;
  final bool isGradeSubmitting;
  final bool isGradeDeleting;
  final bool isServiceGroupsLoading;
  final bool isServicesSubmitting;
  final bool isDefectsLoading;
  final bool isDefectsSubmitting;

  bool get isInitialLoading =>
      status == NavganViewStatus.loading && records.isEmpty;

  NavganState copyWith({
    NavganViewStatus? status,
    List<NavganEntity>? records,
    NavganEntity? selectedNavgan,
    bool clearSelectedNavgan = false,
    List<GradePatternEntity>? gradePatterns,
    List<GradePatternReferenceEntity>? gradeReferences,
    GradePatternEntity? selectedGradePattern,
    bool clearSelectedGradePattern = false,
    GradePatternEntity? gradePatternDetail,
    bool clearGradePatternDetail = false,
    int? loadingGradeDetailId,
    bool clearLoadingGradeDetailId = false,
    List<NavganServiceGroupEntity>? serviceGroups,
    EmdadServiceCategoryEntity? selectedServiceCategory,
    bool clearSelectedServiceCategory = false,
    List<NavganDefectEntity>? defects,
    List<NavganDefectEntity>? committedDefects,
    int? loadingDefectServiceCategoryId,
    bool clearLoadingDefectServiceCategoryId = false,
    String? errorMessage,
    bool clearErrorMessage = false,
    String? successMessage,
    bool clearSuccessMessage = false,
    bool? isGradePatternsLoading,
    bool? isGradeReferencesLoading,
    bool? isGradeDetailLoading,
    bool? isGradeSubmitting,
    bool? isGradeDeleting,
    bool? isServiceGroupsLoading,
    bool? isServicesSubmitting,
    bool? isDefectsLoading,
    bool? isDefectsSubmitting,
  }) {
    return NavganState(
      status: status ?? this.status,
      records: records ?? this.records,
      selectedNavgan: clearSelectedNavgan
          ? null
          : selectedNavgan ?? this.selectedNavgan,
      gradePatterns: gradePatterns ?? this.gradePatterns,
      gradeReferences: gradeReferences ?? this.gradeReferences,
      selectedGradePattern: clearSelectedGradePattern
          ? null
          : selectedGradePattern ?? this.selectedGradePattern,
      gradePatternDetail: clearGradePatternDetail
          ? null
          : gradePatternDetail ?? this.gradePatternDetail,
      loadingGradeDetailId: clearLoadingGradeDetailId
          ? null
          : loadingGradeDetailId ?? this.loadingGradeDetailId,
      serviceGroups: serviceGroups ?? this.serviceGroups,
      selectedServiceCategory: clearSelectedServiceCategory
          ? null
          : selectedServiceCategory ?? this.selectedServiceCategory,
      defects: defects ?? this.defects,
      committedDefects: committedDefects ?? this.committedDefects,
      loadingDefectServiceCategoryId: clearLoadingDefectServiceCategoryId
          ? null
          : loadingDefectServiceCategoryId ?? this.loadingDefectServiceCategoryId,
      errorMessage:
          clearErrorMessage ? null : errorMessage ?? this.errorMessage,
      successMessage:
          clearSuccessMessage ? null : successMessage ?? this.successMessage,
      isGradePatternsLoading:
          isGradePatternsLoading ?? this.isGradePatternsLoading,
      isGradeReferencesLoading:
          isGradeReferencesLoading ?? this.isGradeReferencesLoading,
      isGradeDetailLoading: isGradeDetailLoading ?? this.isGradeDetailLoading,
      isGradeSubmitting: isGradeSubmitting ?? this.isGradeSubmitting,
      isGradeDeleting: isGradeDeleting ?? this.isGradeDeleting,
      isServiceGroupsLoading:
          isServiceGroupsLoading ?? this.isServiceGroupsLoading,
      isServicesSubmitting: isServicesSubmitting ?? this.isServicesSubmitting,
      isDefectsLoading: isDefectsLoading ?? this.isDefectsLoading,
      isDefectsSubmitting: isDefectsSubmitting ?? this.isDefectsSubmitting,
    );
  }
}
