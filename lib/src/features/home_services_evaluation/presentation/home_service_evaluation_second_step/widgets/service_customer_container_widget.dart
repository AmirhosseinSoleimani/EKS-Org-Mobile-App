import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/cubit/home_service_evaluation_second_step_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/mapper/evaluation_labor_response_mapper.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_part/page/home_service_search_part_page.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/widgets/edit_and_registration_part_widget.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/widgets/selected_labor_list_item.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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
            child:  Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.delete,
                size: 20,
                color: colorScheme.primary,
              ),
            ),
          ),
        ),

        title: BodyMediumText(text:
          '${evaluationServiceEntity.serviceTitle} (${evaluationServiceEntity.serviceCategoryTitle})',
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
          color: Colors.black,
        ),

        children: (evaluationServiceEntity.evaluationLabors?.isNotEmpty ?? false)
            ? evaluationServiceEntity.evaluationLabors!
            .asMap()
            .entries
            .map((entry) {
          final element = entry.value;
          final laborIndex = entry.key;

          return (element.parts?.isNotEmpty ?? false) ? ListView.builder(
            padding: EdgeInsets.all(8),
            shrinkWrap: true,
            physics:
            const NeverScrollableScrollPhysics(),
            itemCount: element.parts?.length,
            itemBuilder: (BuildContext context, int index) {
              final selectedLabor = element.toSelectedEntity();
              return SelectedLaborListItem(
                labor: selectedLabor,
                isPartsExpanded: true,
                onAddPart: () async =>
                await _navigateAddPart(context, laborIndex),

                onEdit: () =>
                    _navigateEditLabor(
                        context: context,
                        laborIndex: laborIndex,
                        evaluationPartEntity: element
                            .parts?[index] ??
                            EvaluationPartResponseEntity(),
                        partIndex: index
                    ),
                onDelete: () =>
                    _showDeleteLaborBottomSheet(
                      context,
                      element.parts?[index] ??
                          EvaluationPartResponseEntity(),
                      laborIndex,
                      true,
                    ),
                onToggleShowMoreParts: () {},
              );
            },

          ) : EmptyListWidget();
        }).toList()
            : [EmptyListWidget()],
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

  void _navigateEditLabor({
    required BuildContext context,
    required int laborIndex,
    required EvaluationPartResponseEntity evaluationPartEntity,
    required int partIndex,
  }) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            EditAndRegistrationPartWidget(
              evaluationPartEntity: evaluationPartEntity,
              serviceIndex: serviceIndex,
              laborIndex: laborIndex,
              partIndex: partIndex,
              isEditablePart: true,
              partCustomerIndex: partIndex,
            ),
      ),
    );

    if (context.mounted) {
      context
          .read<HomeServiceEvaluationSecondStepCubit>()
          .refresh();
    }
  }

  void _showDeleteLaborBottomSheet(BuildContext context,
      EvaluationPartResponseEntity entity, int laborIndex,
      bool? isEditablePart) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;
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
              Text(
                'آیا از حذف این قطعه اطمینان دارید؟',
                style: Theme
                    .of(
                  context,
                )
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),

              Space.h16,

              Row(
                children: [
                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'لغو',
                      backgroundColor: colorScheme.surface,
                      onTap: () => Navigator.pop(context),
                    ),
                  ),

                  Space.w8,

                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'حذف',
                      backgroundColor: ServiceType.homeService.serviceColor,
                      onTap: () {
                        _handleDelete(
                            context, entity, laborIndex, isEditablePart);
                        Navigator.pop(context);
                      },
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

  void _handleDelete(BuildContext context, EvaluationPartResponseEntity entity,
      int laborIndex, bool? isEditablePart) {
    final cubit = context.read<HomeServiceEvaluationSecondStepCubit>();

    if (isEditablePart ?? false) {
      HomeServiceEvaluationSecondStepCubit
          .customerServiceList?[serviceIndex]
          .evaluationLabors?[laborIndex]
          .parts
          ?.remove(entity);
    } else {
      HomeServiceEvaluationSecondStepCubit
          .selectedServiceList?[serviceIndex]
          .evaluationLabors?[laborIndex]
          .parts
          ?.remove(entity);
    }

    cubit.refresh();
  }

  Future<void> _navigateAddPart(BuildContext context, int laborIndex) async {
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
    if (context.mounted) {
      context
          .read<
          HomeServiceEvaluationSecondStepCubit>()
          .refresh();
    }
  }
}
