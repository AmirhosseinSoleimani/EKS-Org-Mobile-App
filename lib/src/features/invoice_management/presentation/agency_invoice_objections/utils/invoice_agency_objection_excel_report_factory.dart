import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/invoice_agency_objection_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/agency_invoice_objections/utils/invoice_agency_objection_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_column.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_request.dart';

class InvoiceAgencyObjectionExcelReportFactory {
  const InvoiceAgencyObjectionExcelReportFactory._();

  static ExcelExportRequest create(List<InvoiceAgencyObjectionEntity> items) {
    return ExcelExportRequest.fromItems<InvoiceAgencyObjectionEntity>(
      fileNamePrefix: 'invoice_agency_objection_report',
      sheetName: 'درخواست های اصلاحی نماینده',
      items: items,
      columns: [
        ExcelExportColumn(
          title: 'شماره درخواست',
          valueBuilder: (item, _) => item.request?.serviceRequestTrackCode,
          width: 20,
        ),
        ExcelExportColumn(
          title: 'نام امدادخواه',
          valueBuilder: (item, _) => item.request?.emdadkhahFullName,
          width: 24,
        ),
        ExcelExportColumn(
          title: 'نمایندگی',
          valueBuilder: (item, _) =>
              InvoiceAgencyObjectionFormatter.agency(item.agency),
          width: 28,
        ),
        ExcelExportColumn(
          title: 'امدادگر',
          valueBuilder: (item, _) => item.agency?.aidPerName,
          width: 22,
        ),
        ExcelExportColumn(
          title: 'وضعیت',
          valueBuilder: (item, _) => item.identity?.statusTitle,
          width: 18,
        ),
        ExcelExportColumn(
          title: 'توضیحات',
          valueBuilder: (item, _) => item.request?.description,
          width: 34,
        ),
        ExcelExportColumn(
          title: 'بررسی کننده',
          valueBuilder: (item, _) => item.review?.checkAuthorFullName,
          width: 22,
        ),
        ExcelExportColumn(
          title: 'توضیحات بررسی',
          valueBuilder: (item, _) => item.review?.checkAuthorDescription,
          width: 38,
        ),
        ExcelExportColumn(
          title: 'تاریخ بررسی',
          valueBuilder: (item, _) => JalaliDateHelper.formatStringJalaliDateTime(
            item.review?.checkAuthorDateTimeJalali,
          ),
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
