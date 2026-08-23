import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/cubit/home_service_evaluation_second_step_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/mapper/evaluation_labor_response_mapper.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/widgets/search_labor_page.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/widgets/search_part_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/widgets/selected_labor_list_item.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/delete_confirm_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceAddedContainerWidget extends StatelessWidget {
  const ServiceAddedContainerWidget({
    super.key,
    required this.entity,
    required this.index,
    this.onTapDelete,
  });

  final int index;
  final EvaluationServiceEntity entity;
  final VoidCallback? onTapDelete;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),

        // ================= DELETE SERVICE (BOTTOM SHEET) =================
        trailing: InkWell(
          onTap: () => _showDeleteBottomSheet(context),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                width: 2,
                color: colorScheme.inverseSurface,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.delete,
                size: 20,
                color: colorScheme.primary,
              ),
            ),
          ),
        ),

        title: Text(
          '${entity.serviceTitle ?? ''} (${entity.serviceCategoryTitle})',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: Colors.black,
          ),
        ),

        children: [
          if (entity.evaluationLabors?.isNotEmpty ?? false)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: entity.evaluationLabors!.length,
              itemBuilder: (context, laborIndex) {
                final labor = entity.evaluationLabors![laborIndex];

                return SelectedLaborListItem(
                  labor: labor.toSelectedEntity(),
                  isPartsExpanded: true,
                  onDelete: () {
                    context
                        .read<HomeServiceEvaluationSecondStepCubit>()
                        .deleteLabor(
                      serviceIndex: index,
                      laborIndex: laborIndex,
                      isCustomer: false,
                    );
                  },

                  onAddPart: () async {
                    await _navigateAddPart(context, laborIndex);

                    if (context.mounted) {
                      context
                          .read<HomeServiceEvaluationSecondStepCubit>()
                          .refresh();
                    }
                  },
                  onToggleShowMoreParts: () {},

                  onEdit: () {},
                );
              },
            ),

          Space.h16,

          _buildAddLaborButton(context, colorScheme),
        ],
      ),
    );
  }

  Widget _buildAddLaborButton(BuildContext context, ColorScheme colorScheme) {
    return InkwellButtonWidget(
      title: 'افزودن اجرت',
      prefixIcon: Icon(
        Icons.add,
        color: ServiceType.homeService.serviceColor,
      ),
      backgroundColor: colorScheme.onPrimary,
      borderColor: ServiceType.homeService.serviceColor,
      titleColor: ServiceType.homeService.serviceColor,
      onTap: () => _navigateAddLabor(context),
    );
  }

  void _showDeleteBottomSheet(BuildContext context) {
    DeleteConfirmSheet.show(
      context: context,
      title: 'حذف سرویس',
      message: 'آیا از حذف این سرویس اطمینان دارید؟',
      confirmTitle: 'حذف',
      onConfirm: () async {
        onTapDelete?.call();
      },
    );
  }


  void _navigateAddLabor(BuildContext context) async {
    final cubit = context.read<HomeServiceEvaluationSecondStepCubit>();

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SearchLaborHomeServicePage(serviceIndex: index),
      ),
    );

    cubit.refresh();
  }

  Future<void> _navigateAddPart(BuildContext context, int laborIndex) async {
    final cubit = context.read<HomeServiceEvaluationSecondStepCubit>();

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SearchPartHomeServicePage(
          serviceIndex: index,
          laborIndex: laborIndex,
        ),
      ),
    );

    cubit.refresh();
  }
}
