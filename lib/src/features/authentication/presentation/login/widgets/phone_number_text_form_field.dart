import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneNumberTextFormFieldWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;


  const PhoneNumberTextFormFieldWidget({
    super.key,
    required this.formKey,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return TextFormFieldWidget(
      hintText: '*********09',
      controller: controller,
      autofocus: false,
      textInputType: TextInputType.phone,
      textAlign: TextAlign.center,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) {
        final cubit = context.read<LoginCubit>();
        if (formKey.currentState?.validate() ?? false) cubit.sendOTPCode();
      },
      validator: (value) => cubit.phoneNumberValidate(value),
      textInputFormatter: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(11),
      ],
    );
  }
}
