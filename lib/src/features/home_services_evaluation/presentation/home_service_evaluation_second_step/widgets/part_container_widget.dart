import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/common/utils/extensions/string_ext.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/cubit/home_service_evaluation_second_step_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/widgets/edit_and_registration_part_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/amount_row/amount_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/delete_confirm_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PartContainerWidget extends StatelessWidget {
  const PartContainerWidget({
    super.key,
    required this.entity,
    this.serviceIndex,
    this.laborIndex,
    this.partIndex,
    this.isEditablePart,
  });

  final EvaluationPartResponseEntity entity;
  final int? serviceIndex;
  final int? laborIndex;
  final int? partIndex;
  final bool? isEditablePart;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.only(right: 12, left: 12, top: 12, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: colorScheme.inverseSurface),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        children: [
          // ================= HEADER =================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'نام قطعه: ${entity.partName ?? '-'}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Space.w4,
                    Text(
                      (entity.isReusable == true) ? '(داغی دارد)' : '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Space.w4,

              (isEditablePart ?? false)
                  ? Row(
                      children: [
                        /// EDIT
                        InkWell(
                          onTap: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => EditAndRegistrationPartWidget(
                                  evaluationPartEntity: entity,
                                  serviceIndex: serviceIndex ?? 0,
                                  laborIndex: laborIndex ?? 0,
                                  partIndex: partIndex ?? 0,
                                  isEditablePart: isEditablePart,
                                  partCustomerIndex: partIndex ?? 0,
                                ),
                              ),
                            );

                            if (context.mounted) {
                              context
                                  .read<HomeServiceEvaluationSecondStepCubit>()
                                  .refresh();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                width: 1,
                                color: colorScheme.inverseSurface,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.edit,
                                size: 20,
                                color: colorScheme.inverseSurface,
                              ),
                            ),
                          ),
                        ),

                        Space.w4,

                        /// DELETE (BOTTOM SHEET)
                        InkWell(
                          onTap: () {
                            _showDeleteBottomSheet(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                width: 1,
                                color: colorScheme.inverseSurface,
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.delete,
                                size: 20,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : InkWell(
                      onTap: () {
                        _showDeleteBottomSheet(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: colorScheme.inverseSurface,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.delete,
                            size: 20,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
            ],
          ),

          Space.h16,

          // ================= INFO =================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'مارک: ${entity.mark}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'تعداد: ${entity.count.toString().convertNumberWithLanguage()}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Flexible(
                child: AmountRow(
                  label: 'قیمت واحد',
                  amount: entity.partPrice,
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  valueStyle: Theme.of(context).textTheme.bodyMedium,
                  fitValue: true,
                ),
              ),
            ],
          ),

          Divider(thickness: 2, color: colorScheme.tertiary),

          Space.h8,

          // ================= TOTAL =================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AmountRow(
                  label: 'قیمت کل',
                  amount: (entity.partPrice ?? 0) * (entity.count ?? 0),
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  valueStyle: Theme.of(context).textTheme.bodyMedium,
                  fitValue: true,
                ),
              ),
              Text(
                entity.costCenterObject?.name ?? '',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: (entity.costCenterObject?.id == 0)
                      ? ServiceType.homeService.serviceColor
                      : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Space.h8,
        ],
      ),
    );
  }

  // ================= BOTTOM SHEET =================

  void _showDeleteBottomSheet(BuildContext context) {
    DeleteConfirmSheet.show(
      context: context,
      title: 'حذف قطعه',
      message: 'آیا از حذف این قطعه اطمینان دارید؟',
      confirmTitle: 'حذف',
      onConfirm: () async {
        _handleDelete(context);
      },
    );
  }

  void _handleDelete(BuildContext context) {
    final cubit = context.read<HomeServiceEvaluationSecondStepCubit>();

    if (isEditablePart ?? false) {
      HomeServiceEvaluationSecondStepCubit
          .customerServiceList?[serviceIndex ?? 0]
          .evaluationLabors?[laborIndex ?? 0]
          .parts
          ?.remove(entity);
    } else {
      HomeServiceEvaluationSecondStepCubit
          .selectedServiceList?[serviceIndex ?? 0]
          .evaluationLabors?[laborIndex ?? 0]
          .parts
          ?.remove(entity);
    }

    cubit.refresh();
  }
}
