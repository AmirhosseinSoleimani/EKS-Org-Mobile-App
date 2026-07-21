import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class VehicleInfoFormHeader extends StatelessWidget {
  const VehicleInfoFormHeader({
    super.key,
    required this.title,
    required this.onClose,
  });

  final String title;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: kToolbarHeight,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            IconButton(
              onPressed: onClose,
              icon: Icon(
                Icons.close_rounded,
                color: theme.colorScheme.onPrimaryFixedVariant,
              ),
            ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.right,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Space.w16,
          ],
        ),
      ),
    );
  }
}

class VehicleInfoFormActions extends StatelessWidget {
  const VehicleInfoFormActions({
    super.key,
    required this.submitTitle,
    required this.isSubmitting,
    required this.onCancel,
    required this.onSubmit,
  });

  final String submitTitle;
  final bool isSubmitting;
  final VoidCallback onCancel;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      top: false,
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
              flex: 3,
              child: TextButton(
                onPressed: isSubmitting ? null : onCancel,
                child: Text(
                  'انصراف',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimaryFixed,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Space.w12,
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
          ],
        ),
      ),
    );
  }
}

class VehicleInfoFormLoading extends StatelessWidget {
  const VehicleInfoFormLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            color: theme.colorScheme.primary,
          ),
          Space.h16,
          Text(
            'در حال آماده سازی فرم...',
            style: theme.textTheme.bodyMedium,
          ),
        ],
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
