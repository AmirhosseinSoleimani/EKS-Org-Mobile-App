
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/image_widget/image_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class FriendlyErrorScreen extends StatelessWidget {
  const FriendlyErrorScreen({
    super.key,
    required this.title,
    required this.message,
    this.techMessage,
    this.onBack,
    this.onRetry,
    required this.showHomeButton,
  });

  final String title;
  final String message;
  final String? techMessage;
  final VoidCallback? onBack;
  final VoidCallback? onRetry;
  final bool showHomeButton;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageWidget.asset(
                      ImageManager.error,
                      width: AppSize.s100,
                      height: AppSize.s100,
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    ),
                    Space.h16,
                    Text(title, style: Theme.of(context).textTheme.titleLarge),
                    Space.h12,
                    Text(
                      'درخواست شما با خطا غیرمنتظره مواجعه شد، لطفا یکبار از برنامه خارج و سپس دوباره وارد شوید',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              if(showHomeButton) ...[
               /* InkwellButtonWidget(
                  onTap: () => context.go(HomePage.path),
                  title: 'بازگشت به صفحه اصلی',
                ),*/
                Space.h8,
              ],
              InkwellButtonWidget(
                onTap: () {},
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                borderColor: Theme.of(context).colorScheme.primary,
                titleColor: Theme.of(context).colorScheme.primary,
                title: 'درخواست تلفنی امداد',
              ),
            ],
          ),
        ),
      ),
    );
  }
}