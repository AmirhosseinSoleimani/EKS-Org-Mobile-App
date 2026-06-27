import 'package:flutter/material.dart';

class RouteMapEmptyState extends StatelessWidget {
  const RouteMapEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xffF3F4F6),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        'مسیر قابل نمایش نیست',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
