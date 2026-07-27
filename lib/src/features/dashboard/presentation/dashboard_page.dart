import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/presentation/widgets/chart/horizon_bar_chart.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/presentation/widgets/chart/pie_chart_widget.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/presentation/widgets/filters_box.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/main_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/stat_row_card/stat_row_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/chart/chart_container_wrapper.dart';

class DashboardPage extends StatelessWidget {
  static const path = "/dashboard";
  static const name = "dashboard";

  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DashboardCubit>()..init(),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DashboardCubit>();
    return BlocListener<DashboardCubit, DashboardState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            BottomSheetMessage.showErrorWithAction(
              context: context,
              data: message,
              onPositive: cubit.loadDashboardData,
            );
          },
          connectionError: () {
            BottomSheetMessage.showCustom(
              context: context,
              content: NoInternetBottomSheet(
                onRetry: cubit.loadDashboardData,
              ),
              actionWidget: const SizedBox.shrink(),
              isDismissible: false,
              enableDrag: false,
            );
          },
        );
      },
      child: Scaffold(
        appBar: const MainAppBar(title: "داشبورد"),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: FiltersBox(cubit: cubit)),
              Expanded(
                child:
                BlocBuilder<DashboardCubit, DashboardState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      idle: () => const SizedBox.shrink(),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      loaded: () => SingleChildScrollView(
                        padding: const EdgeInsets.all(AppSize.s16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StatRowCard(
                              title: 'تعداد کل تماس‌های ورودی',
                              value: cubit.dashboardData?.totalCallLogCount.toString() ?? '-',
                              serviceType: cubit.selectedServiceType,
                            ),
                            StatRowCard(
                              title: 'تعداد کل درخواست‌ها',
                              value: cubit.dashboardData?.totalRegisterServiceRequests.toString()?? '-',
                              serviceType: cubit.selectedServiceType,
                            ),
                            StatRowCard(
                              title: 'تعداد کل درخواست های اضظراری',
                              value: cubit.dashboardData?.totalUrgentServiceRequest.toString()?? '-',
                              serviceType: cubit.selectedServiceType,
                            ),
                            StatRowCard(
                              title: 'تعداد استفاده از اپلیکیشن',
                              value: cubit.dashboardData?.serviceRequestEmdadgarFollowUpWithTabletCount.toString()?? '-',
                              serviceType: cubit.selectedServiceType,
                            ),
                            StatRowCard(
                              title: 'درصد پیگیری با اپلیکیشن',
                              value: '${cubit.dashboardData?.serviceRequestEmdadgarFollowUpWithTabletPercent.toStringAsFixed(1)}%',
                              serviceType: cubit.selectedServiceType,
                            ),
                              Space.h8,
                              ChartContainerWrapper(
                                title: "درخواست ثبت شده به تفکیک وضعیت",
                                totalCount: cubit.calculateTotalCount(
                                  cubit.dashboardData?.serviceRequestsGroupByGeneralStatus,
                                ),
                                chart: HorizonBarChart(
                                    items: cubit.dashboardData?.serviceRequestsGroupByGeneralStatus ??
                                        []),
                              ),
                              Space.h16,
                              ChartContainerWrapper(
                                title: 'درخواست باز به تفکیک وضعیت',
                                totalCount: cubit.calculateTotalCount(
                                  cubit.dashboardData
                                      ?.openServiceRequestsGroupByRequestStatus,
                                ),
                                chart: PieChartWidget(
                                    items: cubit.dashboardData
                                            ?.openServiceRequestsGroupByRequestStatus ??
                                        []),
                              ),
                              Space.h16,
                              ChartContainerWrapper(
                                title: "عملیات انجام شده بر اساس نوع عملیات",
                                totalCount: cubit.calculateTotalCount(
                                  cubit.dashboardData?.allowdCancelationOrClosedServiceRequestsGroupByGeneralStatus,
                                ),
                                chart: HorizonBarChart(
                                    items: cubit.dashboardData
                                            ?.allowdCancelationOrClosedServiceRequestsGroupByGeneralStatus ??
                                        []),
                              ),
                              Space.h16,
                              ChartContainerWrapper(
                                title: 'عملیات انجام شده بر اساس سرویس',
                                totalCount: cubit.calculateTotalCount(
                                  cubit.dashboardData
                                      ?.allowdCancelationOrClosedServiceRequestsGroupByGivenServiceCategory,
                                ),
                                chart: PieChartWidget(
                                    items: cubit.dashboardData
                                            ?.allowdCancelationOrClosedServiceRequestsGroupByGivenServiceCategory ??
                                        []),
                              ),
                            ],
                          )),
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
