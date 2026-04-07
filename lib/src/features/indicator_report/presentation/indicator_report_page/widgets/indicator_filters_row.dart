import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/presentation/indicator_report_page/cubit/indicator_report_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    _overlayEntry = OverlayEntry(
      builder: (_) => _DateDropdown(
        position: offset,
        width: box.size.width,
        onDismiss: _removeOverlay,
        onApply: (from, to) {
          //context.read<IndicatorReportCubit>().setDateRange(from, to);
          _removeOverlay();
        },
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
            builder: (_, fromDate, __) => IndicatorFilterButton(
              title:
                  fromDate != null ? "تاریخ انتخاب شده" : "فیلتر بر اساس تاریخ",
              onTap: _showDateDropdown,
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


class _DateDropdown extends StatefulWidget {
  final Offset position;
  final double width;
  final VoidCallback onDismiss;
  final void Function(String from, String to) onApply;

  const _DateDropdown({
    required this.position,
    required this.width,
    required this.onDismiss,
    required this.onApply,
  });

  @override
  State<_DateDropdown> createState() => _DateDropdownState();
}

class _DateDropdownState extends State<_DateDropdown> {
  final _fromController = TextEditingController();
  final _toController = TextEditingController();

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: widget.onDismiss,
          behavior: HitTestBehavior.translucent,
          child: const SizedBox.expand(),
        ),
        Positioned(
          top: widget.position.dy + AppSize.s40,
          left: widget.position.dx,
          width: widget.width,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(AppSize.s8),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _fromController,
                    decoration: const InputDecoration(labelText: 'از تاریخ'),
                    readOnly: true,
                    onTap: () async {
                      // جایگزین با date picker دلخواهت
                      final picked = await _pickDate(context);
                      if (picked != null) _fromController.text = picked;
                    },
                  ),
                  Space.h8,
                  TextField(
                    controller: _toController,
                    decoration: const InputDecoration(labelText: 'تا تاریخ'),
                    readOnly: true,
                    onTap: () async {
                      final picked = await _pickDate(context);
                      if (picked != null) _toController.text = picked;
                    },
                  ),
                  Space.h12,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => widget.onApply(
                        _fromController.text,
                        _toController.text,
                      ),
                      child: const Text('اعمال'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<String?> _pickDate(BuildContext context) async {
    // اینجا date picker شمسی یا میلادی خودت رو صدا بزن
    // مثلاً persian_datetime_picker یا هر پکیجی که داری
    return null;
  }
}
