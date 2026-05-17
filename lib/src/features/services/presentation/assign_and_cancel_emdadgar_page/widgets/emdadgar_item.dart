import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/cubit/assign_and_cancel_emdadgar_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/widgets/non_cooperation_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/resources/color_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
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

    final daily = brief?.report?.daily;
    final weekly = brief?.report?.weekly;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface.withAlpha(150),
        border: Border.all(color: colorScheme.onInverseSurface),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                      backgroundColor: Color(0xFFfff8e1),
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
          ),

          Space.h12,

          Row(
            children: [
              Icon(Icons.location_on,size: 18, color: colorScheme.outline),
              Space.w8,
              BodyMediumText(
                text:
                    '${entity.ostanNamayandegiText ?? ""}، ${entity.shahrNamayandegiText ?? ""}',
              ),
            ],
          ),

          const SizedBox(height: 6),

          Row(
            children: [
               Icon(Icons.local_shipping, size: 18,color: colorScheme.outline),
              const SizedBox(width: 6),
              Expanded(child:   BodyMediumText(text: entity.khodroTypeText ?? "")),
            ],
          ),

          const SizedBox(height: 6),
          BodyMediumText(text: "نمایندگی: ${entity.agencyName ?? ""}"),
          const SizedBox(height: 4),
          BodyMediumText(text:  "فاصله: ${entity.distanceKmToOrigin?.toStringAsFixed(1) ?? ""} کیلومتر | زمان:"),

          const SizedBox(height: 6),

          BodyMediumText(text:
            "ماموریت امروز: ${daily?.successCount ?? 0} | هفته اخیر: ${weekly?.successCount ?? 0}",
          ),

          Space.h16,
          Row(
            children: [
              Expanded(
                child: BlocBuilder<
                    AssignAndCancelEmdadgarCubit,
                    AssignAndCancelEmdadgarState>(
                  builder: (context, state) {
                    final cubit = context.read<AssignAndCancelEmdadgarCubit>();

                    final loadingId = state.maybeWhen(
                      checkDepotLoading: (id) => id,
                      orElse: () => null,
                    );

                    final isThisItemLoading = loadingId == entity.id;
                    final isAnotherItemLoading = loadingId != null &&
                        loadingId != entity.id;

                    return InkwellButtonWidget(
                      height: 40,
                      showLoading: isThisItemLoading,
                      backgroundColor: cubit.selectedRequest?.serviceType
                          ?.serviceColor,
                      onTap: isAnotherItemLoading
                          ? (){}
                          : () {
                        cubit.setSelectedEmdadgar(entity);
                        cubit.checkDepotAndOpen(entity);
                      },
                      title: "تخصیص",
                      textStyle:  Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontSize: 15),
                    );
                  },
                )
                ,
              ),
              const SizedBox(width: 12),
              Expanded(

                child: InkwellButtonWidget(
                  height: 40,
                  backgroundColor: Colors.transparent,
                  borderColor: Color(0xFFf6c972),
                  textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(color: Color(0xFFae8129), fontSize: 15),
                  title: "عدم همکاری",
                  onTap: () {
                    cubit.setSelectedEmdadgar(entity);
                    showNonCooperationBottomSheet(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
