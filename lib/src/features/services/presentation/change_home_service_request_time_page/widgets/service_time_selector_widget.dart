import 'package:eks_sana_plus_org/src/features/services/domain/entities/day_schedule_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/change_home_service_request_time_page/cubit/change_home_service_request_time_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/change_home_service_request_time_page/widgets/day_selector_widget.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/change_home_service_request_time_page/widgets/time_selector_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceTimeSelectorWidget extends StatelessWidget {
  final List<DayScheduleEntity> times;

  const ServiceTimeSelectorWidget({super.key, required this.times});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleLargeText(
          text: 'انتخاب روز',
          fontSize: AppSize.s16,
          color: colorScheme.onTertiary,
        ),

        Space.h16,

        /// DAY ROW
        BlocBuilder<
          ChangeHomeServiceRequestTimeCubit,
          ChangeHomeServiceRequestTimeState
        >(
          buildWhen: (previous, current) {
            return current.maybeWhen(
              daySelected: (_) => true,
              loaded: () => true,
              orElse: () => false,
            );
          },
          builder: (context, state) {
            final cubit = context.read<ChangeHomeServiceRequestTimeCubit>();

            if (cubit.selectedDay == null) {
              final firstDay = times.whereType<DayScheduleEntity>().firstOrNull;

              if (firstDay != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  cubit.selectDay(firstDay);
                });
              }
            }

            return DaySelectorWidget(
              days: times,
              selectedDay: cubit.selectedDay,
              onDaySelected: cubit.selectDay,
            );
          },
        ),

        Space.h16,

        BlocBuilder<
          ChangeHomeServiceRequestTimeCubit,
          ChangeHomeServiceRequestTimeState
        >(
          buildWhen: (previous, current) {
            return current.maybeWhen(
              daySelected: (_) => true,
              timeSelected: (_) => true,
              orElse: () => false,
            );
          },
          builder: (context, state) {
            final cubit = context.read<ChangeHomeServiceRequestTimeCubit>();

            return TimeSelectorWidget(
              times: cubit.selectedDay?.times ?? [],
              selectedTime: cubit.selectedTime,
              onTimeSelected: cubit.selectTime,
            );
          },
        ),
      ],
    );
  }
}
