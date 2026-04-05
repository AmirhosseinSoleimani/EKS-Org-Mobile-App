import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/cubit/request_detail_cubit.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/cubit/request_detail_state.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/widgets/payment_method_sheet_content.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/image_widget/image_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showCashWarningSheet(BuildContext context, Color buttonColor) {
  final cubit = context.read<RequestDetailCubit>();

  BottomSheetMessage.showCustom(
    context: context,
    isDismissible: false,
    enableDrag: false,
    content: BlocProvider.value(
      value: cubit,
      child: CashPaymentWarningSheetContent(
        onCancelButton: () {
          showPaymentMethodSheet(context, buttonColor);
        },
      ),
    ),
    actionWidget: const SizedBox.shrink(),
  );
}



class CashPaymentWarningSheetContent extends StatelessWidget {
  final VoidCallback onCancelButton;

  const CashPaymentWarningSheetContent(
      {super.key, required this.onCancelButton});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "پرداخت نقدی",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Space.h16,
        ImageWidget.asset(
          ImageManager.cashPaymentWarningImage,
          width: 140,
        ),
        Space.h24,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.error_outline, color: colorScheme.outline),
            Space.w8,
            Expanded(
              child: BodyMediumText(text:
                "اگر پرداخت نقدی را فعال کنید، امکان انتخاب روش‌ های دیگر پرداختی را نخواهید داشت.",
                  color: colorScheme.onPrimaryFixed,
                fontSize: AppSize.s14,
              ),
            ),

          ],
        ),
        Space.h16,
        Space.h16,
        _cashWarningActions(context),
      ],
    );
  }

  Widget _cashWarningActions(BuildContext context) {
    final cubit = context.read<RequestDetailCubit>();
    final colorScheme = Theme.of(context).colorScheme;
    final buttonColor = colorScheme.primary;

    return Row(
      children: [
        Expanded(
          child: InkwellButtonWidget(
            title: "انصراف",
            height: AppSize.s38,
            backgroundColor: colorScheme.onPrimary,
            titleColor: colorScheme.onSecondaryFixed,
            borderColor: colorScheme.outline,
            textStyle: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontSize: AppSize.s14),
            onTap: () async {
              Navigator.pop(context);
              await Future.delayed(const Duration(milliseconds: 150));
              if (!context.mounted) return;
              onCancelButton();
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: BlocBuilder<RequestDetailCubit, RequestDetailState>(
            builder: (context, state) {
              final isLoading = state.maybeWhen(
                updatePaymentLoading: () => true,
                orElse: () => false,
              );
              return InkwellButtonWidget(
                title: "پرداخت نقدی",
                showLoading: isLoading,
                height: AppSize.s38,
                textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: AppSize.s14, color: colorScheme.onPrimary),
                backgroundColor: buttonColor,
                onTap: () {
                  cubit.onUpdatePaymentType();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
