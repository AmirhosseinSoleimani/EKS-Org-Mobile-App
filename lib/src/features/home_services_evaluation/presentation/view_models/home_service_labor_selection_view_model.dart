import 'home_service_part_selection_view_model.dart';

class HomeServiceLaborSelectionViewModel {
  final int id;
  final String title;
  final bool isRequired;
  final bool isSelected;
  final List<HomeServicePartSelectionViewModel> parts;

  const HomeServiceLaborSelectionViewModel({
    required this.id,
    required this.title,
    this.isRequired = false,
    this.isSelected = false,
    this.parts = const [],
  });

  bool get hasParts => parts.isNotEmpty;

  bool get hasSelectedPart {
    return parts.any((part) => part.isRequired || part.isSelected);
  }

  bool get isEffectivelySelected {
    return isRequired || isSelected || hasSelectedPart;
  }

  HomeServiceLaborSelectionViewModel copyWith({
    int? id,
    String? title,
    bool? isRequired,
    bool? isSelected,
    List<HomeServicePartSelectionViewModel>? parts,
  }) {
    return HomeServiceLaborSelectionViewModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isRequired: isRequired ?? this.isRequired,
      isSelected: isSelected ?? this.isSelected,
      parts: parts ?? this.parts,
    );
  }
}