import 'home_service_labor_selection_view_model.dart';
import 'selected_home_service_package_view_model.dart';

class HomeServicePackageSelectionViewModel {
  final int? categoryId;
  final String? categoryTitle;

  final int? packageId;
  final String? packageTitle;

  final List<HomeServiceLaborSelectionViewModel> labors;

  const HomeServicePackageSelectionViewModel({
    this.categoryId,
    this.categoryTitle,
    this.packageId,
    this.packageTitle,
    this.labors = const [],
  });

  factory HomeServicePackageSelectionViewModel.fromSelectedPackage(
      SelectedHomeServicePackageViewModel package,
      ) {
    return HomeServicePackageSelectionViewModel(
      categoryId: package.categoryId,
      categoryTitle: package.categoryTitle,
      packageId: package.packageId,
      packageTitle: package.packageTitle,
      labors: package.labors.map((labor) => labor.toSelection()).toList(),
    );
  }

  bool get hasSelectedPackage => packageId != null;

  bool get hasSelectedLaborOrPart {
    return labors.any((labor) => labor.isEffectivelySelected);
  }

  HomeServicePackageSelectionViewModel copyWith({
    int? categoryId,
    String? categoryTitle,
    int? packageId,
    String? packageTitle,
    List<HomeServiceLaborSelectionViewModel>? labors,
    bool clearCategory = false,
    bool clearPackage = false,
  }) {
    return HomeServicePackageSelectionViewModel(
      categoryId: clearCategory ? null : categoryId ?? this.categoryId,
      categoryTitle: clearCategory ? null : categoryTitle ?? this.categoryTitle,
      packageId: clearPackage ? null : packageId ?? this.packageId,
      packageTitle: clearPackage ? null : packageTitle ?? this.packageTitle,
      labors: labors ?? this.labors,
    );
  }
}