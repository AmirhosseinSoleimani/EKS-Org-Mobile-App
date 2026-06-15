class HomeServicePartSelectionViewModel {
  final int id;
  final String title;
  final bool isRequired;
  final bool isSelected;

  const HomeServicePartSelectionViewModel({
    required this.id,
    required this.title,
    this.isRequired = false,
    this.isSelected = false,
  });

  HomeServicePartSelectionViewModel copyWith({
    int? id,
    String? title,
    bool? isRequired,
    bool? isSelected,
  }) {
    return HomeServicePartSelectionViewModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isRequired: isRequired ?? this.isRequired,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}