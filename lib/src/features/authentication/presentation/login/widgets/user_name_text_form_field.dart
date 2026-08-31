import 'package:eks_sana_plus_org/src/features/authentication/domain/validators/login_credentials_validator.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserNameTextFormFieldWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;

  const UserNameTextFormFieldWidget({
    super.key,
    required this.formKey,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return TextFormFieldWidget(
      labelText: 'نام کاربری',
      mandatory: true,
      controller: controller,
      autofocus: false,
      showMandatoryIndicator: false,
      textInputType: TextInputType.name,
      textAlign: TextAlign.start,
      textInputAction: TextInputAction.next,
      maxLength: LoginCredentialsValidator.userNameMaxLength,
      validator: cubit.validateUserName,
    );
  }
}
