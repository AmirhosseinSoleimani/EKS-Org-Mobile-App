import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/date_drop_down.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/widgets/app_bar_widget/main_app_bar.dart';
import 'cubit/indicator_report_cubit.dart';
import 'widgets/indicator_report_viewer.dart';

class IndicatorReportPage extends StatelessWidget {
  static const path = "/indicator-report";
  static const name = "indicator-report";

  const IndicatorReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<IndicatorReportCubit>()..loadReports(),
      child: const _IndicatorReportView(),
    );
  }
}

class _IndicatorReportView extends StatelessWidget {
  const _IndicatorReportView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<IndicatorReportCubit>();
    return BlocListener<IndicatorReportCubit, IndicatorReportState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            BottomSheetMessage.showErrorWithAction(
              context: context,
              data: message,
              onPositive: cubit.loadReports,
            );
          },
          connectionError: () {
            BottomSheetMessage.showCustom(
              context: context,
              content: NoInternetBottomSheet(
                onRetry: cubit.loadReports,
              ),
              actionWidget: const SizedBox.shrink(),
              isDismissible: false,
              enableDrag: false,
            );
          },
        );
      },
      child: Scaffold(
        appBar: const MainAppBar(title: "گزارش شاخص"),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: SingleChildScrollView(

            padding: const EdgeInsets.all(AppSize.s16),
            child: Column(
              children: [
                buildFiltersRow(cubit),
                const SizedBox(height: AppSize.s24),
                BlocBuilder<IndicatorReportCubit, IndicatorReportState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      idle: () => const SizedBox.shrink(),

                      loading: () => const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: AppSize.s40),
                          child: CircularProgressIndicator(),
                        ),
                      ),

                      loaded: () => IndicatorReportViewer(
                        indicatorReport: cubit.indicatorReport,
                      ),
                      orElse: SizedBox.shrink,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FiltersRow buildFiltersRow(IndicatorReportCubit cubit) {
    return FiltersRow(
      filters: [
        ValueListenableBuilder(
          valueListenable: cubit.selectedFromDateNotifier,
          builder: (_, fromDate, __) {
            return ValueListenableBuilder(
              valueListenable: cubit.selectedToDateNotifier,
              builder: (_, toDate, __) {
                return FilterButton(
                  title: fromDate != null || toDate != null
                      ? "تاریخ انتخاب شده"
                      : "فیلتر بر اساس تاریخ",
                  expand: true,
                  overlayBuilder: (context, position, width, dismiss) {
                    return DateDropdown(
                      position: position,
                      width: width + 50,
                      onDismiss: dismiss,
                      onApply: (from, to) {
                        if (from != null) cubit.setFromDate(from.toDateTime());
                        if (to != null) cubit.setToDate(to.toDateTime());
                        cubit.loadReports();
                        dismiss();
                      },
                    );
                  },
                );
              },
            );
          },
        ),
        ValueListenableBuilder(
          valueListenable: cubit.selectedServiceTypeNotifier,
          builder: (_, serviceType, __) {
            return FilterButton(
              title: serviceType.label,
              expand: true,
              overlayBuilder: (context, position, width, dismiss) {
                return OverlayDropdownMenu<ServiceType>(
                  position: position,
                  width: width,
                  items: ServiceType.values,
                  onDismiss: dismiss,
                  onSelect: (value) {
                    cubit.setServiceType(value);
                    dismiss();
                  },
                );
              },
            );
          },
        )
      ],
    );
  }
}
