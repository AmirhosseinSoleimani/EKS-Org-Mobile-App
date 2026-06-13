import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/cubit/evaluation_transport_Information_form_controller.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/dropdown_selector.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransportInformationSection<T extends DropdownItem>
    extends StatelessWidget {
  final EvaluationTransportInformationFormController<T> controller;
  final String Function(T item) representationTitleBuilder;
  final ValueChanged<T>? onSelectRepresentation;
  final VoidCallback onEndWorkDateTap;
  final VoidCallback onEndWorkTimeTap;

  const TransportInformationSection({
    super.key,
    required this.controller,
    required this.representationTitleBuilder,
    required this.onEndWorkDateTap,
    required this.onEndWorkTimeTap,
    this.onSelectRepresentation,
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
              enabled: items.isNotEmpty && !isLoading,
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
    );
  }

  Widget _buildEndWorkDateTimeRow() {
    return Row(
      children: [
        Expanded(
          child: TextFormFieldWidget(
            controller: controller.endWorkDateController,
            labelText: 'تاریخ اتمام کار',
            hintText: 'انتخاب تاریخ',
            readOnly: true,
            textInputType: TextInputType.none,
            onTap: onEndWorkDateTap,
            suffixIcon: const Icon(Icons.calendar_month_outlined),
          ),
        ),
        Space.w12,
        Expanded(
          child: TextFormFieldWidget(
            controller: controller.endWorkTimeController,
            labelText: 'زمان اتمام کار',
            hintText: 'انتخاب زمان',
            readOnly: true,
            textInputType: TextInputType.none,
            onTap: onEndWorkTimeTap,
            suffixIcon: const Icon(Icons.access_time),
          ),
        ),
      ],
    );
  }
}
