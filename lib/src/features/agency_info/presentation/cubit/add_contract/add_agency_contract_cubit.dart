import 'dart:convert';
import 'dart:typed_data';

import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/add_agency_contract_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/add_agency_contract_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/add_contract/add_agency_contract_state.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

@injectable
class AddAgencyContractCubit extends Cubit<AddAgencyContractState> {
  AddAgencyContractCubit(this._addContractUseCase)
      : super(const AddAgencyContractState());

  final AddAgencyContractUseCase _addContractUseCase;

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contractNoController = TextEditingController();
  final startDateController = TextEditingController();
  final expireDateController = TextEditingController();

  String? startDateApi;
  String? expireDateApi;
  String? fileName;
  String? fileExtension;
  String? fileBase64;
  int? fileSize;
  Uint8List? fileBytes;

  Future<void> pickFile() async {
    final result = await FilePicker.pickFiles(
      withData: true,
      type: FileType.custom,
      allowedExtensions: const ['png', 'jpg', 'jpeg', 'pdf', 'zip'],
    );
    final file = result?.files.single;
    if (file == null) return;

    final bytes = file.bytes ?? await file.xFile.readAsBytes();

    final extension = _normalizeExtension(file.extension);
    fileName = file.name;
    fileExtension = extension;
    fileSize = file.size;
    fileBytes = bytes;
    fileBase64 = 'data:${_mimeType(extension)};base64,${base64Encode(bytes)}';
    emit(state.copyWith(
      fileVersion: state.fileVersion + 1,
      clearError: true,
      connectionError: false,
    ));
  }

  void clearFile() {
    fileName = null;
    fileExtension = null;
    fileSize = null;
    fileBytes = null;
    fileBase64 = null;
    emit(state.copyWith(fileVersion: state.fileVersion + 1, clearError: true));
  }

  void setStartDate(Jalali? value) {
    if (value == null) return;
    startDateApi = _apiDate(value.toDateTime());
  }

  void setExpireDate(Jalali? value) {
    if (value == null) return;
    expireDateApi = _apiDate(value.toDateTime());
  }

  Future<void> submit(AgencyInfoEntity agency) async {
    if (state.isSubmitting) return;
    final agencyId = agency.id;
    if (agencyId == null) {
      emit(state.copyWith(errorMessage: 'شناسه نمایندگی معتبر نیست.'));
      return;
    }
    if (formKey.currentState?.validate() != true) return;

    emit(state.copyWith(
      isSubmitting: true,
      clearError: true,
      connectionError: false,
    ));

    final result = await _addContractUseCase(
      AddAgencyContractParamEntity(
        agencyId: agencyId,
        title: titleController.text.trim(),
        contractNo: contractNoController.text.trim(),
        startDate: startDateApi ?? '',
        expireDate: expireDateApi ?? '',
        fileBase64: fileBase64,
        fileType: _fileType(fileExtension),
      ),
    );

    result.when(
      success: (data, failures, resultCode) {
        emit(state.copyWith(isSubmitting: false, createdId: data));
      },
      failure: (error, failures) {
        emit(state.copyWith(
          isSubmitting: false,
          errorMessage: failures ?? 'ثبت قرارداد با خطا مواجه شد.',
        ));
      },
      expireToken: () {
        emit(state.copyWith(
          isSubmitting: false,
          errorMessage: 'نشست کاربری منقضی شده است.',
        ));
      },
      connectionError: () {
        emit(state.copyWith(isSubmitting: false, connectionError: true));
      },
    );
  }

  String? validateRequired(String? value) {
    return value?.trim().isNotEmpty == true ? null : 'این فیلد اجباری است';
  }

  String? validateFile() {
    return fileBase64?.trim().isNotEmpty == true
        ? null
        : 'انتخاب مستندات قرارداد اجباری است';
  }

  String fileSizeText() {
    final size = fileSize;
    if (size == null) return '';
    if (size < 1024 * 1024) {
      return '${(size / 1024).toStringAsFixed(0)} KB';
    }
    return '${(size / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  @override
  Future<void> close() {
    titleController.dispose();
    contractNoController.dispose();
    startDateController.dispose();
    expireDateController.dispose();
    return super.close();
  }

  String _apiDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  String _normalizeExtension(String? value) {
    return value?.trim().toLowerCase().replaceAll('.', '') ?? '';
  }

  String _fileType(String? extension) {
    final normalized = _normalizeExtension(extension);
    if (normalized == 'png' ||
        normalized == 'jpg' ||
        normalized == 'jpeg') {
      return 'image';
    }
    return normalized;
  }

  String _mimeType(String extension) {
    return switch (extension) {
      'png' => 'image/png',
      'jpg' || 'jpeg' => 'image/jpeg',
      'pdf' => 'application/pdf',
      'zip' => 'application/zip',
      _ => 'application/octet-stream',
    };
  }
}
