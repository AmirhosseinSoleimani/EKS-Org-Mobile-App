import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class AddAgencyBottomActions extends StatelessWidget {
  const AddAgencyBottomActions({
    super.key,
    required this.isSubmitting,
    required this.onCancel,
    required this.onSubmit,
    this.submitTitle = 'افزودن',
    this.cancelTitle = 'انصراف',
  });

  final bool isSubmitting;
  final VoidCallback onCancel;
  final VoidCallback onSubmit;
  final String submitTitle;
  final String cancelTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      top: false,
      child: ColoredBox(
        color: theme.colorScheme.onPrimary,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppPadding.p16,
            AppPadding.p8,
            AppPadding.p16,
            AppPadding.p12,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: InkwellButtonWidget(
                  title: submitTitle,
                  showLoading: isSubmitting,
                  onTap: onSubmit,
                  backgroundColor: theme.colorScheme.primary,
                  borderRadius: AppSize.s8,
                ),
              ),
              Space.w12,
              Expanded(
                flex: 3,
                child: TextButton(
                  onPressed: isSubmitting ? null : onCancel,
                  child: BodyMediumText(
                    text: cancelTitle,
                    color: theme.colorScheme.onPrimaryFixed,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
