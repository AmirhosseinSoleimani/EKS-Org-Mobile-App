import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_history/cubit/evaluation_history_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_history/enums/evaluation_is_accepted_filter.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:flutter/material.dart';

class FilterBox extends StatelessWidget {
  final EvaluationHistoryCubit cubit;

  const FilterBox({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder(
      valueListenable: cubit.selectedEvaluationIsisAcceptedNotifier,
      builder: (_, period, _) {
        return FilterButton(
          title: period.label,
          expand: true,
          overlayBuilder: (context, position, width, dismiss) {
            return OverlayDropdownMenu<EvaluationIsAcceptedFilter>(
              position: position,
              width: width,
              items: EvaluationIsAcceptedFilter.values,
              onDismiss: dismiss,
              onSelect: (value) {
                cubit.setSelectedEvaluationIsAccept(value);
                dismiss();
              },
            );
          },
        );
      },
    );
  }
}
