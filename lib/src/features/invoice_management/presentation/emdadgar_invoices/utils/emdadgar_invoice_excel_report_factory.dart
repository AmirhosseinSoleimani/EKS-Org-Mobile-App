import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/emdadgar_invoice_record_entity.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_column.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_request.dart';

class EmdadgarInvoiceExcelReportFactory {
  const EmdadgarInvoiceExcelReportFactory._();

  static ExcelExportRequest create(List<EmdadgarInvoiceRecordEntity> items) {
    return ExcelExportRequest.fromItems<EmdadgarInvoiceRecordEntity>(
      fileNamePrefix: 'emdadgar_invoice_report',
      sheetName: 'صورت وضعیت ها',
      items: items,
      columns: [
        ExcelExportColumn(
          title: 'شماره درخواست',
          valueBuilder: (item, _) =>
              item.identity?.requestTrackCode ??
              item.identity?.serviceRequestTrackCode,
          width: 20,
        ),
        ExcelExportColumn(
          title: 'نام امدادخواه',
          valueBuilder: (item, _) => item.customer?.fullName,
          width: 24,
        ),
        ExcelExportColumn(
          title: 'نمایندگی',
          valueBuilder: (item, _) =>
              item.agency?.agencyName ?? item.agency?.representationName,
          width: 26,
        ),
        ExcelExportColumn(
          title: 'کد نمایندگی',
          valueBuilder: (item, _) =>
              item.agency?.agencyCode ?? item.agency?.representationCode,
          width: 18,
        ),
        ExcelExportColumn(
          title: 'امدادگر',
          valueBuilder: (item, _) => item.agency?.emdadgarName,
          width: 22,
        ),
        ExcelExportColumn(
          title: 'وضعیت',
          valueBuilder: (item, _) => item.state?.invoiceStatusTitle,
          width: 18,
        ),
        ExcelExportColumn(
          title: 'مبلغ پرداختی به نماینده',
          valueBuilder: (item, _) =>
              item.settlement?.amounts?.totalPrice ??
              item.amounts?.companyTotalPrice,
          width: 24,
        ),
        ExcelExportColumn(
          title: 'گارانتی',
          valueBuilder: (item, _) =>
              item.state?.isGaranty == true ? 'بله' : 'خیر',
          width: 14,
        ),
        ExcelExportColumn(
          title: 'اشتراک',
          valueBuilder: (item, _) =>
              item.state?.subscription == true ? 'مشترک' : 'غیر مشترک',
          width: 14,
        ),
        ExcelExportColumn(
          title: 'ثبت کننده',
          valueBuilder: (item, _) => item.audit?.insertUserName,
          width: 22,
        ),
        ExcelExportColumn(
          title: 'تاریخ ثبت',
          valueBuilder: (item, _) => JalaliDateHelper.formatStringJalaliDateTime(
            item.audit?.insertDateTimeJalali,
          ),
          width: 22,
        ),
      ],
    );
  }
}
