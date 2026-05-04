import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_aid_services_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_defects_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/update_service_request_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/usecase/get_location_data_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/usecase/get_province_with_city_list_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_request_cubit.freezed.dart';

part 'update_request_state.dart';

class UpdateRequestCubit extends Cubit<UpdateRequestState> {
  UpdateRequestCubit(
    this._fetchSelectedRequestItemUseCase,
    this._getReliefRequestByIdUseCase,
    this._getEmdadgarInfoUseCase,
    this._getProvinceWithCityListUseCase,
    this._getLocationDataUseCase,
    this._getDefectsListUseCase,
    this._getAidServicesListUseCase,
    this._updateServiceRequestUseCase,
  ) : super(const UpdateRequestState.idle());

  final formKey = GlobalKey<FormState>();
  final validationNotifier = ValueNotifier<bool>(false);

  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetEmdadgarInfoUseCase _getEmdadgarInfoUseCase;
  final GetProvinceWithCityListUseCase _getProvinceWithCityListUseCase;
  final GetLocationDataUseCase _getLocationDataUseCase;
  final GetDefectsListUseCase _getDefectsListUseCase;
  final GetAidServicesListUseCase _getAidServicesListUseCase;
  final UpdateServiceRequestUseCase _updateServiceRequestUseCase;

  final TextEditingController licensePlateController = TextEditingController();
  final TextEditingController clientPhoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  BaseRequestEntity? selectedRequest;
  EmdadgarInfoEntity? emdadgarInfo;
  List<ProvinceEntity> provinceList = <ProvinceEntity>[];
  List<DefectEntity> defectList = <DefectEntity>[];
  ServiceResponseEntity? serviceResponseEntity;

  void init() {}
  void submit() {}
}
