import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/cubit/login_state.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/widgets/animated_logo_wrapper.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/widgets/app_version_text.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/widgets/phone_number_text_form_field.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/widgets/privacy_policy_text.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/widgets/submit_button.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  static const path = '/login-page';
  static const name = 'login-name';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (_) => getIt<LoginCubit>(),
      child: const SafeArea(
        child: _LoginScaffold(),
      ),
    );
  }
}

class _LoginScaffold extends StatelessWidget {
  const _LoginScaffold();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ScrollConfiguration(
        behavior: const _NoGlowScrollBehavior(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: BlocListener<LoginCubit, LoginState>(
            listenWhen: (prev, curr) => prev != curr,
            listener: (context, state) {
              state.whenOrNull(
                success: () {
                  final phone = context.read<LoginCubit>().phoneNumberController.text;
                 // context.push(OtpPage.path, extra: phone);
                },
                error: (errorMessage) {
                  SnakeBarWidget.showError(context: context, message: errorMessage);
                },
                connectionError: () {
                  final cubit = context.read<LoginCubit>();
                  BottomSheetMessage.showCustom(
                      context: context,
                      content: NoInternetBottomSheet(
                          onRetry: cubit.sendOTPCode),
                      actionWidget: const SizedBox.shrink(), isDismissible: false,enableDrag: false);
                },
              );
            },
            child: const _LoginBody(),
          ),
        ),
      ),
    );
  }
}

class _LoginBody extends StatelessWidget {
  static const double _kGapAfterLogo = AppPadding.p24;
  const _LoginBody();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              AppPadding.p16,
              AppPadding.p16,
              AppPadding.p16,
              0,
            ),
            child: AnimatedLogoWrapper(),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: _kGapAfterLogo),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: AppSize.s480),
                      child: const _LoginAnimatedContent(),
                    ),
                  ),
                ),
                if (!context.read<LoginCubit>().isWeb) ...[
                  const SafeArea(
                    top: false,
                    minimum: EdgeInsets.only(bottom: AppPadding.p12),
                    child: AppVersionTextWidget(),
                  ),
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LoginAnimatedContent extends StatelessWidget {
  const _LoginAnimatedContent();

  static const _switchDuration = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginCubit, LoginState, bool>(
      selector: (state) =>
          state.maybeWhen(idle: () => false, orElse: () => true),
      builder: (context, isLogoFinished) {
        return AnimatedSwitcher(
          duration: _switchDuration,
          child: isLogoFinished
              ? const _LoginFormContent(key: ValueKey('form'))
              : const SizedBox.shrink(key: ValueKey('placeholder')),
        );
      },
    );
  }
}

class _LoginFormContent extends StatefulWidget {
  const _LoginFormContent({super.key});

  @override
  State<_LoginFormContent> createState() => _LoginFormContentState();
}

class _LoginFormContentState extends State<_LoginFormContent> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<LoginCubit>();

    return Form(
      key: _formKey,
      child: AutofillGroup(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TitleLargeText(text: 'ورود').animate().fadeIn(duration: 400.ms),
            Space.h24,
            BodySmallText(
              text: 'به امداد خودرو خوش آمدید',
              color: theme.colorScheme.onTertiary,
            ).animate().fadeIn(delay: 100.ms),
            Space.h2,
            BodySmallText(
              text: 'لطفا برای ورود شماره موبایل خود را وارد کنید',
              color: theme.colorScheme.onTertiary,
            ).animate().fadeIn(delay: 200.ms),
            Space.h32,
            PhoneNumberTextFormFieldWidget(
              formKey: _formKey,
              controller: cubit.phoneNumberController,
            ).animate().fadeIn(delay: 300.ms),
            Space.h12,
            const PrivacyPolicyTextWidget().animate().fadeIn(delay: 400.ms),
            Space.h20,
            SubmitButtonWidget(formKey: _formKey).animate().fadeIn(delay: 500.ms),
            Space.h48,
          ],
        ),
      ),
    );
  }
}

class _NoGlowScrollBehavior extends ScrollBehavior {
  const _NoGlowScrollBehavior();

  @override
  Widget buildOverscrollIndicator(BuildContext context,
      Widget child,
      ScrollableDetails details,) {
    return child;
  }
}