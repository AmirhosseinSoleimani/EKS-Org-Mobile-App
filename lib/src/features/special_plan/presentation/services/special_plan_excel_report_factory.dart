import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_product_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/services/special_plan_date_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_column.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_request.dart';

class SpecialPlanExcelReportFactory {
  const SpecialPlanExcelReportFactory._();

  static ExcelExportRequest create({
    required List<SpecialPlanEntity> records,
    required List<SpecialPlanProductEntity> products,
  }) {
    String productTitle(SpecialPlanEntity item) {
      return item.productTitle?.trim() ?? '';
    }

    return ExcelExportRequest.fromItems<SpecialPlanEntity>(
      fileNamePrefix: 'special_plans_report',
      sheetName: 'گزارش طرح‌ها',
      items: records,
      includeRowNumber: false,
      columns: [
        ExcelExportColumn(
          title: 'عنوان',
          valueBuilder: (item, _) => item.title,
          width: 28,
        ),
        ExcelExportColumn(
          title: 'وضعیت',
          valueBuilder: (item, _) =>
              item.isActive == true ? 'فعال' : 'غیرفعال',
          width: 14,
        ),
        ExcelExportColumn(
          title: 'محصول',
          valueBuilder: (item, _) => productTitle(item),
          width: 28,
        ),
        ExcelExportColumn(
          title: 'شماره اولویت',
          valueBuilder: (item, _) => item.orderNo,
          width: 14,
        ),
        ExcelExportColumn(
          title: 'اولویت بالا',
          valueBuilder: (item, _) =>
              item.hasHighPriority == true ? 'دارد' : 'ندارد',
          width: 14,
        ),
        ExcelExportColumn(
          title: 'فقط خودروهای سایپایی',
          valueBuilder: (item, _) =>
              item.onlySaipaCars == true ? 'فعال' : 'غیرفعال',
          width: 22,
        ),
        ExcelExportColumn(
          title: 'استان',
          valueBuilder: (item, _) => item.provinceTitle,
          width: 18,
        ),
        ExcelExportColumn(
          title: 'شهر',
          valueBuilder: (item, _) => item.cityTitle,
          width: 18,
        ),
        ExcelExportColumn(
          title: 'زمان شروع',
          valueBuilder: (item, _) =>
              SpecialPlanDateFormatter.jalaliDate(item.startDate),
          width: 16,
        ),
        ExcelExportColumn(
          title: 'زمان پایان',
          valueBuilder: (item, _) =>
              SpecialPlanDateFormatter.jalaliDate(item.endDate),
          width: 16,
        ),
        ExcelExportColumn(
          title: 'پیام',
          valueBuilder: (item, _) => item.message,
          width: 32,
        ),
        ExcelExportColumn(
          title: 'نام ثبت کننده',
          valueBuilder: (item, _) => item.insertUserFullName,
          width: 22,
        ),
        ExcelExportColumn(
          title: 'تاریخ و زمان ثبت',
          valueBuilder: (item, _) => item.insertDateTimeJalali ??
              SpecialPlanDateFormatter.jalaliDateTime(item.insertDateTime),
          width: 22,
        ),
        ExcelExportColumn(
          title: 'نام ویرایش کننده',
          valueBuilder: (item, _) => item.updateUserFullName,
          width: 22,
        ),
        ExcelExportColumn(
          title: 'تاریخ و زمان ویرایش',
          valueBuilder: (item, _) => item.updateDateTimeJalali ??
              SpecialPlanDateFormatter.jalaliDateTime(item.updateDateTime),
          width: 22,
        ),
      ],
    );
  }
}
