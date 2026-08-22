import 'package:eks_sana_plus_org/src/features/services/domain/entities/evaluation_history_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/key_value_wiget_row.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/vertical_line_indicator.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/list_widgets/list_section_header.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/key_value_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

import '../../widgets/timeline_item_card.dart';

class EvaluationListView extends StatefulWidget {
  final List<EvaluationHistoryItemEntity> items;
  final Widget icon;

  const EvaluationListView({
    super.key,
    required this.items,
    required this.icon,
  });

  @override
  State<EvaluationListView> createState() => _EvaluationListViewState();
}

class _EvaluationListViewState extends State<EvaluationListView> {
  static const int _initialVisibleCount = 1;

  bool _showAll = false;

  @override
  void didUpdateWidget(covariant EvaluationListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items.length != widget.items.length) {
      _showAll = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEmpty = widget.items.isEmpty;
    final visibleItems = _showAll
        ? widget.items
        : widget.items.take(_initialVisibleCount).toList(growable: false);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: ListSectionHeader(title: 'تاریخچه ارزیابی'),
          ),
          const SizedBox(height: 8),
          if (isEmpty)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.62,
              child: const Center(child: EmptyListWidget()),
            ),
          if (!isEmpty) ...[
            Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: VerticalLineIndicator(icon: widget.icon),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: visibleItems.length,
                    itemBuilder: (context, index) {
                      final item = visibleItems[index];

                      return TimelineItemCard(
                        expandedChildren: [
                          KeyValueRow(
                            label: 'ایراد',
                            value: _displayText(item.defectInfoTitle),
                          ),
                          KeyValueRow(
                            label: 'مسافت طی شده',
                            value: _displayNumber(item.distanceToCustomer),
                          ),
                          KeyValueRow(
                            label: 'مسافت حمل',
                            value: _displayNumber(item.distanceHamlCustomer),
                          ),
                          KeyValueRow(
                            label: 'زمان توقف (دقیقه)',
                            value: _displayNumber(item.stopTime),
                          ),
                          KeyValueRow(
                            label: 'استفاده از دکل',
                            value: _displayBool(item.useDakal),
                          ),
                          KeyValueRow(
                            label: 'عوارض آزادراهی',
                            value: _displayBool(item.payAvarezi),
                          ),
                          KeyValueRow(
                            label: 'زمان حضور',
                            value: _displayText(item.arriveDateTimeJalali),
                          ),
                          KeyValueRow(
                            label: 'زمان اتمام',
                            value: _displayText(item.endWorkDateTimeJalali),
                          ),
                          KeyValueRow(
                            label: 'علت کنسل مجاز',
                            value: _displayText(item.cancelReasonTitle),
                          ),
                          KeyValueRow(
                            label: 'علت در محل نبودن امدادخواه',
                            value: _displayText(item.cancelReasonDetailTitle),
                          ),
                          KeyValueRow(
                            label: 'توضیحات',
                            value: _displayText(item.description),
                          ),
                        ],
                        children: [
                          KeyValueWidgetRow(
                            label: 'وضعیت',
                            value: StatusLabel(
                              text: _evaluationStatusText(item.isAccepted),
                              color: _evaluationStatusColor(item.isAccepted),
                            ),
                          ),
                          KeyValueRow(
                            label: 'نوع فاکتور',
                            value: _displayText(item.statusTitle),
                          ),
                          KeyValueRow(
                            label: 'نام و نام خانوادگی',
                            value: _insertUserTitle(item),
                          ),
                          KeyValueRow(
                            label: 'تاریخ و ساعت ثبت',
                            value: _displayText(item.insertDateTimeJalali),
                          ),
                          KeyValueRow(
                            label: 'نوع ناوگان',
                            value: _displayText(item.emdadgarNavganTypeTitle),
                          ),
                          KeyValueRow(
                            label: 'نوع امداد',
                            value: _displayText(item.emdadServiceCategoryTitle),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            if (widget.items.length > 1)
              Center(
                child: TextButton(
                  onPressed: () => setState(() => _showAll = !_showAll),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BodyMediumText(
                        text: _showAll ? 'مشاهده کمتر' : 'مشاهده بیشتر',
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      Space.w4,
                      Icon(
                        _showAll ? Icons.expand_less : Icons.expand_more,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  String _insertUserTitle(EvaluationHistoryItemEntity item) {
    final insertUserName = item.insertUserName?.trim();
    if (insertUserName?.isNotEmpty == true) {
      return insertUserName!;
    }

    final fullName = '${item.firstName ?? ''} ${item.lastName ?? ''}'.trim();
    return fullName.isEmpty ? '---' : fullName;
  }

  String _evaluationStatusText(bool? isAccepted) {
    if (isAccepted == null) return '---';
    return isAccepted ? 'تایید شده' : 'تایید نشده';
  }

  Color _evaluationStatusColor(bool? isAccepted) {
    if (isAccepted == null) return Colors.grey;
    return isAccepted ? Colors.green : Colors.red;
  }

  String _displayText(String? value) {
    final normalized = value?.trim() ?? '';
    return normalized.isEmpty ? '---' : normalized;
  }

  String _displayNumber(num? value) {
    if (value == null) return '---';
    if (value is int || value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  String _displayBool(bool? value) {
    if (value == null) return '---';
    return value ? 'بله' : 'خیر';
  }
}
