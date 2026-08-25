import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/emdadgar_invoice_record_entity.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_column.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_request.dart';

class EmdadgarInvoiceExcelReportFactory {
  const EmdadgarInvoiceExcelReportFactory._();

  static ExcelExportRequest create(List<EmdadgarInvoiceRecordEntity> items) {
    return ExcelExportRequest.fromItems<EmdadgarInvoiceRecordEntity>(
      fileNamePrefix: 'گزارش صورت وضعیت نماینده',
      sheetName: 'data',
      items: items,
      columns: [
        ExcelExportColumn(
          title: 'شماره درخواست',
          valueBuilder: (item, _) =>
              item.identity?.requestTrackCode ??
              item.identity?.serviceRequestTrackCode,
          width: 18,
        ),
        ExcelExportColumn(
          title: 'نوع نمایندگی',
          valueBuilder: (item, _) => item.agencyType,
          width: 20,
        ),
        ExcelExportColumn(
          title: 'کد نمایندگی',
          valueBuilder: (item, _) =>
              item.agency?.agencyCode ?? item.agency?.representationCode,
          width: 18,
        ),
        ExcelExportColumn(
          title: 'نام نمایندگی',
          valueBuilder: (item, _) =>
              item.agency?.agencyName ?? item.agency?.representationName,
          width: 26,
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
          title: 'تاریخ درخواست',
          valueBuilder: (item, _) =>
              _datePart(item.identity?.serviceRequestInsertDataTimeJalali),
          width: 18,
        ),
        ExcelExportColumn(
          title: 'ساعت درخواست',
          valueBuilder: (item, _) => item.identity?.requestDateTimeJalali,
          width: 18,
        ),
        ExcelExportColumn(
          title: 'نوع اشتراک',
          valueBuilder: (item, _) =>
              item.state?.subscription == true ? 'مشترک' : 'غیرمشترک',
          width: 18,
        ),
        ExcelExportColumn(
          title: 'کد اشتراک',
          valueBuilder: (item, _) => item.state?.subscriptionCode,
          width: 18,
        ),
        ExcelExportColumn(
          title: 'گروه وزنی خودرو',
          valueBuilder: (item, _) => item.operation?.wageGroupTypeTitle,
          width: 20,
        ),
        ExcelExportColumn(
          title: 'نام امدادرسان',
          valueBuilder: (item, _) => item.agency?.emdadgarName,
          width: 24,
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
          title: 'ایام تعطیل/شب',
          valueBuilder: (item, _) =>
              item.operation?.nightOrHoliday == true ? 'بله' : 'خیر',
          width: 18,
        ),
        ExcelExportColumn(
          title: 'سرویس ارائه شده',
          valueBuilder: (item, _) => item.state?.serviceGivenTitle,
          width: 30,
        ),
        ExcelExportColumn(
          title: 'نوع خدمت',
          valueBuilder: (item, _) => item.state?.serviceTypeTitle,
          width: 18,
        ),
        ExcelExportColumn(
          title: 'نام بسته',
          valueBuilder: (item, _) => item.state?.productTitle,
          width: 26,
        ),
        ExcelExportColumn(
          title: 'حق الزحمه ورودی',
          valueBuilder: (item, _) => item.settlement?.amounts?.entranceWageCost,
          width: 22,
        ),
        ExcelExportColumn(
          title: 'حق الزحمه ورودی پس از اعمال ضریب ها',
          valueBuilder: (item, _) =>
              item.settlement?.amounts?.entranceWageCostWithCoefficient,
          width: 34,
        ),
        ExcelExportColumn(
          title: 'مسافت طی شده',
          valueBuilder: (item, _) => item.operation?.distanceToCustomer,
          width: 18,
        ),
        ExcelExportColumn(
          title: 'هزینه مسافت طی شده',
          valueBuilder: (item, _) => item.settlement?.amounts?.distanceCost,
          width: 22,
        ),
        ExcelExportColumn(
          title: 'هزینه مسافت پس از اعمال ضریب ها',
          valueBuilder: (item, _) =>
              item.settlement?.amounts?.distanceCostWithCoefficient,
          width: 32,
        ),
        ExcelExportColumn(
          title: 'مدت زمان توقف(دقیقه)',
          valueBuilder: (item, _) => item.operation?.stopTime,
          width: 22,
        ),
        ExcelExportColumn(
          title: 'هزینه توقف',
          valueBuilder: (item, _) => item.settlement?.amounts?.stopTimeCost,
          width: 20,
        ),
        ExcelExportColumn(
          title: 'هزینه توقف پس از اعمال ضریب ها',
          valueBuilder: (item, _) =>
              item.settlement?.amounts?.stopTimeCostWithCoefficient,
          width: 32,
        ),
        ExcelExportColumn(
          title: 'هزینه بارگیری',
          valueBuilder: (item, _) => item.settlement?.amounts?.loadingCost,
          width: 20,
        ),
        ExcelExportColumn(
          title: 'هزینه بارگیری پس از اعمال ضریب ها',
          valueBuilder: (item, _) =>
              item.settlement?.amounts?.loadingCostWithCoefficient,
          width: 34,
        ),
        ExcelExportColumn(
          title: 'مسافت حمل',
          valueBuilder: (item, _) => item.operation?.distanceHamlCustomer,
          width: 18,
        ),
        ExcelExportColumn(
          title: 'هزینه مسافت حمل',
          valueBuilder: (item, _) => item.settlement?.amounts?.towingCost,
          width: 22,
        ),
        ExcelExportColumn(
          title: 'هزینه حمل پس از اعمال ضریب ها',
          valueBuilder: (item, _) =>
              item.settlement?.amounts?.towingCostWithCoefficient,
          width: 32,
        ),
        ExcelExportColumn(
          title: 'هزینه طرح ترافیک',
          valueBuilder: (item, _) => item.trafficPlanCost,
          width: 22,
        ),
        ExcelExportColumn(
          title: 'طرح ترافیک پس از اعمال ضریب ها',
          valueBuilder: (item, _) => item.trafficPlanCostWithCoefficient,
          width: 32,
        ),
        ExcelExportColumn(
          title: 'عوارض آزادراهی',
          valueBuilder: (item, _) => item.highwayTicketCost,
          width: 20,
        ),
        ExcelExportColumn(
          title: 'عوارض آزادراهی پس از اعمال ضریب ها',
          valueBuilder: (item, _) => item.highwayTicketCostWithCoefficient,
          width: 34,
        ),
        ExcelExportColumn(
          title: '(عنوان) ایام تعطیل/شب/روز',
          valueBuilder: (item, _) => item.operation?.nightOrHolidayTitle,
          width: 28,
        ),
        ExcelExportColumn(
          title: 'هزینه ایام تعطیل/شب',
          valueBuilder: (item, _) =>
              item.settlement?.amounts?.nightAndHolidayCost,
          width: 24,
        ),
        ExcelExportColumn(
          title: 'جمع هزینه های امدادی (عهده شرکت)',
          valueBuilder: (item, _) => item.amounts?.companyAidPrice,
          width: 32,
        ),
        ExcelExportColumn(
          title: 'جمع هزینه های امدادی (عهده مشتری)',
          valueBuilder: (item, _) => item.amounts?.customerAidPrice,
          width: 32,
        ),
        ExcelExportColumn(
          title: 'جمع اجرت راه اندازی (عهده شرکت)',
          valueBuilder: (item, _) =>
              item.settlement?.amounts?.companyTotalLaborPrice,
          width: 32,
        ),
        ExcelExportColumn(
          title: 'جمع اجرت راه اندازی (عهده مشتری)',
          valueBuilder: (item, _) =>
              item.settlement?.amounts?.customerTotalLaborPrice,
          width: 32,
        ),
        ExcelExportColumn(
          title: 'جمع اجرت راه اندازی (عهده گارانتی)',
          valueBuilder: (item, _) =>
              item.settlement?.amounts?.guarantyTotalLaborPrice,
          width: 34,
        ),
        ExcelExportColumn(
          title: 'هزینه قطعات (عهده شرکت)',
          valueBuilder: (item, _) =>
              item.settlement?.amounts?.companyTotalPartPrice,
          width: 26,
        ),
        ExcelExportColumn(
          title: 'هزینه قطعات (عهده مشتری)',
          valueBuilder: (item, _) =>
              item.settlement?.amounts?.customerTotalPartPrice,
          width: 26,
        ),
        ExcelExportColumn(
          title: 'هزینه قطعات (عهده گارانتی)',
          valueBuilder: (item, _) =>
              item.settlement?.amounts?.guarantyTotalPartPrice,
          width: 28,
        ),
        ExcelExportColumn(
          title: 'ضریب ناوگان شخصی (مشترک)',
          valueBuilder: (item, _) => item.settlement?.coefficients?.privateCarText,
          width: 26,
        ),
        ExcelExportColumn(
          title: 'مبلغ ناوگان شخصی (مشترک)',
          valueBuilder: (item, _) => item.settlement?.coefficients?.privateCarPrice,
          width: 26,
        ),
        ExcelExportColumn(
          title: 'ضریب گرید',
          valueBuilder: (item, _) => item.agencyGrade,
          width: 18,
        ),
        ExcelExportColumn(
          title: 'گرید نمایندگی',
          valueBuilder: (item, _) => item.settlement?.coefficients?.agencyGradeText,
          width: 20,
        ),
        ExcelExportColumn(
          title: 'مبلغ گرید نمایندگی',
          valueBuilder: (item, _) => item.settlement?.coefficients?.agencyGradePrice,
          width: 24,
        ),
        ExcelExportColumn(
          title: 'جمع هزینه ها بعد از اعمال ضرایب (مشترک)',
          valueBuilder: (item, _) =>
              item.settlement?.amounts?.priceAfterCoefficients,
          width: 36,
        ),
        ExcelExportColumn(
          title: 'ضریب حق مدیریت هزینه های امدادی (غیر مشترک)',
          valueBuilder: (item, _) =>
              item.settlement?.coefficients?.commissionCoefficient,
          width: 40,
        ),
        ExcelExportColumn(
          title: 'مبلغ حق مدیریت هزینه های امدادی (غیر مشترک)',
          valueBuilder: (item, _) =>
              item.settlement?.coefficients?.commissionPrice,
          width: 40,
        ),
        ExcelExportColumn(
          title: 'پاداش استفاده از نرم افزار موبایل',
          valueBuilder: (item, _) => item.settlement?.amounts?.useAppCost,
          width: 30,
        ),
        ExcelExportColumn(
          title: 'جمع هزینه ها قبل از کسورات و اضافات قانونی',
          valueBuilder: (item, _) =>
              item.settlement?.amounts?.totalWithoutTaxAndInsurance,
          width: 40,
        ),
        ExcelExportColumn(
          title: 'مبلغ بیمه',
          valueBuilder: (item, _) => item.settlement?.amounts?.insurance,
          width: 18,
        ),
        ExcelExportColumn(
          title: 'مالیات بر ارزش افزوده',
          valueBuilder: (item, _) =>
              item.settlement?.amounts?.valueAddedTaxCost,
          width: 24,
        ),
        ExcelExportColumn(
          title: 'مبلغ نهایی قابل پرداخت به نمایندگی',
          valueBuilder: (item, _) => item.settlement?.amounts?.totalPrice,
          width: 34,
        ),
        ExcelExportColumn(
          title: 'تاریخ قطعی',
          valueBuilder: (item, _) => item.finalizedDateTimeJalali,
          width: 22,
        ),
      ],
    );
  }

  static String? _datePart(String? dateTime) {
    final value = dateTime?.trim();
    if (value == null || value.isEmpty) return value;
    return value.split(RegExp(r'\s+')).first;
  }
}
