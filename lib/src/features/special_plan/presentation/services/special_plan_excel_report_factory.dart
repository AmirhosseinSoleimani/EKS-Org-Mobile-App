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
      final title = item.productTitle?.trim();
      if (title?.isNotEmpty == true) return title!;
      for (final product in products) {
        if (product.id == item.productId) return product.title;
      }
      return '---';
    }

    return ExcelExportRequest.fromItems<SpecialPlanEntity>(
      fileNamePrefix: 'special_plans_report',
      sheetName: 'گزارش طرح‌ها',
      items: records,
      columns: [
        ExcelExportColumn(
          title: 'شناسه',
          valueBuilder: (item, _) => item.id,
          width: 12,
        ),
        ExcelExportColumn(
          title: 'عنوان طرح',
          valueBuilder: (item, _) => item.title,
          width: 28,
        ),
        ExcelExportColumn(
          title: 'محصول',
          valueBuilder: (item, _) => productTitle(item),
          width: 28,
        ),
        ExcelExportColumn(
          title: 'شناسه محصول',
          valueBuilder: (item, _) => item.productId,
          width: 14,
        ),
        ExcelExportColumn(
          title: 'محدوده جغرافیایی',
          valueBuilder: (item, _) => item.displayAreaTitle,
          width: 26,
        ),
        ExcelExportColumn(
          title: 'شناسه محدوده',
          valueBuilder: (item, _) => item.areaBaseInfoId,
          width: 14,
        ),
        ExcelExportColumn(
          title: 'تاریخ شروع',
          valueBuilder: (item, _) =>
              SpecialPlanDateFormatter.jalaliDate(item.startDate),
          width: 16,
        ),
        ExcelExportColumn(
          title: 'تاریخ پایان',
          valueBuilder: (item, _) =>
              SpecialPlanDateFormatter.jalaliDate(item.endDate),
          width: 16,
        ),
        ExcelExportColumn(
          title: 'شماره اولویت',
          valueBuilder: (item, _) => item.orderNo,
          width: 14,
        ),
        ExcelExportColumn(
          title: 'اولویت بالا',
          valueBuilder: (item, _) => item.hasHighPriority,
          width: 14,
        ),
        ExcelExportColumn(
          title: 'فقط خودروهای سایپایی',
          valueBuilder: (item, _) => item.onlySaipaCars,
          width: 22,
        ),
        ExcelExportColumn(
          title: 'وضعیت',
          valueBuilder: (item, _) =>
              item.isActive == true ? 'فعال' : 'غیرفعال',
          width: 14,
        ),
        ExcelExportColumn(
          title: 'ثبت‌کننده',
          valueBuilder: (item, _) => item.insertUserFullName,
          width: 22,
        ),
        ExcelExportColumn(
          title: 'تاریخ ثبت',
          valueBuilder: (item, _) => item.insertDateTimeJalali ??
              SpecialPlanDateFormatter.jalaliDateTime(item.insertDateTime),
          width: 22,
        ),
        ExcelExportColumn(
          title: 'ویرایش‌کننده',
          valueBuilder: (item, _) => item.updateUserFullName,
          width: 22,
        ),
      ],
    );
  }
}
