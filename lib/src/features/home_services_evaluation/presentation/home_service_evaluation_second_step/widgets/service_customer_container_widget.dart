import 'dart:convert';
import 'dart:typed_data';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/common/utils/extensions/string_ext.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/cubit/home_service_evaluation_second_step_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/widgets/part_container_widget.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_part/page/home_service_search_part_page.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entity/evaluation_service_entity.dart';

class ServiceCustomerContainerWidget extends StatelessWidget {
  const ServiceCustomerContainerWidget({
    super.key,
    required this.evaluationServiceEntity,
    this.onTapDelete,
    required this.serviceIndex,
  });

  final EvaluationServiceEntity evaluationServiceEntity;
  final VoidCallback? onTapDelete;
  final int serviceIndex;

  @override
  Widget build(BuildContext context) {

    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        collapsedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),

        /// DELETE SERVICE (BOTTOM SHEET INSTEAD OF DIALOG)
        trailing: IconButton(
          onPressed: () {
            _showDeleteBottomSheet(context);
          },
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                width: 2,
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

        title: Text(
          '${evaluationServiceEntity.serviceTitle} (${evaluationServiceEntity.serviceCategoryTitle})',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: Colors.black,
          ),
        ),

        children: (evaluationServiceEntity.evaluationLabors?.isNotEmpty ?? false)
            ? evaluationServiceEntity.evaluationLabors!
            .asMap()
            .entries
            .map((entry) {
          final element = entry.value;
          final laborIndex = entry.key;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: colorScheme.inverseSurface,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Column(
                  children: [
                    /// LABOR HEADER
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              'نام اجرت: ${element.laborGroupDesc ?? '-'}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          Text(
                            element.costCenterObject?.name ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color:
                              (element.costCenterObject?.id == 0)
                                  ? ServiceType
                                  .homeService.serviceColor
                                  : Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// PRICE + ADD PART
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text(
                            'قیمت: ${element.laborPrice} ریال'
                                .splitPriceByComma()
                                .convertNumberWithLanguage(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                          const Spacer(),

                          /// ADD PART
                          InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      HomeServiceSearchPartPage(
                                        serviceIndex: serviceIndex,
                                        laborIndex: laborIndex,
                                      ),
                                ),
                              );

                              context
                                  .read<
                                  HomeServiceEvaluationSecondStepCubit>()
                                  .refresh();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: ServiceType
                                      .homeService.serviceColor,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      size: 16,
                                      color: ServiceType
                                          .homeService.serviceColor,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'افزودن قطعه',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: ServiceType
                                            .homeService.serviceColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// PARTS
                    if (element.parts?.isNotEmpty ?? false) ...[
                      Space.h16,
                      ListView.builder(
                        shrinkWrap: true,
                        physics:
                        const NeverScrollableScrollPhysics(),
                        itemCount: element.parts?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PartContainerWidget(
                              entity: element.parts?[index] ??
                                  EvaluationPartResponseEntity(),
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
        }).toList()
            : const [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'موردی جهت نمایش وجود ندارد',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= BOTTOM SHEET =================

  void _showDeleteBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'آیا از حذف این سرویس اطمینان دارید؟',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Space.h16,
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Center(child: Text('لغو')),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        onTapDelete?.call();
                      },
                      child: Center(
                        child: Text(
                          'حذف',
                          style: TextStyle(
                            color: ServiceType.homeService.serviceColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
