import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_record_entity.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_column.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_request.dart';

class CustomerPreInvoiceExcelReportFactory {
  const CustomerPreInvoiceExcelReportFactory._();

  static ExcelExportRequest create(List<InvoiceRecordEntity> items) {
    return ExcelExportRequest.fromItems<InvoiceRecordEntity>(
      fileNamePrefix: 'customer_pre_invoice_report',
      sheetName: 'پیش فاکتورهای مشتری',
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
          title: 'خودرو',
          valueBuilder: (item, _) => item.vehicle?.carName,
          width: 22,
        ),
        ExcelExportColumn(
          title: 'شماره شاسی',
          valueBuilder: (item, _) => item.vehicle?.chassisNumber,
          width: 22,
        ),
        ExcelExportColumn(
          title: 'خدمت',
          valueBuilder: (item, _) => item.state?.serviceTitle,
          width: 32,
        ),
        ExcelExportColumn(
          title: 'وضعیت فاکتور',
          valueBuilder: (item, _) => item.state?.invoiceStatusTitle,
          width: 18,
        ),
        ExcelExportColumn(
          title: 'مبلغ مشتری',
          valueBuilder: (item, _) => item.amounts?.customerTotalPrice,
          width: 20,
        ),
        ExcelExportColumn(
          title: 'مبلغ شرکت',
          valueBuilder: (item, _) => item.amounts?.companyTotalPrice,
          width: 20,
        ),
        ExcelExportColumn(
          title: 'گارانتی',
          valueBuilder: (item, _) => item.state?.isGaranty == true ? 'بله' : 'خیر',
          width: 14,
        ),
        ExcelExportColumn(
          title: 'اشتراکی',
          valueBuilder: (item, _) => item.state?.subscription == true ? 'بله' : 'خیر',
          width: 14,
        ),
        ExcelExportColumn(
          title: 'ثبت کننده',
          valueBuilder: (item, _) => item.audit?.insertUserName,
          width: 22,
        ),
        ExcelExportColumn(
          title: 'تاریخ ثبت',
          valueBuilder: (item, _) => item.audit?.insertDateTimeJalali,
          width: 22,
        ),
      ],
    );
  }
}
