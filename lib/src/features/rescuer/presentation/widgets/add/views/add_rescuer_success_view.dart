import 'package:eks_sana_plus_org/src/features/rescuer/presentation/add_rescuer_page.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';

class AddRescuerSuccessView extends StatelessWidget {
  const AddRescuerSuccessView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
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
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.of(context).pop(
                        AddRescuerResult(rescuerId: id),
                      ),
                      icon: const Icon(Icons.list),
                      label: const BodyMediumText(
                        text: 'بازگشت به لیست',
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.of(context).pop(
                        AddRescuerResult(
                          rescuerId: id,
                          viewProfile: true,
                        ),
                      ),
                      icon: const Icon(Icons.account_circle_outlined),
                      label: const BodyMediumText(text: 'مشاهده پروفایل'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
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
