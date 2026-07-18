import 'dart:io';

import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_certificate_entity.dart';
import 'package:path_provider/path_provider.dart';

class SkillCertificateExcelExporter {
  static Future<String> export(List<SkillCertificateEntity> items) async {
    final directory = await getTemporaryDirectory();
    final file = File(
      '${directory.path}/skill_certificates_${DateTime.now().millisecondsSinceEpoch}.csv',
    );

    final rows = <List<String>>[
      [
        'عنوان',
        'وضعیت',
        'نام ثبت کننده',
        'تاریخ و زمان ثبت',
        'نام ویرایش کننده',
        'تاریخ و زمان ویرایش',
      ],
      ...items.map(
        (item) => [
          item.title ?? '',
          item.isActive ? 'فعال' : 'غیرفعال',
          item.insertUserFullName ?? '',
          item.insertDateTimeJalali ?? '',
          item.updateUserFullName ?? '',
          item.updateDateTimeJalali ?? '',
        ],
      ),
    ];

    final csv = rows.map((row) => row.map(_escape).join(',')).join('\n');
    await file.writeAsString('\uFEFF$csv');

    return file.path;
  }

  static String _escape(String value) {
    final escaped = value.replaceAll('"', '""');
    return '"$escaped"';
  }
}
