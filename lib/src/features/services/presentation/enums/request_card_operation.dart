import 'package:eks_sana_plus_org/src/common/constants/request_status.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_first_step/home_service_evaluation_first_step.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/assign_and_cancel_emdadgar_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/cancel_request_page/cancel_request_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/cartable_cycle_page/cartable_cycle_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/change_home_service_request_address_page/change_home_service_request_address_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/change_home_service_request_time_page/change_home_service_request_time_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/chassis_request_history_page/chassis_request_history_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/complete_urgent_request_page/complete_urgent_request_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/control_info_page/control_info_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/emdadgar_invoice_page/emdadgar_invoice_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/evaluation_aid_service_request_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_history/evaluation_history_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/followup_register_page/follow_up_register_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/non_cooperation_page/non_cooperation_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/online_map_page/online_map_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/request_detail_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_status_history_page/request_status_history_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/update_request_page/update_request_page.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/enums/invoice_type.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/presentation/pages/invoice_page.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/request_operation_access_entity.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum RequestCardOperation {
  requestDetail(
    label: 'جزئیات درخواست',
    icon: Symbols.search,
    color: Color(0xFF8a63e6),
    routeName: RequestDetailPage.name,
  ),
  nonCooperationList(
    label: 'لیست عدم همکاری',
    icon: Symbols.playlist_remove,
    color: Color(0xFFbf0000),
    routeName: NonCooperationPage.name,
  ),
  kartableCycle(
    label: 'چرخه کارتابل',
    icon: Symbols.all_inbox,
    color: Color(0xFFff9305),
    routeName: CartableCyclePage.name,
  ),
  requestStatusHistory(
    label: 'تاریخچه وضعیت درخواست',
    icon: Symbols.grading,
    color: Color(0xFF6d6a66),
    routeName: RequestStatusHistoryPage.name,
  ),
  onlineMap(
    label: 'نقشه آنلاین',
    icon: Symbols.map_search,
    color: Color(0xFF8b64e6),
    routeName: OnlineMapPage.name,
  ),
  requestControlInfo(
    label: 'اطلاعات کنترلی',
    icon: Symbols.apps,
    color: Color(0xFFffd000),
    routeName: ControlInfoPage.name,
  ),
  evaluationHistory(
    label: 'تاریخچه ارزیابی',
    icon: Symbols.view_timeline,
    color: Color(0xFF1bc4bc),
    routeName: EvaluationHistoryPage.name,
  ),
  chassisRequestHistory(
    label: 'تاریخچه بر اساس شماره شاسی',
    icon: Symbols.car_gear,
    color: Color(0xFF8a63e6),
    routeName: ChassisRequestHistoryPage.name,
  ),
  requestPreInvoice(
    label: 'پیش فاکتور',
    icon: Symbols.description,
    color: Color(0xFFff9305),
    routeName: InvoicePage.name,
    invoiceType: InvoiceType.preInvoice,
  ),
  customerInvoice(
    label: 'فاکتور مشتری',
    icon: Symbols.description,
    color: Color(0xFFff7a0c),
    routeName: InvoicePage.name,
    invoiceType: InvoiceType.invoice,
  ),
  emdadgarInvoice(
    label: 'صورت وضعیت',
    icon: Symbols.description,
    color: Color(0xFF3eb021),
    routeName: EmdadgarInvoicePage.name,
  ),
  updateRequest(
    label: 'ویرایش درخواست',
    icon: Symbols.edit,
    color: Color(0xFF369aff),
    routeName: UpdateRequestPage.name,
  ),
  cancelRequest(
    label: 'لغو درخواست',
    icon: Symbols.close,
    color: Color(0xFFC30000),
    routeName: CancelRequestPage.name,
  ),
  completeUrgentRequest(
    label: 'تکمیل درخواست اضطراری',
    icon: Symbols.open_in_new,
    color: Color(0xFFC30000),
    routeName: CompleteUrgentRequestPage.name,
  ),
  changeHomeServiceRequestTime(
    label: 'ویرایش زمان درخواست',
    icon: Symbols.access_time,
    color: Color(0xFFff9b00),
    routeName: ChangeHomeServiceRequestTimePage.name,
  ),
  changeHomeServiceRequestAddress(
    label: 'ویرایش آدرس درخواست',
    icon: Symbols.location_on,
    color: Color(0xFF1bc5bd),
    routeName: ChangeHomeServiceRequestAddressPage.name,
  ),
  followUpRegister(
    label: 'ثبت پیگیری',
    icon: Symbols.north_east,
    color: Color(0xFF864a1e),
    routeName: FollowUpRegisterPage.name,
  ),
  aidServiceFactorRegister(
    label: 'ثبت فاکتور',
    icon: Symbols.insert_drive_file,
    color: Color(0xFF3699FF),
    routeName: EvaluationAidServiceRequestPage.name,
  ),
  homeServiceFactorRegister(
    label: 'ثبت فاکتور',
    icon: Symbols.insert_drive_file,
    color: Color(0xFF3699FF),
    routeName: HomeServiceEvaluationFirstStep.name,
  ),
  assignEmdadgar(
    label: 'تخصیص',
    icon: Symbols.person_add_alt,
    color: Color(0xFF3eb122),
    routeName: AssignAndCancelEmdadgarPage.name,
  ),
  cancelEmdadgar(
    label: 'لغو توسط امدادرسان',
    icon: Symbols.person_cancel,
    color: Color(0xFFC30000),
    routeName: AssignAndCancelEmdadgarPage.name,
  ),

  // TODO: Implement the mobile Technical Report History page/flow.
  technicalReportHistory(
    label: 'تاریخچه گزارش فنی مهندسی',
    icon: Icons.list_alt, // Web: fa-list-alt
    color: Color(0xFFE9408F),
  ),

  // TODO: Implement the mobile incomplete-request completion flow.
  completeIncompleteRequest(
    label: 'بررسی و تکمیل درخواست',
    icon: Icons.open_in_new, // Web: fa-external-link-alt
    color: Color(0xFF3699FF),
  ),

  // TODO: Implement the mobile invoice modification/approval flow.
  invoiceModification(
    label: 'اصلاح و تایید فاکتور',
    icon: Icons.edit, // Web: fa-pencil-alt
    color: Color(0xFF3699FF),
  ),

  // TODO: Implement the mobile request-copy/recovery flow.
  serviceRequestCopy(
    label: 'کپی درخواست',
    icon: Icons.add, // Web: fa-plus
    color: Color(0xFF1BC5BD),
  ),

  // TODO: Implement the mobile external-fleet assistance permission flow.
  externalEmdadNavgan(
    label: 'مجوز امداد خارج از ناوگان',
    icon: Icons.directions_car, // Web: fa-car
    color: Color(0xFFC30000),
  ),

  // TODO: Implement the mobile cancel-external-fleet assistance flow.
  cancelExternalEmdadNavgan(
    label: 'لغو امداد خارج از ناوگان',
    icon: Icons.close, // Web: fa-times
    color: Color(0xFFC30000),
  ),

  // TODO: Implement the mobile assignment/dispatch history page/flow.
  assignDispatchHistory(
    label: 'تاریخچه تخصیص/اعزام',
    icon: Icons.person, // Web: fa-male
    color: Color(0xFF6D6A66),
  ),

  // TODO: Implement the mobile sent-SMS history page/flow.
  smsHistory(
    label: 'تاریخچه پیامک های ارسالی',
    icon: Icons.chat, // Web: fa-comments
    color: Color(0xFF6D6A66),
  ),

  // TODO: Implement the mobile request-images page/flow.
  requestImages(
    label: 'تصاویر',
    icon: Icons.image, // Web: fa-image
    color: Color(0xFF3699FF),
  ),

  // TODO: Implement Aid Service rollback/open-request + invoice-cancel flow.
  aidRollbackInvoice(
    label: 'بازکردن درخواست / لغو فاکتور',
    icon: Icons.undo, // Web Aid: fa-undo
    color: Color(0xFF6D6A66),
  ),

  // TODO: Implement Home Service rollback/open-request + invoice-cancel flow.
  homeRollbackInvoice(
    label: 'بازکردن درخواست / لغو فاکتور',
    icon: Icons.access_time, // Web Home: fa-clock
    color: Color(0xFF6D6A66),
  );

  final String label;
  final IconData icon;
  final Color color;
  final String? routeName;
  final InvoiceType? invoiceType;

  const RequestCardOperation({
    required this.label,
    required this.icon,
    required this.color,
    this.routeName,
    this.invoiceType,
  });

  bool get isImplemented => routeName != null;

  Object? routeExtra(int? requestId) => invoiceType ?? requestId;
}

