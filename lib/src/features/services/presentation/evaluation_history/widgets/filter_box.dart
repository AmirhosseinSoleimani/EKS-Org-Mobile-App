import 'package:eks_sana_plus_org/src/common/constants/request_status.dart';
import 'package:eks_sana_plus_org/src/common/constants/time_period.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_history/cubit/evaluation_history_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_history/widgets/enums/evaluation_is_accepted_filter.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/relief_request_list_page/cubit/relief_request_list_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/search_request_form.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      builder: (_, period, __) {
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
