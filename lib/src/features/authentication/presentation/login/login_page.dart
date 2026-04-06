import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/widgets/password_text_form_field.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/widgets/user_name_text_form_field.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/logo_widget/logo_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/submit_button.dart';

class LoginPage extends StatelessWidget {
  static const path = '/login';
  static const name = 'login';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (_) => getIt<LoginCubit>(),
      child: const SafeArea(
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: _LoginBody(),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginBody extends StatelessWidget {
  const _LoginBody();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 32),
          child: LogoWidget(),
        ),
        Expanded(
          child: Center(
            child: _LoginFormCard(),
          ),
        ),
      ],
    );
  }
}

class _LoginFormCard extends StatefulWidget {
  const _LoginFormCard();

  @override
  State<_LoginFormCard> createState() => _LoginFormCardState();
}

class _LoginFormCardState extends State<_LoginFormCard> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<LoginCubit>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TitleLargeText(
              text: "ورود",
              textAlign: TextAlign.center,
            ),
            Space.h8,
            const BodyMediumText(
              text: "خوش آمدید!",
              fontSize: AppSize.s14,
              color: Colors.grey,
              textAlign: TextAlign.center,
            ),
            Space.h24,
            UserNameTextFormFieldWidget(
              formKey: _formKey,
              controller: cubit.userNameController,
            ),
            Space.h16,
            PasswordTextFormFieldWidget(
              formKey: _formKey,
              controller: cubit.passwordController,
            ),
            Space.h80,
            SubmitButtonWidget(formKey: _formKey),
            Space.h20,
          ],
        ),
      ),
    );
  }
}
