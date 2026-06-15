import 'home_service_part_selection_view_model.dart';

class SelectedHomeServicePartViewModel {
  final int id;
  final String title;
  final bool isRequired;

  const SelectedHomeServicePartViewModel({
    required this.id,
    required this.title,
    this.isRequired = false,
  });

  factory SelectedHomeServicePartViewModel.fromSelection(
      HomeServicePartSelectionViewModel part,
      ) {
    return SelectedHomeServicePartViewModel(
      id: part.id,
      title: part.title,
      isRequired: part.isRequired,
    );
  }

  HomeServicePartSelectionViewModel toSelection() {
    return HomeServicePartSelectionViewModel(
      id: id,
      title: title,
      isRequired: isRequired,
      isSelected: true,
    );
  }

  SelectedHomeServicePartViewModel copyWith({
    int? id,
    String? title,
    bool? isRequired,
  }) {
    return SelectedHomeServicePartViewModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isRequired: isRequired ?? this.isRequired,
    );
  }
}