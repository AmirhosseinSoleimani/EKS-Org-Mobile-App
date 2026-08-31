import 'package:eks_sana_plus_org/src/features/imei/domain/entities/imei_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_column.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_request.dart';

class ImeiExcelReportFactory {
  const ImeiExcelReportFactory._();

  static ExcelExportRequest create({
    required List<ImeiInfoEntity> records,
  }) {
    return ExcelExportRequest.fromItems<ImeiInfoEntity>(
      fileNamePrefix: 'imei_report',
      sheetName: 'گزارش IMEI',
      items: records,
      columns: [
        ExcelExportColumn<ImeiInfoEntity>(
          title: 'نوع دستگاه',
          valueBuilder: (item, _) => item.deviceName,
          width: 24,
        ),
        ExcelExportColumn<ImeiInfoEntity>(
          title: 'شماره سیم کارت',
          valueBuilder: (item, _) => item.simNumber,
          width: 20,
        ),
        ExcelExportColumn<ImeiInfoEntity>(
          title: 'سریال دستگاه',
          valueBuilder: (item, _) => item.avlSerial,
          width: 22,
        ),
        ExcelExportColumn<ImeiInfoEntity>(
          title: 'IMEI',
          valueBuilder: (item, _) => item.imei,
          width: 24,
        ),
        ExcelExportColumn<ImeiInfoEntity>(
          title: 'وضعیت',
          valueBuilder: (item, _) =>
              item.isActive == true ? 'فعال' : 'غیرفعال',
          width: 14,
        ),
        ExcelExportColumn<ImeiInfoEntity>(
          title: 'نام ثبت کننده',
          valueBuilder: (item, _) => item.insertUserFullName,
          width: 22,
        ),
        ExcelExportColumn<ImeiInfoEntity>(
          title: 'تاریخ و زمان ثبت',
          valueBuilder: (item, _) => item.insertDateTimeJalali,
          width: 22,
        ),
        ExcelExportColumn<ImeiInfoEntity>(
          title: 'نام ویرایش کننده',
          valueBuilder: (item, _) => item.updateUserFullName,
          width: 22,
        ),
        ExcelExportColumn<ImeiInfoEntity>(
          title: 'تاریخ و زمان ویرایش',
          valueBuilder: (item, _) => item.updateDateTimeJalali,
          width: 22,
        ),
      ],
    );
  }
}
