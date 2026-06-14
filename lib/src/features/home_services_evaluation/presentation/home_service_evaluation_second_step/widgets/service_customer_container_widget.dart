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
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_part/page/home_service_search_part_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceCustomerContainerWidget extends StatelessWidget {
  const ServiceCustomerContainerWidget({super.key, required this.evaluationServiceEntity, this.onTapDelete, required this.serviceIndex});
  final EvaluationServiceEntity evaluationServiceEntity;
  final VoidCallback? onTapDelete;
  final int serviceIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        collapsedBackgroundColor: AppTheme.darkThemeBoxBackgroundLight,
        backgroundColor: AppTheme.darkThemeBoxBackgroundLight,
        collapsedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
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
          '${evaluationServiceEntity.serviceTitle} (${evaluationServiceEntity.serviceCategoryTitle})',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: AppTheme.colorBlack
          ),
        ),
        children: (evaluationServiceEntity.evaluationLabors?.isNotEmpty ?? false) ? evaluationServiceEntity.evaluationLabors!.asMap().entries.map((entry) {
          final element = entry.value;
          final laborIndex= entry.key;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 2,
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
                              'نام اجرت: ${element.laborGroupDesc ?? '-'}',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 12.0),),
                          ),
                          Text(
                            element.costCenterObject?.name ?? '',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                                color: (element.costCenterObject?.id == 0)
                                    ? AppTheme.blue
                                    : AppTheme.green,
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
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 12.0),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () async{
                              await Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                  HomeServiceSearchPartPage(
                                    serviceIndex: serviceIndex,
                                    laborIndex: laborIndex,
                                  ),
                              ),
                              );
                              context.read<HomeServiceEvaluationSecondStepCubit>().refresh();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: AppTheme.blue
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(12))
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.add, size: 16, color: AppTheme.blue,),
                                    Text('افزودن قطعه', style: TextStyle(
                                      fontSize: 14,
                                      color: AppTheme.blue,
                                    ),)
                                  ],
                                ),
                              ),
                            ),
                          )
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
                              serviceIndex: serviceIndex,
                              laborIndex: laborIndex,
                              partIndex: index,
                              isEditablePart: true,
                            ),
                          );
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }).toList() : [
          const Text(
            'موردی جهت نمایش وجود ندارد',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold
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
