import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_column.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_request.dart';

class SkillCertificateExcelReportFactory {
  const SkillCertificateExcelReportFactory._();

  static ExcelExportRequest create(List<SkillCertificateEntity> items) {
    return ExcelExportRequest.fromItems<SkillCertificateEntity>(
      fileNamePrefix: 'skill_certificates_report',
      sheetName: 'گزارش گواهینامه مهارت',
      items: items,
      columns: [
        ExcelExportColumn(title: 'عنوان', valueBuilder: (item, _) => item.title, width: 28),
        ExcelExportColumn(title: 'وضعیت', valueBuilder: (item, _) => item.isActive ? 'فعال' : 'غیرفعال', width: 14),
        ExcelExportColumn(title: 'نام ثبت کننده', valueBuilder: (item, _) => item.insertUserFullName, width: 22),
        ExcelExportColumn(title: 'تاریخ و زمان ثبت', valueBuilder: (item, _) => item.insertDateTimeJalali, width: 22),
        ExcelExportColumn(title: 'نام ویرایش کننده', valueBuilder: (item, _) => item.updateUserFullName, width: 22),
        ExcelExportColumn(title: 'تاریخ و زمان ویرایش', valueBuilder: (item, _) => item.updateDateTimeJalali, width: 22),
      ],
    );
  }
}
