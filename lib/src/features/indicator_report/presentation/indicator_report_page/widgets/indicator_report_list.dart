import 'package:flutter/material.dart';

class IndicatorReportList extends StatelessWidget {
  final List items;

  const IndicatorReportList({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(
        child: Text("موردی یافت نشد"),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const SizedBox();
      },
    );
  }
}
