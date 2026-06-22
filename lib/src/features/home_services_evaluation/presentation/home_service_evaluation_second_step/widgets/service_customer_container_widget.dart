import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/cubit/home_service_evaluation_second_step_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/widgets/labor_section.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_part/page/home_service_search_part_page.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/widgets/edit_and_registration_part_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ServiceHeader(
            title: evaluationServiceEntity.serviceTitle ?? '',
            category: evaluationServiceEntity.serviceCategoryTitle ?? '',
            onDelete: () => _showDeleteServiceBottomSheet(context),
          ),

          const SizedBox(height: 8),

          if ((evaluationServiceEntity.evaluationLabors?.isNotEmpty ?? false))
            ...evaluationServiceEntity.evaluationLabors!
                .asMap()
                .entries
                .map(
                  (e) =>
                  LaborSection(
                    labor: e.value,
                    laborIndex: e.key,
                    onAddPart: () => _navigateAddPart(context, e.key),
                    onEditPart: (context, laborIndex, element, index) =>
                        _navigateEditLabor(
                            context: context,
                            laborIndex: laborIndex,
                            evaluationPartEntity: element,
                            partIndex: index
                        ),
                    onDeletePart: _showDeleteLaborBottomSheet,
                  ),
            )
          else
            const EmptyListWidget(),
        ],
      ),
    );

  }


  void _showDeleteServiceBottomSheet(BuildContext context) {
    BottomSheetMessage.showError(context: context,
        data: BottomSheetMessageModel(
          title: '', message: 'آیا از حذف این سرویس اطمینان دارید؟',),
        positiveText: 'حذف',
        onButtonTap: (context) {
          Navigator.pop(context);
          onTapDelete?.call();
        });

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
    BottomSheetMessage.showErrorWithAction(context: context,
        data: BottomSheetMessageModel(
            title: '', message: 'آیا از حذف این قطعه اطمینان دارید؟'),
        positiveText: 'حذف',
        onPositive: () {
          _handleDeletePart(
              context, entity, laborIndex, isEditablePart);
          Navigator.pop(context);
        });
  }

  void _handleDeletePart(BuildContext context,
      EvaluationPartResponseEntity entity,
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

class _ServiceHeader extends StatelessWidget {
  final String title;
  final String category;
  final VoidCallback onDelete;

  const _ServiceHeader({
    required this.title,
    required this.category,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BodyMediumText(
            text: '$title ($category)',
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black,
            maxLines: 2,
            textOverflow: TextOverflow.ellipsis,
          ),
          IconButton(
            onPressed: onDelete,
            icon: Padding(
              padding: const EdgeInsets.all(4),
              child: SvgWidget(src: SvgAsset(SvgManager.delete)),
            ),
          ),
        ],
      ),
    );
  }
}