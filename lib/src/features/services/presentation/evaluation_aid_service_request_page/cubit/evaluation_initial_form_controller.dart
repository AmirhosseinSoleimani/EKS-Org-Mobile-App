import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/last_evaluation_entity.dart';
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

class EvaluationAidServiceFormController {
  final kilometerController = TextEditingController();
  final customerDistanceController = TextEditingController();

  final assignDateController = TextEditingController();
  final assignTimeController = TextEditingController();
  DateTime? assignDateTime;

  final arriveDateController = TextEditingController();
  final arriveTimeController = TextEditingController();
  DateTime? arriveDateTime;

  final serviceController = TextEditingController();
  final descriptionController = TextEditingController();

  final ValueNotifier<bool> isFreewayTollPaid = ValueNotifier<bool>(false);

  void setAssignDate(DateTime? date) {
    if (date == null) return;

    final current = assignDateTime ?? DateTime.now();

    assignDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      current.hour,
      current.minute,
    );
  }

  void setAssignTime(DateTime time) {
    final current = assignDateTime ?? DateTime.now();

    assignDateTime = DateTime(
      current.year,
      current.month,
      current.day,
      time.hour,
      time.minute,
    );
  }

  void setArriveDate(DateTime? date) {
    if (date == null) return;

    final current = arriveDateTime ?? DateTime.now();

    arriveDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      current.hour,
      current.minute,
    );
  }

  void setArriveTime(DateTime time) {
    final current = arriveDateTime ?? DateTime.now();

    arriveDateTime = DateTime(
      current.year,
      current.month,
      current.day,
      time.hour,
      time.minute,
    );
  }

  void fillFromLastEvaluation(LastEvaluationEntity? lastEvaluation) {
    if (lastEvaluation == null) return;

    _setAssignDateTimeFromString(lastEvaluation.assignDate);
    _setArriveDateTimeFromString(lastEvaluation.arriveDate);

    customerDistanceController.text = _formatNumber(
      lastEvaluation.distanceToCustomer,
    );

    kilometerController.text = _formatNumber(lastEvaluation.customerKilometer);

    descriptionController.text = lastEvaluation.description ?? '';
  }

  void setServiceTitle(String? title) {
    serviceController.text = title ?? '';
  }

  void _setAssignDateTimeFromString(String? dateTimeString) {
    final dateTime = DateTime.tryParse(dateTimeString ?? '');
    if (dateTime == null) return;

    setAssignDate(dateTime);
    setAssignTime(dateTime);

    assignDateController.text = _formatJalaliDate(dateTime);
    assignTimeController.text = _formatTime(dateTime);
  }

  void _setArriveDateTimeFromString(String? dateTimeString) {
    final dateTime = DateTime.tryParse(dateTimeString ?? '');
    if (dateTime == null) return;

    setArriveDate(dateTime);
    setArriveTime(dateTime);

    arriveDateController.text = _formatJalaliDate(dateTime);
    arriveTimeController.text = _formatTime(dateTime);
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
