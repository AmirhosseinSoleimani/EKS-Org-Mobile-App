import 'package:eks_sana_plus_org/src/features/authentication/domain/validators/login_credentials_validator.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordTextFormFieldWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;

  const PasswordTextFormFieldWidget({
    super.key,
    required this.formKey,
    required this.controller,
  });

  @override
  State<PasswordTextFormFieldWidget> createState() =>
      _PasswordTextFormFieldWidgetState();
}

class _PasswordTextFormFieldWidgetState
    extends State<PasswordTextFormFieldWidget> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cubit = context.read<LoginCubit>();

    return TextFormFieldWidget(
      labelText: 'رمز عبور',
      mandatory: true,
      controller: widget.controller,
      autofocus: false,
      textInputType: TextInputType.text,
      textAlign: TextAlign.start,
      textInputAction: TextInputAction.next,
      obscureText: _obscure,
      maxLines: 1,
      maxLength: LoginCredentialsValidator.passwordMaxLength,
      validator: cubit.validatePassword,
      suffixIcon: IconButton(
        icon: Icon(
          _obscure ? Icons.visibility_off : Icons.visibility,
          color: colorScheme.onPrimaryFixed,
          size: AppSize.s22,
        ),
        onPressed: () {
          setState(() {
            _obscure = !_obscure;
          });
        },
      ),
    );
  }
}
