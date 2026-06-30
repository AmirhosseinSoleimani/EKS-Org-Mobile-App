import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/cubit/login_state.dart';

import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          builder: (_, isValid, _) {
            final canSubmit = !isLoading && isValid;
            return InkwellButtonWidget(
              onTap:()=> cubit.login() /*canSubmit ? () {
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