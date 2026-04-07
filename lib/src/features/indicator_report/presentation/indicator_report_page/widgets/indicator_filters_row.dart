import 'package:eks_sana_plus_org/src/features/indicator_report/presentation/indicator_report_page/cubit/indicator_report_cubit.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/presentation/indicator_report_page/widgets/date_drop_down.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import 'indicator_filter_button.dart';
import 'service_drop_down.dart';

class IndicatorFiltersRow extends StatefulWidget {
  const IndicatorFiltersRow({super.key});

  @override
  State<IndicatorFiltersRow> createState() => _IndicatorFiltersRowState();
}

class _IndicatorFiltersRowState extends State<IndicatorFiltersRow> {
  final _serviceKey = GlobalKey();
  final _dateKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showServiceDropdown() {
    if (_overlayEntry != null) {
      _removeOverlay();
      return;
    }
    final box = _serviceKey.currentContext!.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (_) => ServiceDropdown(
        position: offset,
        width: box.size.width,
        onDismiss: _removeOverlay,
        onSelect: (type) {
          context.read<IndicatorReportCubit>().setServiceType(type);
          _removeOverlay();
        },
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _showDateDropdown() {
    if (_overlayEntry != null) {
      _removeOverlay();
      return;
    }
    final box = _dateKey.currentContext!.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);
    final cubit = context.read<IndicatorReportCubit>();
    _overlayEntry = OverlayEntry(
      builder: (_) => DateDropdown(
        position: offset,
        width: box.size.width + 50,
        initialFromDate: cubit.selectedFromDate != null
            ? Jalali.fromDateTime(cubit.selectedFromDate!)
            : null,
        initialToDate: cubit.selectedToDate != null
            ? Jalali.fromDateTime(cubit.selectedToDate!)
            : null,
        onApply: (from, to) {
          if (from != null) cubit.setFromDate(from.toDateTime());
          if (to != null) cubit.setToDate(to.toDateTime());
        },
        onDismiss: _removeOverlay,
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<IndicatorReportCubit>();
    return Row(
      children: [
        KeyedSubtree(
          key: _dateKey,
          child: ValueListenableBuilder(
            valueListenable: cubit.selectedFromDateNotifier,
            builder: (_, fromDate, __) => ValueListenableBuilder(
              valueListenable: cubit.selectedToDateNotifier,
              builder: (_, toDate, __) => IndicatorFilterButton(
                title: fromDate != null || toDate != null
                    ? "تاریخ انتخاب شده"
                    : "فیلتر بر اساس تاریخ",
                onTap: _showDateDropdown,
              ),
            ),
          ),
        ),
        Space.w16,
        KeyedSubtree(
          key: _serviceKey,
          child: ValueListenableBuilder(
            valueListenable: cubit.selectedServiceTypeNotifier,
            builder: (_, serviceType, __) => IndicatorFilterButton(
              title: serviceType?.label ?? "نوع خدمت",
              onTap: _showServiceDropdown,
            ),
          ),
        ),
      ],
    );
  }
}

