import 'package:flutter/material.dart';

class EvaluationMainFormController {
  EvaluationMainFormController(this._onChanged);

  final VoidCallback _onChanged;

  final kilometerController = TextEditingController();
  final customerDistanceController = TextEditingController();

  final assignDateController = TextEditingController();
  final assignTimeController = TextEditingController();

  final arriveDateController = TextEditingController();
  final arriveTimeController = TextEditingController();

  DateTime? _assignDateTime;
  DateTime? _arriveDateTime;

  DateTime? get assignDateTime => _assignDateTime;
  DateTime? get arriveDateTime => _arriveDateTime;

  // 👇 UI -> state update
  void setAssignDate(DateTime? date) {
    if (date == null) return;
    final current = _assignDateTime ?? DateTime.now();

    _assignDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      current.hour,
      current.minute,
    );

    _onChanged();
  }

  void setAssignTime(DateTime time) {
    final current = _assignDateTime ?? DateTime.now();

    _assignDateTime = DateTime(
      current.year,
      current.month,
      current.day,
      time.hour,
      time.minute,
    );

    _onChanged();
  }

  void setArriveDate(DateTime? date) {
    if (date == null) return;
    final current = _arriveDateTime ?? DateTime.now();

    _arriveDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      current.hour,
      current.minute,
    );

    _onChanged();
  }

  void setArriveTime(DateTime time) {
    final current = _arriveDateTime ?? DateTime.now();

    _arriveDateTime = DateTime(
      current.year,
      current.month,
      current.day,
      time.hour,
      time.minute,
    );

    _onChanged();
  }

  /// 👇 Cubit -> UI sync
  void setFromCubit({
    required num? kilometer,
    required num? distanceToCustomer,
    required DateTime? assign,
    required DateTime? arrive,
  }) {
    kilometerController.text = kilometer?.toString() ?? '';
    customerDistanceController.text = distanceToCustomer?.toString() ?? '';

    if (assign != null) {
      _assignDateTime = assign;
      assignDateController.text = _formatDate(assign);
      assignTimeController.text = _formatTime(assign);
    }

    if (arrive != null) {
      _arriveDateTime = arrive;
      arriveDateController.text = _formatDate(arrive);
      arriveTimeController.text = _formatTime(arrive);
    }
  }

  void dispose() {
    kilometerController.dispose();
    customerDistanceController.dispose();
    assignDateController.dispose();
    assignTimeController.dispose();
    arriveDateController.dispose();
    arriveTimeController.dispose();
  }

  String _formatDate(DateTime d) =>
      '${d.year}/${d.month}/${d.day}';

  String _formatTime(DateTime d) =>
      '${d.hour}:${d.minute}';
}