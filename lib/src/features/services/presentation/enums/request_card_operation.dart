import 'package:eks_sana_plus_org/src/common/constants/request_status.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/cancel_request_page/cancel_request_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/cartable_cycle_page/cartable_cycle_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/chassis_request_history_page/chassis_request_history_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/complete_urgent_request_page/complete_urgent_request_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/control_info_page/control_info_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/emdadgar_invoice_page/emdadgar_invoice_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_history/evaluation_history_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/non_cooperation_page/non_cooperation_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/online_map_page/online_map_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/pre_invoice_page/pre_invoice_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/request_detail_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_status_history_page/request_status_history_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/update_request_page/update_request_page.dart';
import 'package:flutter/material.dart';


enum RequestCardOperation {
  requestDetail(
    label: 'جزئیات درخواست',
    icon: Icons.search,
    color: Color(0xFF8a63e6),
    route: RequestDetailPage.path,
  ),
  nonCooperationList(
    label: 'لیست عدم همکاری',
    icon: Icons.menu,
    color: Color(0xFFbf0000),
    route: NonCooperationPage.path,
  ),
  kartableCycle(
    label: 'چرخه کارتابل',
    icon: Icons.repeat,
    color: Color(0xFFff9305),
    route: CartableCyclePage.path,
  ),
  requestStatusHistory(
    label: 'تاریخچه وضعیت',
    icon: Icons.history,
    color: Color(0xFF6d6a66),
    route: RequestStatusHistoryPage.path,
  ),
  onlineMap(
    label: 'نقشه آنلاین',
    icon: Icons.map,
    color: Color(0xFF8b64e6),
    route: OnlineMapPage.path,
  ),
  requestControlInfo(
    label: 'اطلاعات کنترلی',
    icon: Icons.apps,
    color: Color(0xFFffd000),
    route: ControlInfoPage.path,
  ),
  evaluationHistory(
    label: 'تاریخچه ارزیابی',
    icon: Icons.calendar_today_outlined,
    color: Color(0xFF1bc4bc),
    route: EvaluationHistoryPage.path,
  ),
  chassisRequestHistory(
    label: 'تاریخچه درخواست شاسی',
    icon: Icons.car_crash,
    color: Color(0xFF8a63e6),
    route: ChassisRequestHistoryPage.path,
  ),
  requestPreInvoice(
    label: 'پیش فاکتور',
    icon: Icons.description,
    color: Color(0xFFff9305),
    route: PreInvoicePage.path,
  ),

  emdadgarInvoice(
    label: 'صورت وضعیت',
    icon: Icons.description,
    color: Color(0xFF3eb021),
    route: EmdadgarInvoicePage.path,
  ),

  updateRequest(
  label: 'ویرایش درخواست',
  icon: Icons.edit,
  color: Color(0xFF369aff),
  route: UpdateRequestPage.path,
  ),
  cancelRequest(
    label: 'لغو درخواست',
    icon: Icons.close,
    color: Color(0xFFbf0000),
    route: CancelRequestPage.path,
  ),
  completeUrgentRequest(
    label: 'تکلیم درخواست اضظراری',
    icon: Icons.open_in_new,
    color: Color(0xFFbf0000),
    route: CompleteUrgentRequestPage.path,
  );

  final String label;
  final IconData icon;
  final Color color;
  final String route;

  const RequestCardOperation({
    required this.label,
    required this.icon,
    required this.color,
    required this.route,
  });
}

extension OperationItemVisibility on RequestCardOperation {
  bool isVisible(BaseRequestEntity request) {
    final status = RequestStatus.fromValue(request.requestStatus);
    final type = request.serviceType;

    switch (this) {
      case RequestCardOperation.emdadgarInvoice:
        return status == RequestStatus.closed;

      case RequestCardOperation.requestPreInvoice:
        if (type == ServiceType.reliefService) {
          return status == RequestStatus.closed;
        }
        if (type == ServiceType.homeService) {
          return true;
        }

        return false;

      case RequestCardOperation.updateRequest:
        if(type == ServiceType.reliefService){
          return true;
        }
        return false;
      case RequestCardOperation.cancelRequest:
        if (status != RequestStatus.closed) {
          return true;
        }
        return false;
      case RequestCardOperation.completeUrgentRequest:
       return request is ReliefRequestEntity && (request.isUrgentRequest ?? false);

      default:
        return true;
    }
  }
}
