import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/cubit/assign_and_cancel_emdadgar_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/enums/service_assign_action.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignAndNonCooperationButtons extends StatelessWidget {
  final EmdadgarEntity entity;

  const AssignAndNonCooperationButtons({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AssignAndCancelEmdadgarCubit>();

    return BlocBuilder<
      AssignAndCancelEmdadgarCubit,
      AssignAndCancelEmdadgarState
    >(
      builder: (context, state) {
        final bool isAssignLoading = state.maybeWhen(
          checkDepotLoading: (id) => id == entity.id,
          orElse: () => false,
        );

        final bool isNonCoopLoading = state.maybeWhen(
          getReasonListLoading: (action) =>
              action == ServiceAssignAction.nonCooperation &&
              cubit.selectedEmdadgar?.id == entity.id,
          orElse: () => false,
        );

        final bool isAnyLoading = isAssignLoading || isNonCoopLoading;

        return Row(
          children: [
            Expanded(
              child: InkwellButtonWidget(
                height: 40,
                showLoading: isAssignLoading,
                backgroundColor:
                    cubit.selectedRequest?.serviceType?.serviceColor,
                onTap: isAnyLoading
                    ? () {}
                    : () {
                        cubit.setSelectedEmdadgar(entity);
                        cubit.getCheckDepotAndRoute();
                      },
                title: "تخصیص",
                textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: InkwellButtonWidget(
                height: 40,
                showLoading: isNonCoopLoading,
                backgroundColor: Colors.transparent,
                loadingColor: const Color(0xFFae8129),
                borderColor: const Color(0xFFf6c972),
                textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: const Color(0xFFae8129),
                  fontSize: 15,
                ),
                title: "عدم همکاری",
                onTap: isAnyLoading
                    ? () {}
                    : () {
                        cubit.setSelectedEmdadgar(entity);
                        cubit.getCancelReasons(
                          action: ServiceAssignAction.nonCooperation,
                        );
                      },
              ),
            ),
          ],
        );
      },
    );
  }
}
