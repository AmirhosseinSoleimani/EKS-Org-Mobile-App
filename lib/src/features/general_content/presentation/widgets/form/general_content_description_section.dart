import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/form/general_content_section_header.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class GeneralContentDescriptionSection extends StatelessWidget {
  const GeneralContentDescriptionSection({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return FormSectionContainer(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const GeneralContentSectionHeader(
            title: 'توضیحات',
            icon: Icons.description_rounded,
          ),
          Space.h20,
          TextFormFieldWidget(
            controller: controller,
            labelText: 'توضیحات تکمیلی',
            maxLines: 6,
            textInputAction: TextInputAction.newline,
          ),
        ],
      ),
    );
  }
}
