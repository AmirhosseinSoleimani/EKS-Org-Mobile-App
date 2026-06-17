import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/emdadgar_service_detail_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/evaluation_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/last_evaluation_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/aid_service_evaluation_submit_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/evaluation_selected_labor_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/services_and_labors_and_parts_evaluation_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/representation_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/controllers/evaluation_main_form_controller.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/cubit/evaluation_transport_Information_form_controller.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/enums/evaluation_service_category_view_type.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';

class AidServiceEvaluationSubmitParamBuilder {
  AidServiceEvaluationSubmitParamBuilder._();

  static AidServiceEvaluationSubmitParamEntity build({
    required ReliefRequestEntity? selectedRequest,
    required EmdadgarInfoEntity? emdadgarInfo,
    required ResponseLastEvaluationEntity? lastEvaluationEntity,
    required EmdadgarServiceDetailEntity? emdadgarServiceDetailEntity,
    required ServiceCategoryEntity? selectedServiceCategory,
    required EvaluationMainFormController mainForm,
    required EvaluationTransportInformationFormController<RepresentationEntity>
    transportForm,
    required List<EvaluationSelectedLaborEntity> selectedLabors,
    required DefectEntity? selectedDefect,
  }) {
    final isTransport =
        selectedServiceCategory?.evaluationViewType ==
        EvaluationServiceCategoryViewType.transport;

    return AidServiceEvaluationSubmitParamEntity(
      serviceRequestId: selectedRequest?.id,
      serviceType: selectedRequest?.serviceType?.value,
      emdadgarId: emdadgarInfo?.id,
      serviceCategoryId:
          selectedServiceCategory?.id ??
          emdadgarServiceDetailEntity?.serviceCategoryId,

      customerKilometer: int.tryParse(mainForm.kilometerController.text),
      distanceToCustomer: int.tryParse(
        mainForm.customerDistanceController.text,
      ),

      assignDate: JalaliDateHelper.formatServerDateTime(
        mainForm.assignDateTime,
      ),
      arriveDate: JalaliDateHelper.formatServerDateTime(
        mainForm.arriveDateTime,
      ),

      endWorkDate: isTransport
          ? JalaliDateHelper.formatServerDateTime(transportForm.endWorkDateTime)
          : null,

      /*    acceptanceCode: isTransport
          ? int.tryParse(transportForm.acceptanceCodeController.text.trim())
          : null,

      distanceHamlCustomer: isTransport
          ? int.tryParse(
        transportForm.transportDistanceController.text.trim(),
      )
          : null,

      representationId: isTransport
          ? int.tryParse(
        transportForm.selectedRepresentation.value?.value?.toString() ??
            '',
      )
          : null,*/
      confirmValidation: false,
      defectInfoId: selectedDefect?.id ?? selectedRequest?.defectId,
      description: mainForm.descriptionController.text.trim(),

      servicesAndLaborsAndPartsEvaluationPayload:
          ServicesAndLaborsAndPartsEvaluationEntity(
            evaluationServices: [
              _buildEvaluationServiceEntity(
                selectedRequest: selectedRequest,
                lastEvaluationEntity: lastEvaluationEntity,
                emdadgarServiceDetailEntity: emdadgarServiceDetailEntity,
                selectedServiceCategory: selectedServiceCategory,
                selectedLabors: selectedLabors,
                selectedDefect: selectedDefect,
              ),
            ],
          ),
    );
  }

  static EvaluationServiceEntity _buildEvaluationServiceEntity({
    required ReliefRequestEntity? selectedRequest,
    required ResponseLastEvaluationEntity? lastEvaluationEntity,
    required EmdadgarServiceDetailEntity? emdadgarServiceDetailEntity,
    required ServiceCategoryEntity? selectedServiceCategory,
    required List<EvaluationSelectedLaborEntity> selectedLabors,
    required DefectEntity? selectedDefect,
  }) {
    return EvaluationServiceEntity(
      serviceTypeId: selectedRequest?.serviceType?.value,
      serviceTypeTitle: selectedRequest?.serviceType?.label,
      serviceType: selectedRequest?.serviceType,

      serviceId: emdadgarServiceDetailEntity?.serviceId,
      serviceTitle: emdadgarServiceDetailEntity?.serviceTitle,
      serviceCode: emdadgarServiceDetailEntity?.serviceCode,

      serviceCategoryId:
          selectedServiceCategory?.id ??
          emdadgarServiceDetailEntity?.serviceCategoryId,
      serviceCategoryTitle:
          selectedServiceCategory?.title ??
          emdadgarServiceDetailEntity?.serviceCategoryTitle,
      serviceCategoryCode:
          selectedServiceCategory?.code ??
          emdadgarServiceDetailEntity?.serviceCategoryCode,
      defectInfoId: selectedDefect?.id ?? selectedRequest?.defectId,
      defectInfoTitle: emdadgarServiceDetailEntity?.defectInfoTitle,
      defectInfoProblemOrEzharCode:
          emdadgarServiceDetailEntity?.defectInfoProblemOrEzharCode,

      hasGaranty: emdadgarServiceDetailEntity?.hasGaranty ?? false,
      hasSubscription: emdadgarServiceDetailEntity?.hasSubscription ?? false,
      isSubscribedByNationalCode:
          emdadgarServiceDetailEntity?.isSubscribedByNationalCode ?? false,
      limitationDescription:
          emdadgarServiceDetailEntity?.limitationDescription ?? '',

      subscriptionId: lastEvaluationEntity
          ?.lastEvaluation
          ?.servicesAndLaborsAndPartsEvaluationPayload
          ?.evaluationServices
          ?.first
          .subscriptionId,

      evaluationLabors: selectedLabors,
    );
  }
}
