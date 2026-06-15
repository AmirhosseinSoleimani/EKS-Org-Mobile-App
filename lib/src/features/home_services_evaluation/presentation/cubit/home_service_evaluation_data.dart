import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/view_models/home_service_package_selection_view_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/view_models/selected_extra_service_view_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/view_models/selected_home_service_package_view_model.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';

class HomeServiceEvaluationData {
  final HomeServiceRequestEntity? selectedRequest;
  final EmdadgarInfoEntity? emdadgarInfo;

  final HomeServicePackageSelectionViewModel? packageDraft;

  final String? editingPackageLocalId;
  final String? addingPartPackageLocalId;

  final List<SelectedHomeServicePackageViewModel> selectedPackages;
  final List<SelectedExtraServiceViewModel> selectedExtraServices;

  const HomeServiceEvaluationData({
    this.selectedRequest,
    this.emdadgarInfo,
    this.packageDraft,
    this.editingPackageLocalId,
    this.addingPartPackageLocalId,
    this.selectedPackages = const [],
    this.selectedExtraServices = const [],
  });

  HomeServiceEvaluationData copyWith({
    HomeServiceRequestEntity? selectedRequest,
    EmdadgarInfoEntity? emdadgarInfo,
    HomeServicePackageSelectionViewModel? packageDraft,
    String? editingPackageLocalId,
    String? addingPartPackageLocalId,
    List<SelectedHomeServicePackageViewModel>? selectedPackages,
    List<SelectedExtraServiceViewModel>? selectedExtraServices,
    bool clearPackageDraft = false,
    bool clearEditingPackageLocalId = false,
    bool clearAddingPartPackageLocalId = false,
  }) {
    return HomeServiceEvaluationData(
      selectedRequest: selectedRequest ?? this.selectedRequest,
      emdadgarInfo: emdadgarInfo ?? this.emdadgarInfo,
      packageDraft: clearPackageDraft
          ? null
          : packageDraft ?? this.packageDraft,
      editingPackageLocalId: clearEditingPackageLocalId
          ? null
          : editingPackageLocalId ?? this.editingPackageLocalId,
      addingPartPackageLocalId: clearAddingPartPackageLocalId
          ? null
          : addingPartPackageLocalId ?? this.addingPartPackageLocalId,
      selectedPackages: selectedPackages ?? this.selectedPackages,
      selectedExtraServices:
          selectedExtraServices ?? this.selectedExtraServices,
    );
  }
}
