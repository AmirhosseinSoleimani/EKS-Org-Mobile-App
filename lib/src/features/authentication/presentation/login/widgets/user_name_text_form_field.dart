import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserNameTextFormFieldWidget extends StatelessWidget {
//todo: write correct validation for username
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;

  const UserNameTextFormFieldWidget({
    super.key,
    required this.formKey,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      labelText: "نام کاربری",
      controller: controller,
      autofocus: false,
      textInputType: TextInputType.name,
      textAlign: TextAlign.start,
      textInputAction: TextInputAction.done,
     
    );
  }
}
