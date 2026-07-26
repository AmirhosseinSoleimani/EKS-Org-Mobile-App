import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_action_content_widgets.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/search_input_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class AgencyAddSearchCard extends StatelessWidget {
  const AgencyAddSearchCard({
    super.key,
    required this.controller,
    required this.message,
    required this.hintText,
    required this.isLoading,
    required this.onSearch,
    this.labelText = 'جستجو',
  });

  final TextEditingController controller;
  final String message;
  final String hintText;
  final bool isLoading;
  final VoidCallback onSearch;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AgencyInfoActionCard(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: AppSize.s18,
                color: colorScheme.onSurfaceVariant,
              ),
              Space.w8,
              Expanded(
                child: BodyMediumText(
                  text: message,
                  color: colorScheme.onPrimaryFixedVariant,
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Space.h16,
          SearchInputField(
            controller: controller,
            hintText: hintText,
            hintColor: colorScheme.onSurfaceVariant,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: labelText,
            labelColor: colorScheme.onPrimaryFixed,
          ),
          Space.h24,
          InkwellButtonWidget(
            title: 'جستجو',
            showLoading: isLoading,
            onTap: onSearch,
            backgroundColor: colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
