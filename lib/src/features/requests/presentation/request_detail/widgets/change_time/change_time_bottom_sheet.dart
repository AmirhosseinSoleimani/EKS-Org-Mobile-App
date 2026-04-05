import 'package:eks_sana_plus_org/src/features/requests/domain/entities/time_table_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/cubit/request_detail_cubit.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/widgets/change_time/change_time_action.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/widgets/change_time/change_time_request_content.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void openChangeTimeBottomSheet(
    BuildContext context, List<DayScheduleEntity?> times) {
  final cubit = context.read<RequestDetailCubit>();
  BottomSheetMessage.showCustom(
    context: context,
    content: BlocProvider.value(
      value: cubit,
      child: ChangeTimeRequestContent(times: times),
    ),
    actionWidget: BlocProvider.value(
      value: cubit,
      child: const ChangeTimeAction(),
    ),
  );
}
