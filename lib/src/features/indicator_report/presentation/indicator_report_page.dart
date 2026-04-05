import 'package:flutter/material.dart';

class IndicatorReportPage extends StatelessWidget {
  static const path = "/indicator-report";
  static const name = "indicator-report";

  const IndicatorReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("گزارش شاخص")),
    );
  }
}
