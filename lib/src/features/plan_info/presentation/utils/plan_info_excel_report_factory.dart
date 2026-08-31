import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_column.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_request.dart';

class PlanInfoExcelReportFactory {
  const PlanInfoExcelReportFactory._();

  static ExcelExportRequest create(List<PlanInfoEntity> items) {
    return ExcelExportRequest.fromItems<PlanInfoEntity>(
      fileNamePrefix: 'plan_info_report',
      sheetName: 'گزارش برنامه‌ریزی‌ها',
      items: items,
      columns: [
        _column('شناسه نمایندگی', 'agencyInfoId'),
        _column('نوع نمایندگی', 'agencyInfoTypeTitle'),
        _column('استان نمایندگی', 'agencyInfoProvinceName'),
        _column('شهر نمایندگی', 'agencyInfoCityName'),
        _column('کد نمایندگی', 'agencyInfoCode'),
        _column('نام نمایندگی', 'agencyInfoName', width: 26),
        _column('نام مدیر', 'managerFirstName'),
        _column('نام خانوادگی مدیر', 'managerLastName'),
        _column('شماره ملی نمایندگی', 'agencyInfoNationalNo'),
        _column('کد اقتصادی', 'agencyInfoEconomicCode'),
        _column('موبایل نمایندگی', 'agencyInfoMobile'),
        _column('آدرس نمایندگی', 'agencyInfoAddress', width: 34),
        _column('کد پستی نمایندگی', 'agencyInfoPostalCode'),
        _column('شناسه ملی نمایندگی', 'agencyInfoNationalId'),
        _boolColumn('وضعیت مالیاتی نمایندگی', 'agencyInfoHasTax', 'دارد', 'ندارد'),
        _boolColumn('وضعیت نمایندگی', 'agencyInfoIsActive', 'فعال', 'غیرفعال'),
        _column('شناسه خودرو', 'vehicleInfoId'),
        _column('شناسه مدل خودرو', 'vehicleInfoModelId'),
        _column('مدل خودرو', 'vehicleInfoModelTitle'),
        _column('شناسه IMEI خودرو', 'vehicleInfoIMEIID'),
        _column('IMEI خودرو', 'vehicleInfoIMEI'),
        _column('شماره پلاک', 'vehicleInfoLicensePlate'),
        _column('شماره شاسی', 'vehicleInfoChassisNumber'),
        _column('شماره موتور', 'vehicleInfoEngineNumber'),
        _column('سال تولید خودرو', 'vehicleInfoProductYear'),
        _boolColumn('وضعیت خودرو', 'vehicleInfoIsActive', 'فعال', 'غیرفعال'),
        _column('شناسه وسیله نقلیه نمایندگی', 'agencyVehicleId', width: 24),
        _column('تاریخ شروع قرارداد وسیله نقلیه', 'agencyVehicleContractStartDateJalali', width: 28),
        _column('تاریخ پایان قرارداد وسیله نقلیه', 'agencyVehicleContractEndDateJalali', width: 28),
        _column('کد لیبل وسیله نقلیه', 'agencyVehicleLabelCode'),
        _boolColumn('وضعیت وسیله نقلیه نمایندگی', 'agencyVehicleIsActive', 'فعال', 'غیرفعال'),
        _column('شناسه امدادرسان - نمایندگی', 'agencyPersonId', width: 24),
        _column('موبایل پرسنل', 'agencyPersonMobile'),
        _column('تاریخ شروع قرارداد پرسنل', 'agencyPersonContractStartDateJalali', width: 26),
        _column('تاریخ پایان قرارداد پرسنل', 'agencyPersonContractEndDateJalali', width: 26),
        _column('نوع فعالیت پرسنل', 'agencyPersonActivityTypeTitle'),
        _boolColumn('وضعیت پرسنل', 'agencyPersonIsActive', 'فعال', 'غیرفعال'),
        _column('شناسه امدادرسان', 'personInfoId'),
        _column('وضعیت تأهل', 'personInfoMaritalTitle'),
        _column('نام', 'personInfoFirstName'),
        _column('نام خانوادگی', 'personInfoLastName'),
        _column('نام پدر', 'personInfoFatherName'),
        _column('شماره ملی', 'personInfoNationalNumber'),
        _column('تلفن', 'personInfoTel'),
        _column('موبایل', 'personInfoMobile'),
        _boolColumn('وضعیت امدادرسان', 'personInfoIsActive', 'فعال', 'غیرفعال'),
        _personColumn('نام امدادرسان اول', 0, (item) => item.fullName),
        _personColumn('شماره ملی امدادرسان اول', 0, (item) => item.nationalNumber),
        _personColumn('نام امدادرسان دوم', 1, (item) => item.fullName),
        _personColumn('شماره ملی امدادرسان دوم', 1, (item) => item.nationalNumber),
        _personColumn('نام امدادرسان سوم', 2, (item) => item.fullName),
        _personColumn('شماره ملی امدادرسان سوم', 2, (item) => item.nationalNumber),
        _personColumn('نام امدادرسان چهارم', 3, (item) => item.fullName),
        _personColumn('شماره ملی امدادرسان چهارم', 3, (item) => item.nationalNumber),
        _column('شناسه واحد امدادی', 'emdadUnitId'),
        _column('درجه واحد امدادی', 'emdadUnitGradeTitle'),
        _column('نوع کانکس واحد امدادی', 'emdadUnitSeatTypeTitle'),
        _column('شناسه محل استقرار واحد امدادی', 'emdadUnitLocationId', width: 26),
        _column('محل استقرار واحد امدادی', 'emdadUnitLocationTitle', width: 26),
        _column('عرض جغرافیایی واحد امدادی', 'emdadUnitLatitude', width: 24),
        _column('طول جغرافیایی واحد امدادی', 'emdadUnitLongitude', width: 24),
        _column('آدرس واحد امدادی', 'emdadUnitAddress', width: 34),
        _column('شناسه برنامه ریزی', 'planId'),
        _column('نوع شیفت', 'shiftTypeTitle'),
        _column('شناسه شیفت', 'shiftId'),
        _column('عنوان شیفت', 'shiftTitle'),
        _column('شناسه طرح ویژه', 'specialPlanId'),
        _column('عنوان طرح ویژه', 'specialPlanTitle'),
        _column('تاریخ شروع برنامه ریزی', 'fromDateJalali', width: 24),
        _column('تاریخ پایان برنامه ریزی', 'toDateJalali', width: 24),
        _column('نوع کانکس برنامه ریزی', 'planSeatTypeTitle'),
        _column('شناسه محل استقرار', 'planLocationId'),
        _column('محل استقرار', 'planLocationTitle'),
        _column('عرض جغرافیایی برنامه ریزی', 'planLatitude', width: 24),
        _column('طول جغرافیایی برنامه ریزی', 'planLongitude', width: 24),
        _column('آدرس محل استقرار', 'planAddress', width: 34),
        _boolColumn('وضعیت طرح', 'planIsActive', 'فعال', 'غیرفعال'),
        _column('دلیل تغییر وضعیت', 'reasonTitle'),
        _column('توضیحات', 'description', width: 34),
      ],
    );
  }

  static ExcelExportColumn<PlanInfoEntity> _column(
    String title,
    String key, {
    double width = 22,
  }) {
    return ExcelExportColumn<PlanInfoEntity>(
      title: title,
      valueBuilder: (item, _) => item.reportValue(key),
      width: width,
    );
  }

  static ExcelExportColumn<PlanInfoEntity> _boolColumn(
    String title,
    String key,
    String trueText,
    String falseText,
  ) {
    return ExcelExportColumn<PlanInfoEntity>(
      title: title,
      valueBuilder: (item, _) =>
          _asBool(item.reportValue(key)) ? trueText : falseText,
      width: 22,
    );
  }

  static ExcelExportColumn<PlanInfoEntity> _personColumn(
    String title,
    int index,
    String? Function(PlanPersonEntity) valueBuilder,
  ) {
    return ExcelExportColumn<PlanInfoEntity>(
      title: title,
      valueBuilder: (item, _) => item.emdadUnitPersons.length > index
          ? valueBuilder(item.emdadUnitPersons[index])
          : null,
      width: 24,
    );
  }

  static bool _asBool(Object? value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final normalized = value.trim().toLowerCase();
      return normalized == 'true' || normalized == '1';
    }
    return false;
  }
}
