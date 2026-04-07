import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/indicator_report_cubit.dart';
import '../../../../shared/widgets/app_bar_widget/main_app_bar.dart';
import 'widgets/indicator_filters_row.dart';
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
    return BlocListener<IndicatorReportCubit, IndicatorReportState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            BottomSheetMessage.showErrorWithAction(
              context: context,
              data: message,
              onPositive: context.read<IndicatorReportCubit>().loadReports,
            );
          },
          connectionError: () {
            final cubit = context.read<IndicatorReportCubit>();

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
                const IndicatorFiltersRow(),
                const SizedBox(height: AppSize.s24),
                BlocBuilder<IndicatorReportCubit, IndicatorReportState>(
                  builder: (context, state) {
                    final cubit = context.read<IndicatorReportCubit>();

                    return state.when(
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

                      error: (_) => cubit.indicatorReport != null
                          ? IndicatorReportViewer(
                        indicatorReport: cubit.indicatorReport,
                      )
                          : const SizedBox.shrink(),

                      connectionError: () => cubit.indicatorReport != null
                          ? IndicatorReportViewer(
                        indicatorReport: cubit.indicatorReport,
                      )
                          : const SizedBox.shrink(),
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
}
