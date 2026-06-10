import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';

class TransportInformationSection extends StatelessWidget {
  const TransportInformationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FormSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          TitleLargeText(
            text: 'اطلاعات حمل',
            fontSize: 16,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 16),
          Text('فرم اطلاعات حمل بعداً اینجا پیاده‌سازی می‌شود.'),
        ],
      ),
    );
  }
}
