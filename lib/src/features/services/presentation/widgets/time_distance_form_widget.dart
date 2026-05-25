import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/date_time_picker_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';

class TimeDistanceFormSection extends StatelessWidget {
  final TextEditingController assignDateController;
  final TextEditingController assignTimeController;
  final TextEditingController arriveDateController;
  final TextEditingController arriveTimeController;
  final TextEditingController kilometerController;
  final TextEditingController customerDistanceController;

  final Function(DateTime?) onAssignDateChange;
  final Function(DateTime) onAssignTimeChange;
  final Function(DateTime?) onArriveDateChange;
  final Function(DateTime) onArriveTimeChange;

  final String title;
  final String assignDateLabel;
  final String assignTimeLabel;
  final String arriveDateLabel;
  final String arriveTimeLabel;
  final String kilometerLabel;
  final String customerDistanceLabel;

  final String? kilometerHintText;
  final String? customerDistanceHintText;

  final TextInputType kilometerKeyboardType;
  final TextInputType customerDistanceKeyboardType;

  final bool hasBorder;

  const TimeDistanceFormSection({
    super.key,
    required this.assignDateController,
    required this.assignTimeController,
    required this.arriveDateController,
    required this.arriveTimeController,
    required this.onAssignDateChange,
    required this.onAssignTimeChange,
    required this.onArriveDateChange,
    required this.onArriveTimeChange,
    required this.kilometerController,
    required this.customerDistanceController,
    this.title = 'زمان و مسافت',
    this.assignDateLabel = 'تاریخ اعلام',
    this.assignTimeLabel = 'ساعت اعلام',
    this.arriveDateLabel = 'تاریخ حضور',
    this.arriveTimeLabel = 'ساعت حضور',
    this.kilometerLabel = 'کیلومتر خودرو',
    this.customerDistanceLabel = 'مسافت طی شده تا مشتری (کیلومتر)',
    this.kilometerHintText,
    this.customerDistanceHintText,
    this.kilometerKeyboardType = TextInputType.number,
    this.customerDistanceKeyboardType = TextInputType.number,

    this.hasBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return FormSectionContainer(
      hasBorder: hasBorder,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleLargeText(text: title, fontSize: 16),
          Space.h32,
          TextFormFieldWidget(
            controller: kilometerController,
            labelText: kilometerLabel,
            hintText: kilometerHintText,
            textInputType: kilometerKeyboardType,
          ),
          _formElementGap(),
          TextFormFieldWidget(
            controller: customerDistanceController,
            labelText: customerDistanceLabel,
            hintText: customerDistanceHintText,
            textInputType: customerDistanceKeyboardType,
          ),
          _formElementGap(),
          DateTimePickerSection(
            dateLabel: assignDateLabel,
            timeLabel: assignTimeLabel,
            dateController: assignDateController,
            timeController: assignTimeController,
            onDateChange: onAssignDateChange,
            onTimeChange: onAssignTimeChange,
          ),

          _formElementGap(),

          DateTimePickerSection(
            dateLabel: arriveDateLabel,
            timeLabel: arriveTimeLabel,
            dateController: arriveDateController,
            timeController: arriveTimeController,
            onDateChange: onArriveDateChange,
            onTimeChange: onArriveTimeChange,
          ),
        ],
      ),
    );
  }

  Widget _formElementGap() {
    return const SizedBox(height: AppSize.s20);
  }
}
