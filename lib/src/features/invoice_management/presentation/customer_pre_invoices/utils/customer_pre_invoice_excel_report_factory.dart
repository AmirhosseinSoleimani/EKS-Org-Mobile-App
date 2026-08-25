import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
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
          title: 'ردیف',
          valueBuilder: (_, index) => index + 1,
          width: 10,
        ),
        ExcelExportColumn(
          title: 'شماره درخواست',
          valueBuilder: (item, _) =>
              item.identity?.requestTrackCode ??
              item.identity?.serviceRequestTrackCode,
          width: 18,
        ),
        ExcelExportColumn(
          title: 'تاریخ و ساعت درخواست',
          valueBuilder: (item, _) =>
              item.identity?.serviceRequestInsertDataTimeJalali,
          width: 24,
        ),
        ExcelExportColumn(
          title: 'تاریخ اعزام',
          valueBuilder: (item, _) => item.identity?.assignDateJalali,
          width: 18,
        ),
        ExcelExportColumn(
          title: 'ساعت اعزام',
          valueBuilder: (item, _) => item.identity?.assignDateTimeJalali,
          width: 18,
        ),
        ExcelExportColumn(
          title: 'کد اشتراک',
          valueBuilder: (item, _) => item.state?.subscriptionCode,
          width: 18,
        ),
        ExcelExportColumn(
          title: 'نام نمایندگی',
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
          title: 'استان نمایندگی',
          valueBuilder: (item, _) => item.agency?.agencyProvinceName,
          width: 20,
        ),
        ExcelExportColumn(
          title: 'شهر نمایندگی',
          valueBuilder: (item, _) => item.agency?.agencyCityName,
          width: 20,
        ),
        ExcelExportColumn(
          title: 'کد امدادرسان',
          valueBuilder: (item, _) => item.agency?.emdadgarId,
          width: 18,
        ),
        ExcelExportColumn(
          title: 'نام امدادرسان',
          valueBuilder: (item, _) => item.agency?.emdadgarName,
          width: 24,
        ),
        ExcelExportColumn(
          title: 'گروه وزنی خودرو',
          valueBuilder: (item, _) => item.operation?.wageGroupTypeTitle,
          width: 20,
        ),
        ExcelExportColumn(
          title: 'شماره پلاک خودرو امدادرسان',
          valueBuilder: (item, _) => item.agency?.emdadgarPlate,
          width: 24,
        ),
        ExcelExportColumn(
          title: 'نوع ناوگان',
          valueBuilder: (item, _) => item.agency?.navganType,
          width: 18,
        ),
        ExcelExportColumn(
          title: 'آدرس امدادخواه',
          valueBuilder: (item, _) => item.customer?.aidAddress,
          width: 36,
        ),
        ExcelExportColumn(
          title: 'نام خودرو',
          valueBuilder: (item, _) => item.vehicle?.carName,
          width: 22,
        ),
        ExcelExportColumn(
          title: 'شماره شاسی',
          valueBuilder: (item, _) => item.vehicle?.chassisNumber,
          width: 22,
        ),
        ExcelExportColumn(
          title: 'استان مشتری',
          valueBuilder: (item, _) => item.customer?.provinceName,
          width: 20,
        ),
        ExcelExportColumn(
          title: 'شهر مشتری',
          valueBuilder: (item, _) => item.customer?.cityName,
          width: 20,
        ),
        ExcelExportColumn(
          title: 'وضعیت اشتراک',
          valueBuilder: (item, _) =>
              item.state?.subscription == true ? 'مشترک' : 'غیرمشترک',
          width: 18,
        ),
        ExcelExportColumn(
          title: 'عنوان بسته سرویس',
          valueBuilder: (item, _) => item.state?.productTitle,
          width: 28,
        ),
        ExcelExportColumn(
          title: 'ایراد اظهاری مشتری',
          valueBuilder: (item, _) => item.vehicle?.serviceRequestDefectTitle,
          width: 30,
        ),
        ExcelExportColumn(
          title: 'نوع خدمت',
          valueBuilder: (item, _) =>
              item.state?.serviceTypeTitle ??
              _serviceTypeTitle(item.state?.serviceType),
          width: 18,
        ),
        ExcelExportColumn(
          title: 'سرویس ارائه شده',
          valueBuilder: (item, _) => item.state?.serviceGivenTitle,
          width: 30,
        ),
        ExcelExportColumn(
          title: 'مسافت طی شده',
          valueBuilder: (item, _) => item.operation?.distanceToCustomer,
          width: 18,
        ),
        ExcelExportColumn(
          title: 'مسافت حمل',
          valueBuilder: (item, _) => item.operation?.distanceHamlCustomer,
          width: 18,
        ),
        ExcelExportColumn(
          title: 'استفاده از دکل',
          valueBuilder: (item, _) => item.operation?.useDakal == true ? 'بله' : 'خیر',
          width: 16,
        ),
        ExcelExportColumn(
          title: 'مدت زمان توقف(دقیقه)',
          valueBuilder: (item, _) => item.operation?.stopTime,
          width: 22,
        ),
        ExcelExportColumn(
          title: 'ایام تعطیل/شب',
          valueBuilder: (item, _) =>
              item.operation?.nightOrHoliday == true ? 'بله' : 'خیر',
          width: 18,
        ),
        ExcelExportColumn(
          title: '(عنوان) ایام تعطیل/شب/روز',
          valueBuilder: (item, _) => item.operation?.nightOrHolidayTitle,
          width: 28,
        ),
        ExcelExportColumn(
          title: 'تاریخ فاکتور',
          valueBuilder: (item, _) =>
              item.identity?.customerInvoiceDateTimeJalali ?? '---',
          width: 22,
        ),
        ExcelExportColumn(
          title: 'ثبت کننده فاکتور',
          valueBuilder: (item, _) => item.audit?.insertUserName ?? '---',
          width: 22,
        ),
        ExcelExportColumn(
          title: 'تاریخ ثبت فاکتور',
          valueBuilder: (item, _) => item.audit?.insertDateTimeJalali ?? '---',
          width: 22,
        ),
        ExcelExportColumn(
          title: 'ویرایش کننده فاکتور',
          valueBuilder: (item, _) => item.audit?.updateUserName ?? '---',
          width: 22,
        ),
        ExcelExportColumn(
          title: 'تاریخ ویرایش فاکتور',
          valueBuilder: (item, _) => item.audit?.updateDateTimeJalali ?? '---',
          width: 22,
        ),
      ],
    );
  }

  static String? _serviceTypeTitle(int? value) {
    for (final serviceType in ServiceType.values) {
      if (serviceType.value == value) return serviceType.label;
    }
    return null;
  }
}
