import 'package:eks_sana_plus_org/src/features/rescuer/presentation/add_rescuer_page.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';

class AddRescuerSuccessView extends StatelessWidget {
  const AddRescuerSuccessView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(child: _SuccessContent()),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  InkwellButtonWidget(
                    titleColor: colorScheme.onPrimary,
                    borderWidth: 2,
                    borderColor: colorScheme.primary,
                    loadingColor: colorScheme.primary,
                    backgroundColor: colorScheme.primary,
                    title: 'بازگشت به لیست',
                    prefixIcon:  Icon(Icons.list,color:colorScheme.onPrimary),
                    onTap:  () => Navigator.of(context).pop(
                      AddRescuerResult(rescuerId: id),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkwellButtonWidget(
                    titleColor: colorScheme.primary,
                    borderWidth: 2,
                    borderColor: colorScheme.primary,
                    loadingColor: colorScheme.primary,
                    backgroundColor: colorScheme.onPrimary,
                    title: 'مشاهده پروفایل',
                    prefixIcon: Icon(Icons.account_circle_outlined, color: colorScheme.primary,),
                    onTap: () =>
                        Navigator.of(context).pop(
                          AddRescuerResult(
                            rescuerId: id,
                            viewProfile: true,
                          ),
                        ),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessContent extends StatelessWidget {
  const _SuccessContent();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE3F1E5),
                border: Border.all(
                  color: const Color(0xFFD1E7D5),
                  width: 4,
                ),
              ),
              child: const Icon(
                Icons.check_circle,
                color: Color(0xFF18752A),
                size: 70,
              ),
            ),
            const SizedBox(height: 28),
            const TitleLargeText(
              text: 'افزودن با موفقیت انجام شد',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const BodyMediumText(
              text: 'اطلاعات امدادرسان جدید در سیستم ثبت گردید.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
