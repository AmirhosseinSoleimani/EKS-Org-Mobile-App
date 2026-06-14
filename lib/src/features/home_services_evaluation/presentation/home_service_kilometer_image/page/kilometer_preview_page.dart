import 'package:eks_sana_plus_org/src/config/themes/app_theme.dart';
import 'package:eks_sana_plus_org/src/core/presentation/pages/base_stateless_page.dart';
import 'package:eks_sana_plus_org/src/core/uikit/dialog/dialog_widgets.dart';
import 'package:eks_sana_plus_org/src/core/uikit/spacing.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_button/ek_button.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_kilometer_image/cubit/home_service_kilometer_image_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_kilometer_image/cubit/home_service_kilometer_image_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KilometerPreviewPage extends BaseStatelessPage {
  final KilometerCapture capture;
  const KilometerPreviewPage({super.key, required this.capture});

  @override
  String? screenName(BuildContext context) => 'پیش ‌نمایش تصویر';

  @override
  Widget body(BuildContext context) {
    return BlocConsumer<HomeServiceKilometerImageCubit, HomeServiceKilometerImageState>(
      listenWhen: (prev, curr) {
        final prevSubmitting = prev.maybeWhen(submitLoading: () => true, orElse: () => false);
        final currSubmitting = curr.maybeWhen(submitLoading: () => true, orElse: () => false);
        final hasSuccess    = curr.maybeWhen(submitSuccess: () => true, orElse: () => false);
        final hasError      = curr.maybeWhen(error: (_) => true, orElse: () => false);
        return (prevSubmitting != currSubmitting) || hasSuccess || hasError;
      },
      listener: (context, state) {
        state.whenOrNull(
          error: (dialog) {
            showDialog(
              context: context,
              builder: (_) => MessageDialogWidget(
                color: AppTheme.blue,
                dismissible: false,
                title: '',
                body: dialog.description,
              ),
            );
          },
          submitSuccess: () async{
            final cap = context.read<HomeServiceKilometerImageCubit>().kilometerPhoto;
            if (cap != null) {
              await context.read<HomeServiceKilometerImageCubit>().addImageKilometerToEvaluation(fullImage: cap.full);
            }
            Navigator.pop(context, true);
          },
        );
      },
      builder: (context, state) {
        final submitting = state.maybeWhen(submitLoading: () => true, orElse: () => false);
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Text('مشاهده تصویر:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
                  Space.h16,
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(capture.full, fit: BoxFit.cover),
                    ),
                  ),
                  Space.h12,
                  Row(
                    children: [
                      Expanded(
                        child: EkButton(
                          backgroundColor: AppTheme.whiteColor,
                          borderSide: const BorderSide(
                            color: AppTheme.blue,
                            width: 1,
                          ),
                          title: 'تلاش مجدد',
                          titleColor: AppTheme.blue,
                          onTap: () => Navigator.pop(context, null),
                        ),
                      ),
                      Space.w12,
                      Expanded(
                        child: EkButton(
                          showLoading: submitting,
                          title: 'بررسی کیلومتر',
                          backgroundColor: AppTheme.blue,
                          onTap: () {
                            context.read<HomeServiceKilometerImageCubit>()
                              ..setKilometerCapture(capture)
                              ..submitToBackend(capture: capture, useCrop: true);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}