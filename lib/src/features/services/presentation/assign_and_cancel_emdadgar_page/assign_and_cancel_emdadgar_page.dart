import 'dart:ui';

import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/service_assign_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/cubit/assign_and_cancel_emdadgar_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/enums/service_assign_action.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/map/emdadgar_marker_style_resolver.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/map/route_map_widget.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/map/service_assignment_map_widget.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/widgets/available_emdadgar_list.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/widgets/bottom_sheet/assign_confirm_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/widgets/bottom_sheet/cancel_mission_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/widgets/bottom_sheet/filter_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/widgets/bottom_sheet/non_cooperation_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/widgets/filter/search_and_filter_box.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/widgets/operation_success_message.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/expandable_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/request_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/request_status_section.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/bottom_sheet/emdadgar_info_bottom_sheet.dart';

class AssignAndCancelEmdadgarPage extends StatelessWidget {
  static const path = "/assign-and-cancel-emdadgar-page";
  static const name = "assign-and-cancel-emdadgar-page";

  const AssignAndCancelEmdadgarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AssignAndCancelEmdadgarCubit>()..init(),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AssignAndCancelEmdadgarCubit>();
    return BlocListener<
      AssignAndCancelEmdadgarCubit,
      AssignAndCancelEmdadgarState
    >(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            BottomSheetMessage.showErrorWithAction(
              context: context,
              data: message,
              onPositive: cubit.init,
            );
          },
          connectionError: () {
            BottomSheetMessage.showCustom(
              context: context,
              content: NoInternetBottomSheet(onRetry: cubit.init),
              actionWidget: const SizedBox.shrink(),
              isDismissible: false,
              enableDrag: false,
            );
          },

          showNonCooperationBottomSheet: () {
            cubit.markBottomSheetOpen();

            showNonCooperationBottomSheet(context).whenComplete(() {
              cubit.markBottomSheetClosed();
            });
          },

          showCancelMissionBottomSheet: () {
            cubit.markBottomSheetOpen();

            showCancelMissionBottomSheet(context).whenComplete(() {
              cubit.markBottomSheetClosed();
            });
          },

          showEmdadgarInfoBottomSheet: () {
            cubit.markBottomSheetOpen();

            showEmdadgarInfoBottomSheet(context).whenComplete(() {
              cubit.markBottomSheetClosed();
            });
          },
          showAssignConfirmBottomSheet: () {
            cubit.markBottomSheetOpen();

            showAssignConfirmBottomSheet(context).whenComplete(() {
              cubit.markBottomSheetClosed();
            });
          },

          closeBottomSheetAndRefresh: (response, action) async {
            if (cubit.isBottomSheetOpen) {
              Navigator.of(context).pop();
              cubit.markBottomSheetClosed();
            }

            await cubit.refreshAfterOperationSuccess(response, action);
          },

        );
      },
      child: Scaffold(
        appBar: SimpleAppBar(title: 'اعزام امدادرسان'),
        body:
            BlocBuilder<
              AssignAndCancelEmdadgarCubit,
              AssignAndCancelEmdadgarState
            >(
              builder: (context, state) {
                final operationSuccessResponse = state.maybeWhen(
                  showOperationSuccessMessage: (response, action) => response,
                  orElse: () => null,
                );
                final operationActionResponse = state.maybeWhen(
                  showOperationSuccessMessage: (response, action) => action,
                  orElse: () => null,
                );

                return state.maybeWhen(
                  idle: () => const SizedBox.shrink(),
                  loading: () => Center(
                    child: CircularProgressIndicator(
                      color:
                          cubit.selectedRequest?.serviceType?.serviceColor ??
                          ServiceType.reliefService.serviceColor,
                    ),
                  ),
                  orElse: () => _LoadedView(
                    operationSuccessResponse: operationSuccessResponse,
                    operationAction: operationActionResponse,
                  ));
              },
            ),
      ),
    );
  }
}

class _LoadedView extends StatelessWidget {
  final ServiceAssignResponseEntity? operationSuccessResponse;
  final ServiceAssignAction? operationAction;

  const _LoadedView({this.operationSuccessResponse, this.operationAction});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AssignAndCancelEmdadgarCubit>();

    final bool hasAssignedEmdadgar =
        cubit.selectedRequest?.hasEmdadGar ?? false;

    final bool canShowRouteMap =
        hasAssignedEmdadgar && cubit.routeData != null;

const markerStyleResolver = EmdadgarMarkerStyleResolver();
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSize.s16),
        child: Column(
          children: [
            ExpandableSection(
              isExpanded: false,
              header: RequestStatusSection(request: cubit.selectedRequest),
              child: RequestDetailSection(
                selectedRequest: cubit.selectedRequest,
                showCustomerInfo: true,
              ),
            ),
            Space.h8,
            FormSectionContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchAndFilterBox(
                    isLoading: false,
                    onOpenFilter: () => showFilterBottomSheet(context),
                    onRefresh: () => cubit.getEmdadgarList(),
                  ),
                  Space.h16,
                  if (canShowRouteMap)
                    RouteMapWidget(
                      routeData: cubit.routeData!,
                      height: 520,
                      startMarkerStyle: markerStyleResolver.resolve(
                          cubit.selectedEmdadgar!),
                      destinationMarkerStyle: markerStyleResolver
                          .resolveCustomer(),
                    )
                  else
                    ServiceAssignmentMapWidget(
                      height: 520,
                      emdadgars: cubit.emdadgarList,
                      customerLatitude: cubit.selectedRequest?.latitude ?? 0,
                      customerLongitude: cubit.selectedRequest?.longitude ?? 0,

                      onEmdadgarTap: (emdadgar) {
                        cubit.setSelectedEmdadgar(emdadgar);
                        cubit.getCheckDepotAndRoute();
                      },
                    ),
                  Space.h16,
                  if (operationSuccessResponse != null &&
                      operationAction != null) ...[
                    OperationSuccessMessage(
                      response: operationSuccessResponse!,
                      action: operationAction!,
                    ),
                    Space.h16,
                  ],
                  AvailableEmdadgarList(
                    emdadgarList: cubit.emdadgarList,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
