import 'dart:io' show Platform;

import 'package:app_settings/app_settings.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class NoInternetBottomSheet extends StatelessWidget {
  const NoInternetBottomSheet({
    super.key,
    required this.onRetry,
  });

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildImage(screenSize),
          const SizedBox(height: AppSize.s24),
          _buildSubtitle(context),
          const SizedBox(height: AppSize.s24),
          _buildActionButtons(context, screenSize.width),
        ],
      ),
    );
  }

  Widget _buildImage(Size size) {
    return Image.asset(
      ImageManager.noInternetIcon,

      height: AppSize.s100,
      width: AppSize.s120,
      fit: BoxFit.fitWidth,
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    final theme = Theme.of(context).textTheme.bodyMedium;

    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        style: theme,
        children: [
          const TextSpan(
            text:
                'اتصال به اینترنت را بررسی و دوباره تلاش کنید.\nدر صورت دسترسی نداشتن به اینترنت، ',
          ),
          TextSpan(
            text: 'برای درخواست تلفنی امداد با 096550',
            style: theme?.copyWith(fontWeight: FontWeight.bold),
          ),
          const TextSpan(text: ' تماس بگیرید.'),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, double width) {
    final theme = Theme.of(context);
    const buttonHeight = 40.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildButton(
          width: (width * 0.42),
          height: buttonHeight,
          title: 'تلاش دوباره',
          backgroundColor: theme.primaryColor,
          onTap: (){
            Navigator.of(context).pop();
          onRetry();
          }
        ),
        const SizedBox(height: AppSize.s12),
        _buildButton(
          width: (width * 0.42),
          height: buttonHeight,
          title: 'فعال‌سازی اینترنت',
          backgroundColor: theme.colorScheme.surface,
          borderColor: theme.primaryColor,
          titleColor: theme.primaryColor,
          onTap: () {
            openInternetSettings();
          },
        ),
      ],
    );
  }

  Future<void> openInternetSettings() async {
    try {
      if (Platform.isAndroid) {
        await AppSettings.openAppSettingsPanel(
          AppSettingsPanelType.internetConnectivity,
        );
        return;
      }

      await AppSettings.openAppSettings(type: AppSettingsType.wifi);
    } catch (_) {
      await AppSettings.openAppSettings(type: AppSettingsType.wifi);
    }
  }

  Widget _buildButton({
    required double width,
    required double height,
    required String title,
    required Color backgroundColor,
    Color? borderColor,
    Color? titleColor,
    required VoidCallback onTap,
  }) {
    return InkwellButtonWidget(
      width: width,
      height: height,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      titleColor: titleColor,
      title: title,
      onTap: onTap,
    );
  }
}
