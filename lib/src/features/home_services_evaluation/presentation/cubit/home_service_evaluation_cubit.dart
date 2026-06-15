import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/cubit/home_service_evaluation_data.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/cubit/home_service_evaluation_sheet_type.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/cubit/home_service_evaluation_state.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/view_models/home_service_package_selection_view_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/view_models/selected_extra_service_view_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/view_models/selected_home_service_package_view_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeServiceEvaluationCubit extends Cubit<HomeServiceEvaluationState> {
  HomeServiceEvaluationCubit()
      : super(const HomeServiceEvaluationState.idle());

  HomeServiceEvaluationData get data {
    return state.when(
      idle: (data) => data,
      loading: (data) => data,
      loaded: (data) => data,
      failure: (data, _) => data,
      connectionError: (data) => data,
      submitLoading: (data) => data,
      submitSuccess: (data, _) => data,
      submitFailure: (data, _) => data,
      sheetLoading: (data, _) => data,
      sheetLoaded: (data, _) => data,
      sheetFailure: (data, _, _) => data,
    );
  }

  Future<void> init() async {
    emit(HomeServiceEvaluationState.loading(data: data));

    // بعداً:
    // selected request
    // request detail
    // emdadgar info
    // initial required data

    emit(HomeServiceEvaluationState.loaded(data: data));
  }

  void openAddPackageSheet() {
    emit(
      HomeServiceEvaluationState.sheetLoaded(
        sheetType: HomeServiceEvaluationSheetType.package,
        data: data.copyWith(
          packageDraft: const HomeServicePackageSelectionViewModel(),
          clearEditingPackageLocalId: true,
        ),
      ),
    );
  }

  void openEditPackageSheet(String localId) {
    final selectedPackage = data.selectedPackages
        .where((item) => item.localId == localId)
        .firstOrNull;

    if (selectedPackage == null) return;

    emit(
      HomeServiceEvaluationState.sheetLoaded(
        sheetType: HomeServiceEvaluationSheetType.package,
        data: data.copyWith(
          editingPackageLocalId: localId,
          packageDraft: HomeServicePackageSelectionViewModel.fromSelectedPackage(
            selectedPackage,
          ),
        ),
      ),
    );
  }

  void removeSelectedPackage(String localId) {
    emit(
      HomeServiceEvaluationState.loaded(
        data: data.copyWith(
          selectedPackages: data.selectedPackages
              .where((item) => item.localId != localId)
              .toList(),
        ),
      ),
    );
  }

  void openAddPartSheet(String packageLocalId) {
    emit(
      HomeServiceEvaluationState.sheetLoaded(
        sheetType: HomeServiceEvaluationSheetType.packagePart,
        data: data.copyWith(
          addingPartPackageLocalId: packageLocalId,
        ),
      ),
    );
  }

  void toggleLabor({
    required int laborId,
    required bool selected,
  }) {
    final draft = data.packageDraft;
    if (draft == null) return;

    final updatedLabors = draft.labors.map((labor) {
      if (labor.id != laborId) return labor;
      if (labor.isRequired) return labor;

      return labor.copyWith(isSelected: selected);
    }).toList();

    emit(
      HomeServiceEvaluationState.sheetLoaded(
        sheetType: HomeServiceEvaluationSheetType.package,
        data: data.copyWith(
          packageDraft: draft.copyWith(labors: updatedLabors),
        ),
      ),
    );
  }

  void togglePart({
    required int laborId,
    required int partId,
    required bool selected,
  }) {
    final draft = data.packageDraft;
    if (draft == null) return;

    final updatedLabors = draft.labors.map((labor) {
      if (labor.id != laborId) return labor;

      final updatedParts = labor.parts.map((part) {
        if (part.id != partId) return part;
        if (part.isRequired) return part;

        return part.copyWith(isSelected: selected);
      }).toList();

      final hasSelectedPart = updatedParts.any((part) => part.isSelected);

      return labor.copyWith(
        parts: updatedParts,
        isSelected: labor.isRequired || hasSelectedPart,
      );
    }).toList();

    emit(
      HomeServiceEvaluationState.sheetLoaded(
        sheetType: HomeServiceEvaluationSheetType.package,
        data: data.copyWith(
          packageDraft: draft.copyWith(labors: updatedLabors),
        ),
      ),
    );
  }

  void confirmPackageDraft() {
    final draft = data.packageDraft;
    if (draft == null || draft.packageId == null) return;

    final selectedPackage =
    SelectedHomeServicePackageViewModel.fromDraft(draft);

    final editingLocalId = data.editingPackageLocalId;

    final updatedPackages = editingLocalId == null
        ? [...data.selectedPackages, selectedPackage]
        : data.selectedPackages.map((item) {
      if (item.localId != editingLocalId) return item;
      return selectedPackage.copyWith(localId: editingLocalId);
    }).toList();

    emit(
      HomeServiceEvaluationState.loaded(
        data: data.copyWith(
          selectedPackages: updatedPackages,
          clearPackageDraft: true,
          clearEditingPackageLocalId: true,
        ),
      ),
    );
  }

  void openExtraServiceSheet() {
    emit(
      HomeServiceEvaluationState.sheetLoaded(
        sheetType: HomeServiceEvaluationSheetType.extraService,
        data: data,
      ),
    );
  }

  void addExtraService(SelectedExtraServiceViewModel item) {
    emit(
      HomeServiceEvaluationState.loaded(
        data: data.copyWith(
          selectedExtraServices: [
            ...data.selectedExtraServices,
            item,
          ],
        ),
      ),
    );
  }

  void removeExtraService(String localId) {
    emit(
      HomeServiceEvaluationState.loaded(
        data: data.copyWith(
          selectedExtraServices: data.selectedExtraServices
              .where((item) => item.localId != localId)
              .toList(),
        ),
      ),
    );
  }

  Future<void> submitEvaluation() async {
    emit(HomeServiceEvaluationState.submitLoading(data: data));

    // بعداً builder + usecase

    emit(
      HomeServiceEvaluationState.submitSuccess(
        data: data,
        message: const BottomSheetMessageModel(
          title: 'موفق',
          message: 'ارزیابی با موفقیت ثبت شد',
        ),
      ),
    );
  }

  void emitFailure(String message) {
    emit(
      HomeServiceEvaluationState.failure(
        data: data,
        message: BottomSheetMessageModel(
          title: 'خطا',
          message: message,
        ),
      ),
    );
  }
}