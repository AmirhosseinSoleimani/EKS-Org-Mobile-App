import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/cubit/login_state.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/presentation/dashboard_page.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SubmitButtonWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const SubmitButtonWidget({super.key, required this.formKey,});
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return BlocSelector<LoginCubit, LoginState, bool>(
      selector: (state) => state.maybeWhen(loading: () => true, orElse: () => false),
      builder: (context, isLoading) {
        return ValueListenableBuilder<bool>(
          valueListenable: cubit.validationNotifier,
          builder: (_, isValid, __) {
            final canSubmit = !isLoading && isValid;
            return InkwellButtonWidget(
              onTap:()=>  context.go(DashboardPage.path) /*canSubmit ? () {
                if (formKey.currentState?.validate() ?? false) {
                  cubit.login();
                }
              } : () {}*/,
              backgroundColor:  Theme.of(context).colorScheme.primary,
              showLoading: isLoading,
              title: 'ورود',
            );
          },
        );
      },
    );
  }
}