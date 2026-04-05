import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/cubit/request_detail_cubit.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/cubit/request_detail_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeTimeAction extends StatelessWidget {
  const ChangeTimeAction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.p24,
        bottom: AppPadding.p8,
      ),
      child:  BlocBuilder<RequestDetailCubit, RequestDetailState>(
        builder: (context, state) {

          final isLoading = state.maybeWhen(
            changeTimeRequestLoading: () => true,
            orElse: () => false,
          );
          return InkwellButtonWidget(
            showLoading: isLoading,
            width: double.infinity,
            height: AppSize.s40,
            loadingColor: colorScheme.onPrimary,
            splashColor: colorScheme.onPrimary.withAlpha(30),
            borderColor: colorScheme.onSecondaryContainer,
            backgroundColor: colorScheme.onSecondaryContainer,
            title: 'تغییر زمان‌بندی',
            textStyle: textTheme.titleLarge?.copyWith(
              color: colorScheme.onPrimary,
              fontSize: AppSize.s14,
            ),
            onTap: context.read<RequestDetailCubit>().changeRequestTime,
          );
        },
      ),
    );
  }
}
