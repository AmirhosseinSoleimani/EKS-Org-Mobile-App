import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/rescuer_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/key_value_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class RescuerPersonalInfoSection extends StatelessWidget {
  final RescuerEntity item;

  const RescuerPersonalInfoSection({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return FormSectionContainer(
      hasBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const BodyMediumText(
            text: 'اطلاعات فردی',
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 12),
          KeyValueRow(label: 'کد ملی', value: _value(item.nationalNumber)),
          KeyValueRow(label: 'نام پدر', value: _value(item.fatherName)),
          KeyValueRow(label: 'تاریخ تولد', value: _value(item.birthDateJalali)),
          KeyValueRow(
            label: 'محل تولد',
            value: _joinLocation(
              item.provinceNamePlaceOfBirth,
              item.cityNamePlaceOfBirth,
            ),
          ),
          KeyValueRow(
            label: 'محل صدور',
            value: _joinLocation(
              item.provinceNameIssuingPlace,
              item.cityNameIssuingPlace,
            ),
          ),
          KeyValueRow(label: 'تحصیلات', value: _value(item.degreeTitle)),
          KeyValueRow(label: 'وضعیت تأهل', value: _value(item.maritalTitle)),
        ],
      ),
    );
  }

  String _value(String? value) {
    final result = value?.trim();
    return result == null || result.isEmpty ? '-' : result;
  }

  String _joinLocation(String? province, String? city) {
    final values = [province, city]
        .map((item) => item?.trim())
        .whereType<String>()
        .where((item) => item.isNotEmpty)
        .toList(growable: false);
    return values.isEmpty ? '-' : values.join(' - ');
  }
}