extension OperationItemVisibility on RequestCardOperation {
  bool isVisible(
    BaseRequestEntity request,
    RequestOperationAccessEntity operationAccess,
  ) {
    final status = RequestStatus.fromValue(request.requestStatus);
    final rawStatus = request.requestStatus;
    final type = request.serviceType;
    final isRelief = type == ServiceType.reliefService;
    final isHome = type == ServiceType.homeService;
    final hasInvoiceDocument = request.invoiceDocumentGuid?.trim().isNotEmpty == true;

    switch (this) {
      case RequestCardOperation.requestDetail:
        return isRelief
            ? operationAccess.canView
            : isHome && operationAccess.canView;

      case RequestCardOperation.nonCooperationList:
        if (rawStatus == null || rawStatus < 1 || rawStatus > 9) return false;
        return isRelief
            ? operationAccess.lackOfCooperation
            : isHome && operationAccess.lackOfCooperation;

      case RequestCardOperation.kartableCycle:
        return isRelief
            ? operationAccess.cartableCycle
            : isHome && operationAccess.cartableCycle;

      case RequestCardOperation.requestStatusHistory:
        return isRelief
            ? operationAccess.canView
            : isHome && operationAccess.canView;

      case RequestCardOperation.onlineMap:
        if (isRelief) {
          return (rawStatus ?? 0) > RequestStatus.canceled.value ||
              request.cancelReasonId != null;
        }
        return isHome &&
            (status == RequestStatus.dispatched ||
                status == RequestStatus.canceled);

      case RequestCardOperation.requestControlInfo:
        return (rawStatus ?? 0) > RequestStatus.waitingAssignment.value;

      case RequestCardOperation.evaluationHistory:
        return isRelief
            ? operationAccess.evaluationHistory
            : isHome && operationAccess.evaluationHistory;

      case RequestCardOperation.chassisRequestHistory:
        return true;

      case RequestCardOperation.requestPreInvoice:
        return isHome && operationAccess.customerInvoice;

      case RequestCardOperation.customerInvoice:
        if (!hasInvoiceDocument ||
            (status != RequestStatus.canceled && status != RequestStatus.closed)) {
          return false;
        }
        return isRelief
            ? operationAccess.customerInvoice
            : isHome && operationAccess.customerInvoice;

      case RequestCardOperation.emdadgarInvoice:
        if (!hasInvoiceDocument ||
            (status != RequestStatus.canceled && status != RequestStatus.closed)) {
          return false;
        }
        return isRelief
            ? operationAccess.emdadgarInvoice
            : isHome && operationAccess.emdadgarInvoice;

      case RequestCardOperation.updateRequest:
        return isRelief &&
            status != RequestStatus.canceled &&
            status != RequestStatus.closed;

      case RequestCardOperation.cancelRequest:
        if (isRelief) {
          if (rawStatus == null || rawStatus == RequestStatus.closed.value) {
            return false;
          }
          if (rawStatus < RequestStatus.canceled.value) {
            return operationAccess.cancelBeforeAssign;
          }
          if (rawStatus > RequestStatus.canceled.value) {
            return operationAccess.cancelAfterAssign;
          }
          return false;
        }
        return isHome &&
            status != RequestStatus.canceled &&
            status != RequestStatus.closed &&
            operationAccess.cancel;

      case RequestCardOperation.completeUrgentRequest:
        return request is ReliefRequestEntity &&
            (request.isUrgentRequest ?? false) &&
            !(request.isUrgentRequestCompleted ?? false) &&
            operationAccess.urgentServiceRequestCompleted;

      case RequestCardOperation.changeHomeServiceRequestTime:
        return isHome &&
            operationAccess.canUpdate &&
            (status == RequestStatus.waitingAssignment ||
                status == RequestStatus.reserved);

      case RequestCardOperation.changeHomeServiceRequestAddress:
        return isHome &&
            operationAccess.canUpdate &&
            status == RequestStatus.waitingAssignment;

      case RequestCardOperation.followUpRegister:
        if (isRelief) {
          return rawStatus != null &&
              rawStatus >= RequestStatus.dispatched.value &&
              rawStatus < RequestStatus.closed.value &&
              (request.addressHasBeenSet ?? false) &&
              operationAccess.followUp;
        }
        return isHome &&
            ((operationAccess.followUp &&
                    rawStatus != null &&
                    rawStatus >= RequestStatus.dispatched.value &&
                    rawStatus <= RequestStatus.completed.value) ||
                status == RequestStatus.reserved);

      case RequestCardOperation.aidServiceFactorRegister:
        return isRelief &&
            status == RequestStatus.completed &&
            operationAccess.invoiceRegistration;

      case RequestCardOperation.homeServiceFactorRegister:
        return isHome &&
            status == RequestStatus.completed &&
            operationAccess.invoiceRegistration;

      case RequestCardOperation.assignEmdadgar:
        if (isRelief) {
          return status == RequestStatus.waitingAssignment &&
              (request.addressHasBeenSet ?? false) &&
              operationAccess.assign;
        }
        return isHome &&
            (status == RequestStatus.waitingAssignment ||
                status == RequestStatus.reserved) &&
            operationAccess.assign;

      case RequestCardOperation.cancelEmdadgar:
        if (isRelief) {
          return rawStatus != null &&
              rawStatus >= RequestStatus.dispatched.value &&
              rawStatus <= RequestStatus.inProgress.value &&
              operationAccess.assignCancel;
        }
        return isHome &&
            (status == RequestStatus.reserved ||
                (rawStatus != null &&
                    rawStatus >= RequestStatus.dispatched.value &&
                    rawStatus <= RequestStatus.inProgress.value)) &&
            operationAccess.assignCancel;

      case RequestCardOperation.technicalReportHistory:
        return isRelief &&
            (status == RequestStatus.canceled || status == RequestStatus.closed);

      case RequestCardOperation.completeIncompleteRequest:
        return isRelief && rawStatus == RequestStatus.waitingForDetails.value;

      case RequestCardOperation.invoiceModification:
        return isRelief &&
            status == RequestStatus.closed &&
            request.requestState != 1 &&
            operationAccess.invoiceModification;

      case RequestCardOperation.serviceRequestCopy:
        if (!operationAccess.serviceRequestCopy) return false;
        return (isRelief || isHome) &&
            (status == RequestStatus.canceled || status == RequestStatus.closed);

      case RequestCardOperation.externalEmdadNavgan:
        return isRelief &&
            (request.hamlAzad ?? false) &&
            status == RequestStatus.waitingAssignment &&
            operationAccess.externalEmdadNavgan;

      case RequestCardOperation.cancelExternalEmdadNavgan:
        return isRelief &&
            (request.hamlAzad ?? false) &&
            request.reasonHamlAzadId != null &&
            status != RequestStatus.canceled &&
            status != RequestStatus.completed &&
            operationAccess.cancelExternalEmdadNavgan;

      case RequestCardOperation.assignDispatchHistory:
        return (isRelief || isHome) && operationAccess.viewAssignHistory;

      case RequestCardOperation.smsHistory:
        return (isRelief || isHome) && operationAccess.smsHistory;

      case RequestCardOperation.requestImages:
        return (isRelief || isHome) && (request.hasDocuments ?? false);

      case RequestCardOperation.aidRollbackInvoice:
        return isRelief &&
            (status == RequestStatus.closed || request.cancelReasonId != null) &&
            operationAccess.invoiceCancel;

      case RequestCardOperation.homeRollbackInvoice:
        return isHome &&
            (status == RequestStatus.closed || status == RequestStatus.canceled) &&
            operationAccess.invoiceCancel;
    }
  }
}
