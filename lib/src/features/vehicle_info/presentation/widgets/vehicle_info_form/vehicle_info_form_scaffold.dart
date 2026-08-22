import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';


class VehicleInfoFormActions extends StatelessWidget {
  const VehicleInfoFormActions({
    super.key,
    required this.submitTitle,
    required this.isSubmitting,
    required this.onCancel,
    required this.onSubmit,
    this.cancelTitle = 'انصراف',
  });

  final String submitTitle;
  final String cancelTitle;
  final bool isSubmitting;
  final VoidCallback onCancel;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      top: false,
      child: Container(
        color: Color(0xFFFBF9F9),
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                  onPressed: () {
                    if (isSubmitting) return;
                    onCancel();
                  },
                  child: Text(
                    cancelTitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryFixed,
                      fontWeight: FontWeight.w700,
                    ),
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


class VehicleInfoFormLoadError extends StatelessWidget {
  const VehicleInfoFormLoadError({
    super.key,
    required this.onRetry,
  });

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: theme.colorScheme.error,
              size: AppSize.s40,
            ),
            Space.h16,
            Text(
              'آماده سازی فرم با خطا مواجه شد.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            Space.h16,
            InkwellButtonWidget(
              title: 'تلاش مجدد',
              width: AppSize.s150,
              onTap: onRetry,
              backgroundColor: theme.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
