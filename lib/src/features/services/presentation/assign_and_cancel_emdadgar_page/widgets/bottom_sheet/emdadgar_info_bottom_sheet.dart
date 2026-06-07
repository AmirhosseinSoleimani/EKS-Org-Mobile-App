import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/check_depot_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/cubit/assign_and_cancel_emdadgar_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/bottom_sheet/service_action_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/widgets/emdadgar_info_item.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/widgets/emdadgar_report_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/submit_cancel_buttons.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/online_route_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
Future<void> showEmdadgarInfoBottomSheet(BuildContext context) async {
  final cubit = context.read<AssignAndCancelEmdadgarCubit>();

  await showServiceActionBottomSheet(
    context: context,
    cubit: cubit,
    title: 'اطلاعات امداد رسان',
    contentBuilder: (context) {
      return EmdadgarInfoBottomForm(
        entity: cubit.selectedEmdadgar!,
        depotEntity: cubit.checkDepotEntity,
      );
    },
    actionsBuilder: (context) {
      return SubmitCancelButtons(
        submitButtonColor:
            cubit.selectedRequest?.serviceType?.serviceColor ??
            ServiceType.reliefService.serviceColor,
        submitTitle: 'تخصیص',
        onCancel: () => context.pop(),
        onSubmit: () {
          context.pop();
          cubit.showAssignConfirmBottomSheet();
        },
      );
    },
  );
}

class EmdadgarInfoBottomForm extends StatelessWidget {
  final EmdadgarEntity entity;
  final CheckDepotEntity? depotEntity;
  final RouteEntity? routeEntity;

  const EmdadgarInfoBottomForm({
    super.key,
    required this.entity,
    this.depotEntity,
    this.routeEntity,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final brief = entity.emdadgars?.isNotEmpty == true
        ? entity.emdadgars!.first
        : null;

    final report = brief?.report;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatusLabel(
          fontWeight: FontWeight.w700,
          padding: EdgeInsets.all(10),
          width: double.infinity,
          text: entity.statusTitle ?? '',
          fontSize: 14,
          borderRadius: 6,
          textAlign: TextAlign.start,

          color: Color(0xFF2f80ed),
        ),
        Space.h8,
        StatusLabel(
          fontWeight: FontWeight.w700,
          padding: EdgeInsets.all(10),
          width: double.infinity,
          text: (entity.inShift ?? false)
              ? 'داخل شیفت کاری می باشد'
              : 'داخل شیفت کاری نمی باشد',
          fontSize: 14,
          borderRadius: 6,
          textAlign: TextAlign.start,

          color: (entity.inShift ?? false)
              ? colorScheme.onError
              : colorScheme.error,
        ),
        Space.h8,
        StatusLabel(
          fontWeight: FontWeight.w700,
          padding: EdgeInsets.all(10),
          fontSize: 14,
          borderRadius: 6,
          textAlign: TextAlign.start,
          width: double.infinity,
          text: (depotEntity?.launchDepotIsEnable ?? false)
              ? 'بررسی انبارک امدادرسان‌ جهت اعزام، فعال است'
              : 'بررسی انبارک امدادرسان‌ جهت اعزام، غیر فعال است',

          color: Color(0xFFa9791c),
          backgroundColor: Color(0xFFfff8e1),
        ),
        Space.h16,
        EmdadgarInfoItem(entity: entity, routeEntity: routeEntity),
        Space.h16,
        TitleLargeText(text: 'عملکرد', fontSize: 15),
        Space.h8,
        EmdadgarReportSection(report: report),
      ],
    );
  }
}
