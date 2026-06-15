import 'home_service_labor_selection_view_model.dart';

class HomeServicePackageSelectionViewModel {
  final String localId;
  final int packageId;
  final String packageTitle;
  final List<HomeServiceLaborSelectionViewModel> labors;

  const HomeServicePackageSelectionViewModel({
    required this.localId,
    required this.packageId,
    required this.packageTitle,
    required this.labors,
  });

  HomeServicePackageSelectionViewModel copyWith({
    String? localId,
    int? packageId,
    String? packageTitle,
    List<HomeServiceLaborSelectionViewModel>? labors,
  }) {
    return HomeServicePackageSelectionViewModel(
      localId: localId ?? this.localId,
      packageId: packageId ?? this.packageId,
      packageTitle: packageTitle ?? this.packageTitle,
      labors: labors ?? this.labors,
    );
  }
}