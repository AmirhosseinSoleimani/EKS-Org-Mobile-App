import 'package:eks_sana_plus_org/src/features/authentication/presentation/profile/cubit/profile_cubit.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/profile/cubit/profile_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/full_screen_bottom_sheet_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/sticky_form_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordSheet extends StatefulWidget {
  const ChangePasswordSheet({super.key});

  @override
  State<ChangePasswordSheet> createState() => _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends State<ChangePasswordSheet> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    final theme = Theme.of(context);

    return BlocListener<ProfileCubit, ProfileState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == ProfileStatus.changePasswordFailure ||
            state.status == ProfileStatus.connectionError) {
          SnakeBarWidget.showError(
            context: context,
            message: state.errorMessage ?? 'خطایی رخ داده است.',
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: theme.colorScheme.surface,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: FullScreenBottomSheetAppBar(
              title: 'تغییر رمز عبور',
              onClose: () => Navigator.of(context).pop(),
            ),
          ),
          body: Column(
            children: [
              Divider(height: AppSize.s1, color: theme.dividerColor),
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.fromLTRB(
                    AppPadding.p16,
                    AppPadding.p24,
                    AppPadding.p16,
                    AppPadding.p24,
                  ),
                  child: FormSectionContainer(
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p16,
                      vertical: AppPadding.p16,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormFieldWidget(
                            controller: cubit.oldPasswordController,
                            labelText: 'رمز عبور قبلی',
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            validator: cubit.validateRequiredPassword,
                          ),
                          Space.h16,
                          TextFormFieldWidget(
                            controller: cubit.newPasswordController,
                            labelText: 'رمز عبور جدید',
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            validator: cubit.validateRequiredPassword,
                          ),
                          Space.h16,
                          TextFormFieldWidget(
                            controller: cubit.confirmPasswordController,
                            labelText: 'تکرار رمز عبور جدید',
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            validator: cubit.validatePasswordConfirmation,
                            onFieldSubmitted: (_) => _submit(cubit),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BlocBuilder<ProfileCubit, ProfileState>(
            buildWhen: (previous, current) =>
                previous.isChangingPassword != current.isChangingPassword,
            builder: (context, state) {
              return StickyFormActionBar(
                submitTitle: 'ذخیره تغییرات',
                cancelTitle: 'انصراف',
                isSubmitting: state.isChangingPassword,
                onSubmit: () => _submit(cubit),
                onCancel: () => Navigator.of(context).pop(),
              );
            },
          ),
        ),
      ),
    );
  }

  void _submit(ProfileCubit cubit) {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    cubit.changePassword();
  }
}
