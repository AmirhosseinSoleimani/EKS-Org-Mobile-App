import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/cartable_cycle_page/cartable_cycle_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/chassis_request_history_page/chassis_request_history_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/control_info_page/control_info_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_history/evaluation_history_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/non_cooperation_page/non_cooperation_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/pre_invoice_page/pre_invoice_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_status_history_page/request_status_history_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OperationMenu extends StatelessWidget {
  final BaseRequestEntity request;
  final Function(BaseRequestEntity) onSelected;

  const OperationMenu({
    super.key,
    required this.request,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<OperationItem>(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onSelected: (item) {
        onSelected(request);
        context.push(item.route, extra: request.id);
      },
      itemBuilder: (context) {
        return OperationItem.values.map((item) {
          return PopupMenuItem(
            value: item,
            child: Text(item.label),
          );
        }).toList();
      },
      child: Row(
        children: [
          const Icon(Icons.more_vert, size: 22),
          const SizedBox(width: 6),
          Text(
            "عملیات",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}


enum OperationItem {
  requestStatusHistory(
    label: 'تاریخچه وضعیت درخواست',
    route: RequestStatusHistoryPage.path,
  ),
  kartableCycle(
    label: 'چرخه کارتابل',
    route: CartableCyclePage.path,
  ),
  nonCooperationList(
    label: 'لیست عدم همکاری',
    route: NonCooperationPage.path,
  ),
  chassisRequestHistory(
    label: 'تاریخچه درخواست شاسی',
    route: ChassisRequestHistoryPage.path,
  ),
  requestControlInfo(
    label: 'اطلاعات کنترلی',
    route: ControlInfoPage.path,
  ),
  requestPreInvoice(
    label: 'مشاهده پیش فاکتور',
    route: PreInvoicePage.path,
  ),
  evaluationHistory(
    label: 'تاریخچه ارزیابی',
    route: EvaluationHistoryPage.path,
  );

  final String label;
  final String route;

  const OperationItem({
    required this.label,
    required this.route,
  });
}
