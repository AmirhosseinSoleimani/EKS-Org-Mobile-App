import 'dart:typed_data';

import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/data/service/excel_workbook_builder.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_request.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_result.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/repository/excel_export_repository.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ExcelExportRepository)
class ExcelExportRepositoryImpl implements ExcelExportRepository {
  ExcelExportRepositoryImpl(this._workbookBuilder);

  final ExcelWorkbookBuilder _workbookBuilder;

  @override
  Future<ApiResult<ExcelExportResult>> export(
    ExcelExportRequest request,
  ) async {
    try {
      if (request.rows.isEmpty) {
        return ApiResult.failure(
          failures: 'داده‌ای برای تهیه گزارش وجود ندارد.',
        );
      }

      final fileName = _buildFileName(request.fileNamePrefix);
      final fullFileName = '$fileName.xlsx';

      // Give Flutter one frame to paint the loading state before starting the
      // isolate and transferring the report data.
      await Future<void>.delayed(const Duration(milliseconds: 16));
      final bytes = kIsWeb
          ? Uint8List.fromList(
              _workbookBuilder.build(
                request,
                webFileName: fullFileName,
              ),
            )
          : await compute(buildExcelWorkbookInBackground, request);

      // excel.save() itself starts the browser download on Web.
      // Calling FileSaver here as well would download the same file twice.
      if (kIsWeb) {
        return ApiResult.success(
          data: ExcelExportResult(
            fileName: fullFileName,
            savedPath: null,
            isBrowserDownload: true,
          ),
          resultCode: 0,
        );
      }

      final savedPath = await FileSaver.instance.saveFile(
        name: fileName,
        bytes: bytes,
        fileExtension: 'xlsx',
        includeExtension: true,
        mimeType: MimeType.microsoftExcel,
      );
      final normalizedSavedPath = savedPath.trim();

      if (normalizedSavedPath.isEmpty) {
        throw StateError('مسیر فایل ذخیره‌شده دریافت نشد.');
      }

      return ApiResult.success(
        data: ExcelExportResult(
          fileName: fullFileName,
          savedPath: normalizedSavedPath,
          isBrowserDownload: false,
        ),
        resultCode: 0,
      );
    } catch (error, stacktrace) {
      return error.toApiResult(stacktrace);
    }
  }

  String _buildFileName(String prefix) {
    final normalizedPrefix = prefix
        .replaceAll(RegExp(r'[<>:"/\\|?*]'), '_')
        .replaceAll(RegExp(r'\s+'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');
    final now = DateTime.now();
    return '${normalizedPrefix.isEmpty ? 'report' : normalizedPrefix}_'
        '${now.year}${_twoDigits(now.month)}${_twoDigits(now.day)}_'
        '${_twoDigits(now.hour)}${_twoDigits(now.minute)}${_twoDigits(now.second)}';
  }

  String _twoDigits(int value) => value.toString().padLeft(2, '0');
}
