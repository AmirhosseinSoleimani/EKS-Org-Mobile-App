import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';

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
    return TextFormFieldWidget(
      labelText: "رمز عبور",
      controller: widget.controller,
      autofocus: false,
      textInputType: TextInputType.text,
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
    );
  }
}
