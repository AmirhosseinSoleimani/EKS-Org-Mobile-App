import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/cubit/assign_and_cancel_emdadgar_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/enums/service_assign_action.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CancelMissionButton extends StatelessWidget {
  final EmdadgarEntity entity;

  const CancelMissionButton({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AssignAndCancelEmdadgarCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<
      AssignAndCancelEmdadgarCubit,
      AssignAndCancelEmdadgarState
    >(
      builder: (context, state) {
        final bool isLoading = state.maybeWhen(
          getReasonListLoading: (action) =>
              action == ServiceAssignAction.cancelMission &&
              cubit.selectedEmdadgar?.id == entity.id,
          orElse: () => false,
        );

        return InkwellButtonWidget(
          height: 40,
          width: double.infinity,
          showLoading: isLoading,
          backgroundColor: Colors.transparent,
          borderColor: colorScheme.error,
          loadingColor: colorScheme.error,
          textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: colorScheme.error,
            fontSize: 15,
          ),
          title: "لغو ماموریت",
          onTap: isLoading
              ? () {}
              : () {
                  cubit.setSelectedEmdadgar(entity);
                  cubit.getCancelReasons(
                    action: ServiceAssignAction.cancelMission,
                  );
                },
        );
      },
    );
  }
}
