import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/enums/payment_type.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/cubit/request_detail_cubit.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/cubit/request_detail_state.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/widgets/cash_payment_warning_sheet_content.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Future<BottomSheetAction?> showPaymentMethodSheet(
  BuildContext context,
  Color buttonColor,
) {
  final cubit = context.read<RequestDetailCubit>();

  return BottomSheetMessage.showCustom(
    context: context,
    content: BlocProvider.value(
      value: cubit,
      child: PaymentMethodSheetContent(buttonColor: buttonColor),
    ),
    actionWidget: const SizedBox.shrink(),
  );
}

class PaymentMethodSheetContent extends StatelessWidget {
  final Color buttonColor;

  const PaymentMethodSheetContent({
    super.key,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RequestDetailCubit>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ValueListenableBuilder<PaymentType>(
      valueListenable: cubit.selectedPaymentTypeVN,
      builder: (_, selected, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(
              child: TitleMediumText(
                text: "روش های پرداخت",
                fontSize: AppSize.s14,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: TitleMediumText(
                text: "روش پرداخت خود را انتخاب کنید",
                fontSize: AppSize.s14,
                color: colorScheme.outline,
              ),
            ),
            const SizedBox(height: 24),
            _buildPaymentItem(
              context,
              title: "نقدی",
              icon: Icons.payments_outlined,
              type: PaymentType.cash,
              selected: selected,
            ),
            Divider(color: colorScheme.outline.withOpacity(0.3), height: 1),
            _buildPaymentItem(
              context,
              title: "آنلاین",
              icon: Icons.credit_card_rounded,
              type: PaymentType.online,
              selected: selected,
            ),
            const SizedBox(height: 24),
            paymentActionButton(buttonColor),
          ],
        );
      },
    );
  }

  BlocBuilder<RequestDetailCubit, RequestDetailState> paymentActionButton(
      Color buttonColor) {
    return BlocBuilder<RequestDetailCubit, RequestDetailState>(
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          updatePaymentLoading: () => true,
          orElse: () => false,
        );
        return InkwellButtonWidget(
          showLoading: isLoading,
          title: "پرداخت",
          backgroundColor: buttonColor,
          onTap: () {
            final selectedPayment =
                context.read<RequestDetailCubit>().selectedPaymentTypeVN;
            if (selectedPayment.value == PaymentType.cash) {
              context.pop();
              showCashWarningSheet(context, buttonColor);
            } else {
              context.read<RequestDetailCubit>().onUpdatePaymentType();
            }
          },
        );
      },
    );
  }

  Widget _buildPaymentItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required PaymentType type,
    required PaymentType selected,
  }) {
    final cubit = context.read<RequestDetailCubit>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: () => cubit.changePaymentMethod(type),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Icon(
              icon,
              color: colorScheme.outline,
            ),
            const SizedBox(width: 12),
            BodyMediumText(text: title),
            const Spacer(),
            _buildRadioCircle(selected == type, colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioCircle(bool selected, ColorScheme scheme) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? Colors.black : scheme.outline,
          width: 2,
        ),
      ),
      child: selected
          ? Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              ),
            )
          : null,
    );
  }
}
