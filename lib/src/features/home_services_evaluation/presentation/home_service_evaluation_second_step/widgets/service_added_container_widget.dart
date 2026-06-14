import 'dart:convert';
import 'dart:typed_data';
import 'package:eks_sana_plus_org/src/common/utils/extensions/string_ext.dart';
import 'package:eks_sana_plus_org/src/config/themes/app_theme.dart';
import 'package:eks_sana_plus_org/src/core/uikit/dialog/dialog_widgets.dart';
import 'package:eks_sana_plus_org/src/core/uikit/spacing.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/cubit/home_service_evaluation_second_step_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/widgets/part_container_widget.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/widgets/search_labor_page.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/widgets/search_part_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceAddedContainerWidget extends StatelessWidget {
  const ServiceAddedContainerWidget({super.key, required this.entity, required this.index, this.onTapDelete});
  final int index;
  final EvaluationServiceEntity entity;
  final VoidCallback? onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        collapsedBackgroundColor: AppTheme.darkThemeBoxBackgroundLight,
        backgroundColor: AppTheme.darkThemeBoxBackgroundLight,
        trailing: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return MessageDialogWidget(
                  color: AppTheme.blue,
                  dismissible: true,
                  title: '',
                  body: 'آیا از حذف این سرویس اطمینان دارید؟',
                  positiveFunc: onTapDelete,
                );
              },
            );
          },
          icon: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.whiteColor,
                border: Border.all(
                    width: 2,
                    color: AppTheme.darkThemeBoxBackgroundDark
                )
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
        title: Text(
          '${entity.serviceTitle ?? ''} (${entity.serviceCategoryTitle})',
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: AppTheme.colorBlack
          ),
        ),
        children: (entity.evaluationLabors?.isNotEmpty ?? false) ? entity.evaluationLabors!.asMap().entries.map((entry) {
          final element = entry.value;
          final laborIndex= entry.key;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: AppTheme.darkThemeBoxBackgroundDark
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      color: AppTheme.darkThemeBoxBackgroundLight
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  'نام اجرت: ${element.laborName}',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 14.0),),
                              ),
                              InkWell(
                                onTap: () async{
                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return MessageDialogWidget(
                                        dismissible: true,
                                        color: AppTheme.blue,
                                        title: '',
                                        body: 'آیا از حذف این اجرت اطمینان دارید؟',
                                        positiveFunc: () async{
                                          HomeServiceEvaluationSecondStepCubit.selectedServiceList?[index].evaluationLabors?.remove(element);
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
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Text(
                                'قیمت: ${element.laborPrice} ریال'.splitPriceByComma().convertNumberWithLanguage(),
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 14.0),
                              ),
                              const Spacer(),
                              Text(
                                element.costCenterObject?.name ?? '',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                  color: (element.costCenterObject?.id == 0)
                                      ? AppTheme.blue
                                      : AppTheme.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if(element.parts?.isNotEmpty ?? false)...[
                          Space.h16,
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: element.parts?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: PartContainerWidget(
                                  entity: element.parts?[index] ?? EvaluationPartResponseEntity(),
                                  isEditablePart: false,
                                ),
                              );
                            },
                          ),
                        ],
                        Space.h16,
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          child: InkWell(
                            onTap: () async{
                              final cubit =context.read<HomeServiceEvaluationSecondStepCubit>();
                              await Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchPartHomeServicePage(
                                serviceIndex: index,
                                laborIndex: laborIndex,
                              )));
                              cubit.refresh();
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2,
                                      color: AppTheme.green
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(12.0))
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Center(
                                  child: Text(
                                    'افزودن قطعه',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.green,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: InkWell(
                  onTap: () async{
                    final cubit =context.read<HomeServiceEvaluationSecondStepCubit>();
                    await Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchLaborHomeServicePage(serviceIndex: index)));
                    cubit.refresh();
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: AppTheme.green
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(12.0))
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Center(
                        child: Text(
                          'افزودن اجرت',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.green,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList() : [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: InkWell(
              onTap: () async{
                final cubit =context.read<HomeServiceEvaluationSecondStepCubit>();
                await Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchLaborHomeServicePage(
                  serviceIndex: index,
                )));
                cubit.refresh();
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 2,
                        color: AppTheme.green
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12.0))
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Center(
                    child: Text(
                      'افزودن اجرت',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.green,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget homeServicesImage ({required String base64StringWithPrefix }) {
    String base64String = base64StringWithPrefix  .split(',').last;
    Uint8List bytes = base64Decode(base64String );
    return Image.memory(
      bytes,
      fit: BoxFit.cover,
    );
  }
}
