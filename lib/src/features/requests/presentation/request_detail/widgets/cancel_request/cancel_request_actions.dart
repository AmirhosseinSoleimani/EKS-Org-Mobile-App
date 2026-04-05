import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/cubit/request_detail_cubit.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/cubit/request_detail_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CancelRequestActions extends StatelessWidget {
  const CancelRequestActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonsWidth = screenWidth * 0.44;
    return Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.p36,
        bottom: AppPadding.p8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<RequestDetailCubit, RequestDetailState>(
            builder: (context, state) {

              final isLoading = state.maybeWhen(
                cancelRequestLoading: () => true,
                orElse: () => false,
              );
              return InkwellButtonWidget(
                showLoading: isLoading,
                width: buttonsWidth,
                height: AppSize.s40,
                loadingColor: colorScheme.error,
                splashColor: colorScheme.error.withAlpha(30),
                borderColor: colorScheme.error,
                backgroundColor: Colors.transparent,
                title: 'لغو درخواست',
                textStyle: textTheme.titleLarge?.copyWith(
                  color: colorScheme.error,
                  fontSize: AppSize.s14,
                ),
                onTap: context.read<RequestDetailCubit>().cancelRequest,
              );
            },
          ),
          InkwellButtonWidget(
            width: buttonsWidth,
            height: AppSize.s40,
            splashColor: colorScheme.secondary.withAlpha(30),
            borderColor: colorScheme.secondary,
            title: 'بازگشت',
            textStyle: textTheme.titleMedium?.copyWith(
              color: colorScheme.onPrimary,
              fontSize: AppSize.s14,
            ),
            backgroundColor: colorScheme.secondary,
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
