import 'package:eks_sana_plus_org/src/features/requests/domain/entities/cancel_reasons_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/cubit/request_detail_cubit.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/widgets/cancel_request/cancel_request_actions.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/widgets/cancel_request/reason_cancel_request_content.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void openReasonCancelRequestBottomSheet(BuildContext context,
    List<CancelReasonEntity> cancelReasons) {
  final cubit = context.read<RequestDetailCubit>();
  BottomSheetMessage.showCustom(
    context: context,
    content: BlocProvider.value(
      value: cubit,
      child: ReasonCancelRequestContent(cancelReasons: cancelReasons),
    ),
    actionWidget:  BlocProvider.value(
      value: cubit,
      child: const CancelRequestActions(),
    ),
  );
}