import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/cubit/evaluation_transport_Information_form_controller.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/date_time_picker_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/dropdown_selector.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransportInformationSection<T extends DropdownItem>
    extends StatelessWidget {
  final EvaluationTransportInformationFormController<T> controller;
  final String Function(T item) representationTitleBuilder;
  final ValueChanged<T>? onSelectRepresentation;
  final bool baseEditable;
  final bool distanceEditable;

  const TransportInformationSection({
    super.key,
    required this.controller,
    required this.representationTitleBuilder,
    this.onSelectRepresentation,
    this.baseEditable = true,
    this.distanceEditable = true,
  });

  @override
  Widget build(BuildContext context) {
    return FormSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleLargeText(
            text: 'اطلاعات حمل',
            fontSize: 16,
            textAlign: TextAlign.start,
          ),
          Space.h32,
          _buildAcceptanceCodeInput(),
          Space.h16,
          _buildRepresentationDropdown(),
          Space.h16,
          _buildTransportDistanceInput(),
          Space.h16,
          _buildEndWorkDateTimeRow(),
        ],
      ),
    );
  }

  Widget _buildRepresentationDropdown() {
    return ValueListenableBuilder<bool>(
      valueListenable: controller.isRepresentationLoading,
      builder: (context, isLoading, _) {
        return ValueListenableBuilder<List<T>>(
          valueListenable: controller.representationListNotifier,
          builder: (context, items, _) {
            return DropdownSelector<T>(
              label: 'نمایندگی',
              placeholder: isLoading ? 'در حال بارگذاری...' : 'انتخاب کنید',
              selectedNotifier: controller.selectedRepresentation,
              items: items,
              isLoading: isLoading,
              enabled: baseEditable && items.isNotEmpty && !isLoading,
              itemTitleBuilder: representationTitleBuilder,
              onSelect: (item) {
                controller.setSelectedRepresentation(item);
                onSelectRepresentation?.call(item);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildAcceptanceCodeInput() {
    return TextFormFieldWidget(
      controller: controller.acceptanceCodeController,
      labelText: 'کد پذیرش',
      hintText: 'کد پذیرش',
      textInputType: TextInputType.number,
      textInputFormatter: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      readOnly: !baseEditable,
    );
  }

  Widget _buildTransportDistanceInput() {
    return TextFormFieldWidget(
      controller: controller.transportDistanceController,
      labelText: 'مسافت حمل (کیلومتر)',
      hintText: 'مسافت حمل',
      textInputType: TextInputType.number,
      textInputFormatter: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      readOnly: !distanceEditable,
    );
  }

  Widget _buildEndWorkDateTimeRow() {
    return DateTimePickerSection(
      dateLabel: 'تاریخ اتمام کار',
      timeLabel: 'زمان اتمام کار',
      dateController: controller.endWorkDateController,
      timeController: controller.endWorkTimeController,
      onDateChange: controller.setEndWorkDate,
      onTimeChange: controller.setEndWorkTime,
      enabled: baseEditable,
    );
  }
}
