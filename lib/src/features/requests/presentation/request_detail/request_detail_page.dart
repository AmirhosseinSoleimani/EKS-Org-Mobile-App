import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/enums/request_type.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/cubit/request_detail_cubit.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/cubit/request_detail_state.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/widgets/address_box_widget.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/widgets/cancel_request/reason_cancel_request_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/widgets/change_time/change_time_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/widgets/detail_actions_buttons.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/widgets/detail_box.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/widgets/request_detail_car_info_widget.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/extensions/string_extensions.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/main_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RequestDetailPage extends StatelessWidget {
  static const name = 'request-detail-page';

  static get path => '/$name';

  const RequestDetailPage({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => getIt<RequestDetailCubit>()..init(),
      child: Builder(
        builder: (BuildContext context) {
          final selectedRequest = context.read<RequestDetailCubit>().selectedRequest;
          final buttonColor = selectedRequest?.type == RequestType.homeService.value
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).primaryColor;
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) async {
              context.pop(BottomSheetAction.positive);
            },
            child: Scaffold(
              appBar: MainAppBar(
                title: 'جزئیات درخواست',

              ),
              body: BlocListener<RequestDetailCubit, RequestDetailState>(
                listener: (context, state) {
                  state.whenOrNull(
                    error: (bottomSheetMessage) {
                      BottomSheetMessage.showErrorWithAction(
                        context: context,
                        data: bottomSheetMessage,
                        onPositive: context.read<RequestDetailCubit>().init,
                      );
                    },
                    notice: (message) {
                      SnakeBarWidget.showSuccess(
                        context: context,
                        message: message,
                      );
                    },
                    getCancelReasonSuccess: (reasons) {
                      openReasonCancelRequestBottomSheet(context, reasons);
                    },
                    getTimesSuccess: (times) {
                      openChangeTimeBottomSheet(context, times);
                    },
                    reasonNotSelectedError: (message) {
                      BottomSheetMessage.showError(
                        context: context,
                        data: BottomSheetMessageModel(
                            title: '', message: message),
                      );
                    },
                    cancelRequestSuccess: (message) {
                      SnakeBarWidget.showError(
                        context: context,
                        message: message,
                      );
                      context.pop();
                      context.pop(BottomSheetAction.positive);
                    },
                    changeTimeRequestSuccess: (message) {
                      context.pop();
                      BottomSheetMessage.showNoticeWithAction(
                        context: context,
                        data: message,
                        isDismissible: false,
                        buttonColor: buttonColor,
                        onPositive: () {
                          context.pop();
                        },
                      );
                    },
                    errorUpdatePayment: (message) {
                      context.pop();
                      BottomSheetMessage.showError(
                        context: context,
                        data: BottomSheetMessageModel(
                            title: '', message: message),
                      );
                    },
                    successUpdatePayment: (message) {
                      context.pop();
                      BottomSheetMessage.showNotice(
                        context: context,
                        data: BottomSheetMessageModel(
                            title: '', message: message),
                      );
                    },
                    connectionError: () {
                      final cubit = context.read<RequestDetailCubit>();
                      BottomSheetMessage.showCustom(
                          context: context,
                          content: NoInternetBottomSheet(
                              onRetry: cubit.retryLastAction),
                          actionWidget: const SizedBox.shrink(), isDismissible: false,enableDrag: false);
                    },
                  );
                },
                child: BlocBuilder<RequestDetailCubit, RequestDetailState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      idle: () =>
                          const Center(child: CircularProgressIndicator()),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      orElse: () => const _RequestDetailView(),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
class _RequestDetailView extends StatelessWidget {
  const _RequestDetailView();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final selectedRequest = context.watch<RequestDetailCubit>().selectedRequest;
    final weekdayName = JalaliDateHelper.getWeekdayName(selectedRequest?.serviceDate);
    if(selectedRequest == null) const SizedBox();
    return Container(
      width: screenWidth,
      padding: const EdgeInsets.all(AppPadding.p16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BodyMediumText(
              text:
              '${weekdayName ?? '-'}  ${selectedRequest?.serviceDate ?? '-'}   ${selectedRequest?.serviceTime?.to12HourFormat() ?? '-'}',
              fontSize: AppSize.s14,
            ),
            _gap(),
            AddressBoxWidget(selectedRequest: selectedRequest!),
            _gap(),
            RequestDetailCarInfoWidget(item: selectedRequest),
            _gap(),
            DetailActionsButtons(selectedRequest: selectedRequest),
            DetailBox(selectedRequest),
          ],
        ),
      ),
    );
  }

  SizedBox _gap() => Space.h14;
}

