import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/indicator_report_cubit.dart';
import 'widgets/indicator_filters_row.dart';
import 'widgets/app_bar/indicator_report_app_bar.dart';
import 'widgets/indicator_report_list.dart';

class IndicatorReportPage extends StatelessWidget {
  static const path = "/indicator-report";
  static const name = "indicator-report";

  const IndicatorReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => IndicatorReportCubit()..loadReports(),
      child: const _IndicatorReportView(),
    );
  }
}

class _IndicatorReportView extends StatelessWidget {
  const _IndicatorReportView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IndicatorReportAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const IndicatorFiltersRow(),
            const SizedBox(height: 20),
            BlocBuilder<IndicatorReportCubit, IndicatorReportState>(
              builder: (context, state) {
                return state.when(
                  idle: () => const SizedBox(),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  loaded: () => IndicatorReportList(items: []),
                  error: (message) => Center(child: Text(message)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
