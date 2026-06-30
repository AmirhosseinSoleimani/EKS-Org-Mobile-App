import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../../domain/entity/last_evaluation_response_entity.dart';

class EvaluationMainFormController {
  EvaluationMainFormController({
    VoidCallback? onChanged,
  }) : _onChanged = onChanged;

  final VoidCallback? _onChanged;

  final kilometerController = TextEditingController();
  final customerDistanceController = TextEditingController();

  final assignDateController = TextEditingController();
  final assignTimeController = TextEditingController();

  final arriveDateController = TextEditingController();
  final arriveTimeController = TextEditingController();

  final serviceController = TextEditingController();
  final descriptionController = TextEditingController();

  final ValueNotifier<bool> isFreewayTollPaid = ValueNotifier<bool>(false);

  DateTime? _assignDateTime;
  DateTime? _arriveDateTime;

  DateTime? get assignDateTime => _assignDateTime;
  DateTime? get arriveDateTime => _arriveDateTime;

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

    _onChanged?.call();
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

    _onChanged?.call();
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

    _onChanged?.call();
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

    _onChanged?.call();
  }

  void setAssignDateTimeFromString(String? dateTimeString) {
    final dateTime = DateTime.tryParse(dateTimeString ?? '');
    if (dateTime == null) return;

    _assignDateTime = dateTime;

    assignDateController.text = _formatJalaliDate(dateTime);
    assignTimeController.text = _formatTime(dateTime);

    _onChanged?.call();
  }

  void setArriveDateTimeFromString(String? dateTimeString) {
    final dateTime = DateTime.tryParse(dateTimeString ?? '');
    if (dateTime == null) return;

    _arriveDateTime = dateTime;

    arriveDateController.text = _formatJalaliDate(dateTime);
    arriveTimeController.text = _formatTime(dateTime);

    _onChanged?.call();
  }

  void setFromCubit({
    num? kilometer,
    num? distanceToCustomer,
    DateTime? assign,
    DateTime? arrive,
  }) {
    kilometerController.text = _formatNumber(kilometer);
    customerDistanceController.text = _formatNumber(distanceToCustomer);

    if (assign != null) {
      _assignDateTime = assign;
      assignDateController.text = _formatJalaliDate(assign);
      assignTimeController.text = _formatTime(assign);
    }

    if (arrive != null) {
      _arriveDateTime = arrive;
      arriveDateController.text = _formatJalaliDate(arrive);
      arriveTimeController.text = _formatTime(arrive);
    }

    _onChanged?.call();
  }


  void fill({
    num? kilometer,
    num? distanceToCustomer,
    String? assignDate,
    String? arriveDate,
    String? description,
  }) {
    setAssignDateTimeFromString(assignDate);
    setArriveDateTimeFromString(arriveDate);

    customerDistanceController.text = _formatNumber(distanceToCustomer);
    kilometerController.text = _formatNumber(kilometer);
    descriptionController.text = description ?? '';

    _onChanged?.call();
  }

  void setServiceTitle(String? title) {
    serviceController.text = title ?? '';
    _onChanged?.call();
  }

  String _formatJalaliDate(DateTime dateTime) {
    final jalali = Jalali.fromDateTime(dateTime);

    final year = jalali.year.toString().padLeft(4, '0');
    final month = jalali.month.toString().padLeft(2, '0');
    final day = jalali.day.toString().padLeft(2, '0');

    return '$year/$month/$day';
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  String _formatNumber(num? value) {
    if (value == null) return '';

    if (value % 1 == 0) {
      return value.toInt().toString();
    }

    return value.toString();
  }

  void dispose() {
    kilometerController.dispose();
    customerDistanceController.dispose();

    assignDateController.dispose();
    assignTimeController.dispose();

    arriveDateController.dispose();
    arriveTimeController.dispose();

    serviceController.dispose();
    descriptionController.dispose();

    isFreewayTollPaid.dispose();
  }
}