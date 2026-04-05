import 'package:eks_sana_plus_org/src/features/requests/domain/entities/time_table_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/widgets/change_time/day_selector_widget.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/widgets/change_time/time_selector_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';

class ChangeTimeRequestContent extends StatelessWidget {
  final List<DayScheduleEntity?> times;

  const ChangeTimeRequestContent({super.key, required this.times});

  @override

  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: TitleLargeText(
            text: 'تغییر زمان بندی',
            fontSize: AppSize.s16,
            color: colorScheme.onTertiary,
          ),
        ),
        Space.h24,
        TitleLargeText(
          text: 'انتخاب روز',
          fontSize: AppSize.s16,
          color: colorScheme.onTertiary,
        ),
        Space.h16,
        DaySelectorWidget(days: times),
        Space.h16,
        const TimeSelectorWidget(),
      ],
    );
  }
}
