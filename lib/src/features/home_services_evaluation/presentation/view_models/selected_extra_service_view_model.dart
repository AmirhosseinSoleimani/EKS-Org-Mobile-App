import 'selected_home_service_labor_view_model.dart';

class SelectedExtraServiceViewModel {
  final String localId;
  final SelectedHomeServiceLaborViewModel labor;

  const SelectedExtraServiceViewModel({
    required this.localId,
    required this.labor,
  });

  SelectedExtraServiceViewModel copyWith({
    String? localId,
    SelectedHomeServiceLaborViewModel? labor,
  }) {
    return SelectedExtraServiceViewModel(
      localId: localId ?? this.localId,
      labor: labor ?? this.labor,
    );
  }
}