import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

class EvaluationTransportInformationFormController<T extends DropdownItem> {
  final acceptanceCodeController = TextEditingController();
  final transportDistanceController = TextEditingController();

  final endWorkDateController = TextEditingController();
  final endWorkTimeController = TextEditingController();

  DateTime? endWorkDateTime;

  final selectedRepresentation = ValueNotifier<T?>(null);

  final representationListNotifier = ValueNotifier<List<T>>([]);
  final isRepresentationLoading = ValueNotifier<bool>(false);

  List<T> get representationList => representationListNotifier.value;

  bool get hasRepresentationItems => representationList.isNotEmpty;

  void setSelectedRepresentation(T? item) {
    selectedRepresentation.value = item;
  }

  void setRepresentationList(List<T> items) {
    representationListNotifier.value = List<T>.from(items);
  }

  void clearRepresentationList() {
    representationListNotifier.value = [];
  }

  void setRepresentationLoading(bool value) {
    isRepresentationLoading.value = value;
  }

  void setEndWorkDate(DateTime? date) {
    if (date == null) return;

    final current = endWorkDateTime ?? DateTime.now();

    endWorkDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      current.hour,
      current.minute,
    );

    endWorkDateController.text = _formatJalaliDate(endWorkDateTime!);
  }

  void setEndWorkTime(DateTime time) {
    final current = endWorkDateTime ?? DateTime.now();

    endWorkDateTime = DateTime(
      current.year,
      current.month,
      current.day,
      time.hour,
      time.minute,
    );

    endWorkTimeController.text = _formatTime(endWorkDateTime!);
  }

  void fillFromLastEvaluation({
    num? acceptanceCode,
    num? transportDistanceKm,
    String? endWorkDate,
    Object? representationValue,
  }) {
    acceptanceCodeController.text = _formatNumber(
      acceptanceCode,
      hideZero: true,
    );

    transportDistanceController.text = _formatNumber(
      transportDistanceKm,
    );

    _setEndWorkDateTimeFromString(endWorkDate);

    syncSelectedRepresentationByValue(representationValue);
  }

  void syncSelectedRepresentationByValue(Object? value) {
    if (value == null || representationList.isEmpty) return;

    final item = _findRepresentationByValue(value);

    if (item != null) {
      selectedRepresentation.value = item;
    }
  }

  T? _findRepresentationByValue(Object value) {
    for (final item in representationList) {
      if (item.value?.toString() == value.toString()) {
        return item;
      }
    }

    return null;
  }

  void clear() {
    acceptanceCodeController.clear();
    transportDistanceController.clear();

    endWorkDateController.clear();
    endWorkTimeController.clear();
    endWorkDateTime = null;

    selectedRepresentation.value = null;
  }

  void _setEndWorkDateTimeFromString(String? dateTimeString) {
    final dateTime = DateTime.tryParse(dateTimeString ?? '');
    if (dateTime == null) return;

    endWorkDateTime = dateTime;

    endWorkDateController.text = _formatJalaliDate(dateTime);
    endWorkTimeController.text = _formatTime(dateTime);
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

  String _formatNumber(
      num? value, {
        bool hideZero = false,
      }) {
    if (value == null) return '';

    if (hideZero && value == 0) return '';

    if (value % 1 == 0) {
      return value.toInt().toString();
    }

    return value.toString();
  }

  void dispose() {
    acceptanceCodeController.dispose();
    transportDistanceController.dispose();

    endWorkDateController.dispose();
    endWorkTimeController.dispose();

    selectedRepresentation.dispose();

    representationListNotifier.dispose();
    isRepresentationLoading.dispose();
  }
}