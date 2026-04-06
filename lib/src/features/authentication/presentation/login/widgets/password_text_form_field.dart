import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final cubit = context.read<LoginCubit>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return TextFormFieldWidget(
      labelText: "رمز عبور",
      controller: widget.controller,
      autofocus: false,
      textAlign: TextAlign.start,
      textInputAction: TextInputAction.done,
      obscureText: _obscure,
      maxLines: 1,
      suffixIcon: IconButton(
        icon: Icon(
          _obscure ? Icons.visibility_off : Icons.visibility,
          color: colorScheme.inverseSurface,
          size: AppSize.s24,
        ),
        onPressed: () {
          setState(() {
            _obscure = !_obscure;
          });
        },
      ),
      validator: (value) => cubit.phoneNumberValidate(value),
      textInputFormatter: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(11),
      ],
    );
  }
}
