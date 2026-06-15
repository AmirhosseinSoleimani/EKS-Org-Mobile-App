import 'home_service_package_selection_view_model.dart';
import 'selected_home_service_labor_view_model.dart';

class SelectedHomeServicePackageViewModel {
  final String localId;

  final int packageId;
  final String packageTitle;

  final int? categoryId;
  final String? categoryTitle;

  final List<SelectedHomeServiceLaborViewModel> labors;

  const SelectedHomeServicePackageViewModel({
    required this.localId,
    required this.packageId,
    required this.packageTitle,
    this.categoryId,
    this.categoryTitle,
    this.labors = const [],
  });

  factory SelectedHomeServicePackageViewModel.fromSelection(
      HomeServicePackageSelectionViewModel selection, {
        String? localId,
      }) {
    final selectedLabors = selection.labors
        .where((labor) => labor.isEffectivelySelected)
        .map(SelectedHomeServiceLaborViewModel.fromSelection)
        .toList();

    return SelectedHomeServicePackageViewModel(
      localId: localId ?? DateTime.now().microsecondsSinceEpoch.toString(),
      packageId: selection.packageId ?? 0,
      packageTitle: selection.packageTitle ?? '',
      categoryId: selection.categoryId,
      categoryTitle: selection.categoryTitle,
      labors: selectedLabors,
    );
  }

  factory SelectedHomeServicePackageViewModel.fromDraft(
      HomeServicePackageSelectionViewModel draft, {
        String? localId,
      }) {
    return SelectedHomeServicePackageViewModel.fromSelection(
      draft,
      localId: localId,
    );
  }

  HomeServicePackageSelectionViewModel toSelection() {
    return HomeServicePackageSelectionViewModel(
      categoryId: categoryId,
      categoryTitle: categoryTitle,
      packageId: packageId,
      packageTitle: packageTitle,
      labors: labors.map((labor) => labor.toSelection()).toList(),
    );
  }

  SelectedHomeServicePackageViewModel copyWith({
    String? localId,
    int? packageId,
    String? packageTitle,
    int? categoryId,
    String? categoryTitle,
    List<SelectedHomeServiceLaborViewModel>? labors,
  }) {
    return SelectedHomeServicePackageViewModel(
      localId: localId ?? this.localId,
      packageId: packageId ?? this.packageId,
      packageTitle: packageTitle ?? this.packageTitle,
      categoryId: categoryId ?? this.categoryId,
      categoryTitle: categoryTitle ?? this.categoryTitle,
      labors: labors ?? this.labors,
    );
  }
}