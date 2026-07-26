import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/grade_pattern_entity.dart';
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
    this.selectedGradePattern,
    this.gradePatternDetail,
    this.serviceGroups = const [],
    this.defects = const [],
    this.selectedServiceCategory,
    this.errorMessage,
    this.successMessage,
    this.isGradePatternsLoading = false,
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
  final GradePatternEntity? selectedGradePattern;
  final GradePatternEntity? gradePatternDetail;
  final List<NavganServiceGroupEntity> serviceGroups;
  final List<NavganDefectEntity> defects;
  final EmdadServiceCategoryEntity? selectedServiceCategory;
  final String? errorMessage;
  final String? successMessage;
  final bool isGradePatternsLoading;
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
    GradePatternEntity? selectedGradePattern,
    bool clearSelectedGradePattern = false,
    GradePatternEntity? gradePatternDetail,
    bool clearGradePatternDetail = false,
    List<NavganServiceGroupEntity>? serviceGroups,
    List<NavganDefectEntity>? defects,
    EmdadServiceCategoryEntity? selectedServiceCategory,
    bool clearSelectedServiceCategory = false,
    String? errorMessage,
    bool clearErrorMessage = false,
    String? successMessage,
    bool clearSuccessMessage = false,
    bool? isGradePatternsLoading,
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
      selectedGradePattern: clearSelectedGradePattern
          ? null
          : selectedGradePattern ?? this.selectedGradePattern,
      gradePatternDetail: clearGradePatternDetail
          ? null
          : gradePatternDetail ?? this.gradePatternDetail,
      serviceGroups: serviceGroups ?? this.serviceGroups,
      defects: defects ?? this.defects,
      selectedServiceCategory: clearSelectedServiceCategory
          ? null
          : selectedServiceCategory ?? this.selectedServiceCategory,
      errorMessage:
          clearErrorMessage ? null : errorMessage ?? this.errorMessage,
      successMessage:
          clearSuccessMessage ? null : successMessage ?? this.successMessage,
      isGradePatternsLoading:
          isGradePatternsLoading ?? this.isGradePatternsLoading,
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
