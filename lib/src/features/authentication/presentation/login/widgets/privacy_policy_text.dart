import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrivacyPolicyTextWidget extends StatelessWidget {
  const PrivacyPolicyTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<LoginCubit>();
    return InkWell(
      splashColor: Colors.transparent,
      onTap:cubit.privacyPolicyUrl,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'ورود شما به معنای پذیرش',
                style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.surfaceTint),
              ),
              TextSpan(
                text: ' قوانین و مقررات امدادخودرو ',
                style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary),
                recognizer: TapGestureRecognizer()
                  ..onTap = cubit.privacyPolicyUrl,
              ),
              TextSpan(
                text: 'است.',
                style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.surfaceTint),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
