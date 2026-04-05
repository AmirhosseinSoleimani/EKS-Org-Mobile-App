import 'package:eks_sana_plus_org/src/features/requests/domain/entities/enums/request_status.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/enums/request_type.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/request_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/cubit/request_detail_cubit.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/cubit/request_detail_state.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/widgets/section_container.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailActionsButtons extends StatelessWidget {
  final RequestEntity selectedRequest;

  const DetailActionsButtons({super.key, required this.selectedRequest});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<RequestDetailCubit>();
    final int requestStatusCode = selectedRequest.status ?? 0;
    final requestStatusType = RequestStatus.fromValue(requestStatusCode);

    final actionAllowedStatuses = [
      RequestStatus.waitingPreInvoiceApproval,
      RequestStatus.waitingAddress,
      RequestStatus.waitingInfoCompletion,
      RequestStatus.waitingForDetails,
      RequestStatus.unknown,
      RequestStatus.waitingAssignment,
      RequestStatus.reserved,
    ];

    final bool canChangeTime =
        selectedRequest.type == RequestType.homeService.value &&
            actionAllowedStatuses.contains(requestStatusType);

    final bool canCancel = actionAllowedStatuses.contains(requestStatusType);

    return (canChangeTime || canCancel)
        ? Column(
          children: [
            SectionContainer(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p12, vertical: AppPadding.p12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (canChangeTime)
                      BlocBuilder<RequestDetailCubit, RequestDetailState>(
                builder: (context, state) {
                  final isLoading = state.maybeWhen(
                    getTimesLoading: () => true,
                    orElse: () => false,
                  );
                  return InkwellButtonWidget(
                    width: AppSize.s150,
                    height: AppSize.s42,
                    showLoading: isLoading,
                    loadingColor: theme.colorScheme.secondary,
                    splashColor: theme.colorScheme.secondary.withAlpha(30),
                    title: 'تغییر زمانبندی',
                    prefixIcon: Icon(
                      Icons.history,
                      color: theme.colorScheme.secondary,
                    ),
                    textStyle: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.secondary,
                      fontSize: AppSize.s14,
                    ),
                    backgroundColor: Colors.transparent,
                    borderColor: theme.colorScheme.secondary,
                    onTap: cubit.getTimes,
                  );
                },
                      ),
                    if (canCancel)
                      BlocBuilder<RequestDetailCubit, RequestDetailState>(
                builder: (context, state) {
                  final isLoading = state.maybeWhen(
                    getCancelReasonLoading: () => true,
                    orElse: () => false,
                  );
                  return InkwellButtonWidget(
                    width: AppSize.s150,
                    height: AppSize.s42,
                    showLoading: isLoading,
                    splashColor: theme.colorScheme.error.withAlpha(30),
                    prefixIcon: Icon(
                      Icons.close,
                      color: theme.colorScheme.error,
                    ),
                    title: 'لغو درخواست',
                    textStyle: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.error,
                      fontSize: AppSize.s14,
                    ),
                    backgroundColor: Colors.transparent,
                    onTap: cubit.getCancelReasons,
                  );
                },
              )
                  ],
                ),
              ),
            Space.h14,
          ],
        )
        : const SizedBox.shrink();
  }

}
