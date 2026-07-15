import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/rescuer_entity.dart';
import 'package:eks_sana_plus_org/src/shared/extensions/string_extensions.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/key_value_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class RescuerContactInfoSection extends StatelessWidget {
  final RescuerEntity item;

  const RescuerContactInfoSection({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return FormSectionContainer(
      hasBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const BodyMediumText(
            text: 'اطلاعات تماس و همکاری',
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 12),
          KeyValueRow(
            label: 'تلفن همراه',
            value: item.mobile?.toLocalMobile() ?? '-',
          ),
          KeyValueRow(
            label: 'تلفن ثابت',
            value: _value(item.tel),
          ),
          KeyValueRow(
            label: 'آدرس',
            value: _value(item.address),
          ),
          KeyValueRow(
            label: 'اعتبار گواهینامه',
            value: _value(item.licenseCode),
          ),
          KeyValueRow(
            label: 'سایز لباس',
            value: _value(item.clothingSize),
          ),
          KeyValueRow(
            label: 'سایز کفش',
            value: item.shoesSize?.toString() ?? '-',
          ),
          KeyValueRow(
            label: 'ثبت‌کننده',
            value: _value(item.insertUserFullName),
          ),
          KeyValueRow(
            label: 'زمان ثبت',
            value: _value(item.insertDateTimeJalali),
          ),
        ],
      ),
    );
  }

  String _value(String? value) {
    final result = value?.trim();
    return result == null || result.isEmpty ? '-' : result;
  }
}
