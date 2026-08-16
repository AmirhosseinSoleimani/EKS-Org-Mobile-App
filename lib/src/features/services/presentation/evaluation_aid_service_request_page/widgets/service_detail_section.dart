import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/cubit/evaluation_aid_service_request_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/dropdown_selector.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/labeled_check_box_row.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/focus_node/always_disabled_focus_node.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';

import '../../../../evaluation/domain/entities/defect_entity.dart';

class ServiceDetailSection extends StatelessWidget {
  final EvaluationAidServiceRequestCubit cubit;
  final bool showServiceField;

  const ServiceDetailSection({
    super.key,
    required this.cubit,
    this.showServiceField = true,
  });

  @override
  Widget build(BuildContext context) {
    return FormSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleLargeText(
            text: 'جزئیات سرویس',
            fontSize: 16,
            textAlign: TextAlign.start,
          ),
          Space.h32,
          DropdownSelector<DefectEntity>(
            label: 'ایراد خودرو',
            placeholder: 'انتخاب ایراد خودرو',
            searchable: true,
            selectedNotifier: cubit.selectedDefect,
            items: cubit.defectList,
            itemTitleBuilder: (item) => item.title ?? '',
            onSelect: (item) => cubit.selectDefect(item),
          ),
          Space.h16,
          DropdownSelector<ServiceCategoryEntity>(
            label: 'نوع امداد',
            placeholder: 'انتخاب نوع امداد',
            selectedNotifier: cubit.selectedServiceCategory,
            items: cubit.serviceCategoryList,
            enabled: cubit.serviceCategoryList.isNotEmpty,
            itemTitleBuilder: (item) => item.title ?? '',
            onSelect: (item) => cubit.setSelectedServiceCategory(item),
          ),
          if (showServiceField) ...[
            Space.h16,
            TextFormFieldWidget(
              controller: cubit.mainForm.serviceController,
              labelText: 'سرویس',
              textInputType: TextInputType.none,
              focusNode: AlwaysDisabledFocusNode(),
              readOnly: true,
              borderColor: Theme.of(context).dividerColor,
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            ),
          ],
          Space.h16,
          TextFormFieldWidget(
            labelText: 'توضیحات',
            controller: cubit.mainForm.descriptionController,
            autofocus: false,
            textInputType: TextInputType.text,
            textAlign: TextAlign.start,
            textInputAction: TextInputAction.done,
            maxLines: 3,
          ),
          Space.h16,
          LabeledCheckboxRow(
            title: 'عوارض آزاد راهی پرداخت شد',
            notifier: cubit.mainForm.isFreewayTollPaid,
            activeColor: ServiceType.reliefService.serviceColor,
          ),
        ],
      ),
    );
  }
}
