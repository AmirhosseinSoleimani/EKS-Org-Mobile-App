import 'package:eks_sana_plus_org/src/common/constants/emdadgar_status.dart';
import 'package:eks_sana_plus_org/src/common/constants/request_status.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/cubit/assign_and_cancel_emdadgar_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/widgets/assign_and_non_cooperation_buttons.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/widgets/cancel_mission_button.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/resources/color_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmdadgarItem extends StatelessWidget {
  final EmdadgarEntity entity;

  const EmdadgarItem({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AssignAndCancelEmdadgarCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    final brief = entity.emdadgars?.isNotEmpty == true
        ? entity.emdadgars!.first
        : null;

    final requestStatus = RequestStatus.fromValue(
        cubit.selectedRequest?.requestStatus);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface.withAlpha(90),
        border: Border.all(color: isEmdadgarAssigned(requestStatus)
            ? colorScheme.onError
            : colorScheme.onInverseSurface),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, brief, colorScheme),
          Space.h12,
          _buildInfoRows(colorScheme),
          Space.h16,
          _buildActions(context, cubit),
        ],
      ),
    );
  }

  // بخش هدر آیتم
  Widget _buildHeader(BuildContext context, dynamic brief,
      ColorScheme colorScheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleLargeText(text: brief?.aidPerName ?? ""),
              Space.h16,
              StatusLabel(
                text: entity.statusTitle ?? '',
                fontSize: 12,
                backgroundColor: const Color(0xFFfff8e1),
                color: (entity.status == 1)
                    ? colorScheme.onError
                    : Color(0xFFc8a763),
              ),
            ],
          ),
        ),
        Container(
          width: 36,
          height: 36,
          margin: EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorLightManager.success,
          ),
          child: TitleLargeText(
            text: "${entity.priority ?? 0}",
            color: colorScheme.onError,
          ),
        ),
      ],
    );
  }

  // ردیف‌های اطلاعاتی (لوکیشن و خودرو)
  Widget _buildInfoRows(ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.location_on, size: 18, color: colorScheme.outline),
            Space.w8,
            BodyMediumText(
              text: '${entity.ostanNamayandegiText ?? ""}، ${entity
                  .shahrNamayandegiText ?? ""}',
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(Icons.local_shipping, size: 18, color: colorScheme.outline),
            const SizedBox(width: 6),
            Expanded(child: BodyMediumText(text: entity.khodroTypeText ?? "")),
          ],
        ),
        const SizedBox(height: 6),
        BodyMediumText(text: "نمایندگی: ${entity.agencyName ?? ""}",
          textAlign: TextAlign.start,),
      ],
    );
  }

  Widget _buildActions(BuildContext context,
      AssignAndCancelEmdadgarCubit cubit) {
    final requestStatus = RequestStatus.fromValue(
        cubit.selectedRequest?.requestStatus); 

    if (entity.status == EmdadgarStatus.available.value ||
        requestStatus != RequestStatus.completed) {
      return AssignAndNonCooperationButtons(entity: entity);
    }
    final bool canCancel = isEmdadgarAssigned(requestStatus);
    if (canCancel) {
      return CancelMissionButton(entity: entity);
    }

    return const SizedBox.shrink();
  }

  bool isEmdadgarAssigned(RequestStatus requestStatus) =>
      [3, 4, 5].contains(requestStatus.value);
}
