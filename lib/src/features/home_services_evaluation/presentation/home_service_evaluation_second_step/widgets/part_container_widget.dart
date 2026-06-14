import 'package:eks_sana_plus_org/src/common/utils/extensions/string_ext.dart';
import 'package:eks_sana_plus_org/src/config/themes/app_theme.dart';
import 'package:eks_sana_plus_org/src/core/uikit/dialog/dialog_widgets.dart';
import 'package:eks_sana_plus_org/src/core/uikit/spacing.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/cubit/home_service_evaluation_second_step_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/widgets/edit_and_registration_part_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PartContainerWidget extends StatelessWidget {
  const PartContainerWidget({super.key, required this.entity, this.serviceIndex, this.laborIndex, this.partIndex, this.isEditablePart});
  final EvaluationPartResponseEntity entity;
  final int? serviceIndex;
  final int? laborIndex;
  final int? partIndex;
  final bool? isEditablePart;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.only(right: 12, left: 12, top: 12, bottom: 8),
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        border: Border.all(color: AppTheme.darkThemeBoxBackgroundDark),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        children: [
          // part name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'نام قطعه: ${entity.partName ?? '-'}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Space.w4,
                    Text(
                      (entity.isReusable != null && entity.isReusable == true) ? '(داغی دارد)' : '',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Space.w4,
              (isEditablePart ?? false) ?
              Row(
                children: [
                  InkWell(
                    onTap: () async{
                      await Navigator.of(context).push(MaterialPageRoute(builder: (_) => EditAndRegistrationPartWidget(
                        evaluationPartEntity: entity,
                        serviceIndex: serviceIndex ?? 0,
                        laborIndex: laborIndex ?? 0,
                        partIndex: partIndex ?? 0,
                        isEditablePart: isEditablePart,
                        partCustomerIndex: partIndex ?? 0,
                      )));
                      if (context.mounted) await context.read<HomeServiceEvaluationSecondStepCubit>().refresh();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.whiteColor,
                          border: Border.all(
                              width: 1,
                              color:
                              AppTheme.darkThemeBoxBackgroundDark)),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.edit,
                          size: 20,
                          color: AppTheme.blue,
                        ),
                      ),
                    ),
                  ),
                  Space.w4,
                  InkWell(
                    onTap: () async{
                      showDialog(
                        context: context,
                        builder: (_) {
                          return MessageDialogWidget(
                            dismissible: true,
                            color: AppTheme.blue,
                            title: '',
                            body: 'آیا از حذف این قطعه اطمینان دارید؟',
                            positiveFunc: () async{
                              HomeServiceEvaluationSecondStepCubit.customerServiceList?[serviceIndex ?? 0].evaluationLabors?[laborIndex ?? 0].parts?.remove(entity);
                              if (context.mounted) await context.read<HomeServiceEvaluationSecondStepCubit>().refresh();
                            },
                          );
                        },);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.whiteColor,
                          border: Border.all(
                              width: 1,
                              color:
                              AppTheme.darkThemeBoxBackgroundDark)),
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
              ) :
              InkWell(
                onTap: () async{
                  showDialog(
                    context: context,
                    builder: (_) {
                      return MessageDialogWidget(
                        dismissible: true,
                        color: AppTheme.blue,
                        title: '',
                        body: 'آیا از حذف این قطعه اطمینان دارید؟',
                        positiveFunc: () async{
                          HomeServiceEvaluationSecondStepCubit.selectedServiceList?[serviceIndex ?? 0].evaluationLabors?[laborIndex ?? 0].parts?.remove(entity);
                          if (context.mounted) await context.read<HomeServiceEvaluationSecondStepCubit>().refresh();
                        },
                      );
                    },);
                  },
                  child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.whiteColor,
                      border: Border.all(
                          width: 1,
                          color:
                          AppTheme.darkThemeBoxBackgroundDark)),
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
          //count and serial and mark
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //mark
              FittedBox(
                child: Text(
                  'مارک: ${entity.mark}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),

              //part count
              FittedBox(
                child: Text(
                  'تعداد: ${entity.count.toString()}'
                      .convertNumberWithLanguage(),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),

              //base price
              FittedBox(
                child: Text(
                  'قیمت واحد: ${(entity.partPrice).toString().splitPriceByComma().addPriceTag().convertNumberWithLanguage()}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 2,
            color: AppTheme.darkThemeBoxBackgroundDark,
          ),
          Space.h8,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //part price
              Text(
                'قیمت کل: ${((entity.partPrice ?? 0) * (entity.count ?? 0)).toString().splitPriceByComma().addPriceTag().convertNumberWithLanguage()}',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),

              //is customer or is company part
              Text(
                (entity.costCenterObject?.name ?? ''),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: (entity.costCenterObject?.id == 0)
                      ? AppTheme.blue
                      : AppTheme.green,
                  fontSize: 12.0,
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
}
