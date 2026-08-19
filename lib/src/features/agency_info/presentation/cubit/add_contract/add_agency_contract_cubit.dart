import 'dart:typed_data';

import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/add_agency_contract_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/add_agency_contract_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/add_contract/add_agency_contract_state.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/features/upload_file/domain/entities/uploaded_file_entity.dart';
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

  void setFile(UploadedFileEntity? file) {
    fileName = file?.name;
    fileExtension = file?.extension;
    fileSize = file?.size;
    fileBytes = file?.bytes;
    fileBase64 = file?.dataUri;
    emit(state.copyWith(clearError: true, connectionError: false));
  }

  void setStartDate(Jalali? value) {
    if (value == null) return;
    startDateApi = JalaliDateHelper.formatServerDateOnly(value.toDateTime());
  }

  void setExpireDate(Jalali? value) {
    if (value == null) return;
    expireDateApi = JalaliDateHelper.formatServerDateOnly(value.toDateTime());
  }

  Future<void> submit(AgencyInfoEntity agency) async {
    if (state.isSubmitting) return;
    final agencyId = agency.id;
    if (agencyId == null) {
      emit(state.copyWith(errorMessage: 'شناسه نمایندگی معتبر نیست.'));
      return;
    }
    if (formKey.currentState?.validate() != true) return;

    emit(
      state.copyWith(
        isSubmitting: true,
        clearError: true,
        connectionError: false,
      ),
    );

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
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: failures ?? 'ثبت قرارداد با خطا مواجه شد.',
          ),
        );
      },
      expireToken: () {
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: 'نشست کاربری منقضی شده است.',
          ),
        );
      },
      connectionError: () {
        emit(state.copyWith(isSubmitting: false, connectionError: true));
      },
    );
  }

  String? validateRequired(String? value) {
    return value?.trim().isNotEmpty == true ? null : 'این فیلد اجباری است';
  }

  @override
  Future<void> close() {
    titleController.dispose();
    contractNoController.dispose();
    startDateController.dispose();
    expireDateController.dispose();
    return super.close();
  }

  String _fileType(String? extension) {
    final normalized = extension?.trim().toLowerCase().replaceAll('.', '') ?? '';
    if (normalized == 'png' ||
        normalized == 'jpg' ||
        normalized == 'jpeg') {
      return 'image';
    }
    return normalized;
  }
}
