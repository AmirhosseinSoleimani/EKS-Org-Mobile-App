import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/login_page.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/profile/cubit/profile_cubit.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/profile/cubit/profile_state.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/profile/widgets/change_password_sheet.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/profile/widgets/profile_action_tile.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/profile/widgets/profile_avatar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/delete_confirm_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  static const path = '/profile';
  static const name = 'profile';

  const ProfilePage({super.key});

  static const _passwordChangedMessage =
      'تغییر رمز عبور با موفقیت انجام شد';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (_) => getIt<ProfileCubit>(),
      child: BlocListener<ProfileCubit, ProfileState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: _handleState,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          appBar: const SimpleAppBar(title: 'پروفایل'),
          body: const _ProfileBody(),
        ),
      ),
    );
  }

  void _handleState(BuildContext context, ProfileState state) {
    final isPasswordChanged =
        state.status == ProfileStatus.changePasswordSuccess;
    final isLoggedOut = state.status == ProfileStatus.logoutSuccess;

    if (!isPasswordChanged && !isLoggedOut) return;

    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;

      context.goNamed(
        LoginPage.name,
        extra: isPasswordChanged ? _passwordChangedMessage : null,
      );
    });
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppPadding.p16,
        AppPadding.p32,
        AppPadding.p16,
        AppPadding.p24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Align(
            alignment: Alignment.center,
            child: ProfileAvatarWidget(),
          ),
          Space.h16,
          TitleLargeText(
            text: cubit.displayName,
            fontSize: AppSize.s20,
            textAlign: TextAlign.center,
          ),
          Space.h8,
          Align(
            alignment: Alignment.center,
            child: StatusLabel(
              text: cubit.roleName,
              color: colorScheme.outlineVariant,
              backgroundColor: colorScheme.surfaceContainer,
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p12,
                vertical: AppPadding.p6,
              ),
              fontWeight: FontWeight.w600,
            ),
          ),
          Space.h32,
          ProfileActionTile(
            title: 'تغییر رمز عبور',
            icon: Icons.lock_outline_rounded,
            onTap: () => _showChangePassword(context, cubit),
          ),
          Space.h48,
          InkwellButtonWidget(
            title: 'خروج از حساب',
            height: AppSize.s54,
            backgroundColor: colorScheme.inversePrimary,
            splashColor: const Color(0xFFFACBCB),
            titleColor: colorScheme.error,
            borderRadius: AppSize.s12,
            prefixIcon: Icon(
              Icons.logout_rounded,
              color: colorScheme.error,
              size: AppSize.s24,
            ),
            onTap: () => _showLogoutConfirmation(context, cubit),
          ),
        ],
      ),
    );
  }

  Future<void> _showChangePassword(
    BuildContext context,
    ProfileCubit cubit,
  ) async {
    cubit.resetPasswordForm();

    await BottomSheetMessage.showFullScreenCustom<void>(
      context: context,
      content: BlocProvider.value(
        value: cubit,
        child: const ChangePasswordSheet(),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }

  Future<void> _showLogoutConfirmation(
    BuildContext context,
    ProfileCubit cubit,
  ) async {
    final theme = Theme.of(context);

    await DeleteConfirmSheet.show(
      context: context,
      title: 'خروج از حساب کاربری',
      message:
          'با خروج از حساب کاربری، به اطلاعات خود دسترسی نخواهید داشت، هر وقت بخواهید می‌توانید دوباره وارد شوید',
      confirmTitle: 'خروج',
      icon: Icons.info_outline_rounded,
      iconColor: theme.colorScheme.error,
      iconBackgroundColor: theme.colorScheme.error.withOpacity(0.16),
      isDismissible: true,
      enableDrag: true,
      onConfirm: cubit.logout,
    );
  }
}
