import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/skill_certificate_entity.dart';

const _unset = Object();

enum RescuerSkillCertificatesStatus {
  initial,
  loading,
  loaded,
  submitting,
  success,
  failure,
  connectionError,
}

class RescuerSkillCertificatesState {
  final RescuerSkillCertificatesStatus status;
  final List<SkillCertificateEntity> items;
  final List<SkillCertificateEntity> filteredItems;
  final String searchText;
  final String? message;

  const RescuerSkillCertificatesState({
    this.status = RescuerSkillCertificatesStatus.initial,
    this.items = const [],
    this.filteredItems = const [],
    this.searchText = '',
    this.message,
  });

  bool get isLoading => status == RescuerSkillCertificatesStatus.loading;

  bool get isSubmitting =>
      status == RescuerSkillCertificatesStatus.submitting;

  bool get allSelected {
    final validItems = items.where((item) => item.id != null).toList();
    return validItems.isNotEmpty &&
        validItems.every((item) => item.selectable == true);
  }

  RescuerSkillCertificatesState copyWith({
    RescuerSkillCertificatesStatus? status,
    List<SkillCertificateEntity>? items,
    List<SkillCertificateEntity>? filteredItems,
    String? searchText,
    Object? message = _unset,
  }) {
    return RescuerSkillCertificatesState(
      status: status ?? this.status,
      items: items ?? this.items,
      filteredItems: filteredItems ?? this.filteredItems,
      searchText: searchText ?? this.searchText,
      message: identical(message, _unset) ? this.message : message as String?,
    );
  }
}
