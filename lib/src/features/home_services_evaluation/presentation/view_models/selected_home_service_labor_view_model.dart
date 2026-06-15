import 'home_service_labor_selection_view_model.dart';
import 'selected_home_service_part_view_model.dart';

class SelectedHomeServiceLaborViewModel {
  final int id;
  final String title;
  final bool isRequired;
  final List<SelectedHomeServicePartViewModel> parts;

  const SelectedHomeServiceLaborViewModel({
    required this.id,
    required this.title,
    this.isRequired = false,
    this.parts = const [],
  });

  bool get hasParts => parts.isNotEmpty;

  factory SelectedHomeServiceLaborViewModel.fromSelection(
      HomeServiceLaborSelectionViewModel labor,
      ) {
    final selectedParts = labor.parts
        .where((part) => part.isRequired || part.isSelected)
        .map(SelectedHomeServicePartViewModel.fromSelection)
        .toList();

    return SelectedHomeServiceLaborViewModel(
      id: labor.id,
      title: labor.title,
      isRequired: labor.isRequired,
      parts: selectedParts,
    );
  }

  HomeServiceLaborSelectionViewModel toSelection() {
    return HomeServiceLaborSelectionViewModel(
      id: id,
      title: title,
      isRequired: isRequired,
      isSelected: true,
      parts: parts.map((part) => part.toSelection()).toList(),
    );
  }

  SelectedHomeServiceLaborViewModel copyWith({
    int? id,
    String? title,
    bool? isRequired,
    List<SelectedHomeServicePartViewModel>? parts,
  }) {
    return SelectedHomeServiceLaborViewModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isRequired: isRequired ?? this.isRequired,
      parts: parts ?? this.parts,
    );
  }
}