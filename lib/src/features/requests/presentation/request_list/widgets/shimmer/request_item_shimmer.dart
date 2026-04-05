import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RequestItemShimmer extends StatelessWidget {
  const RequestItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSize.s8),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s12),
        border: Border.all(color: colorScheme.onInverseSurface),
      ),
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- Status Row ----
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _box(
                    width: AppSize.s80,
                    height: AppSize.s24,
                    borderRadius: AppPadding.p24),
                Space.w12,
                _box(
                    width: AppSize.s80,
                    height: AppSize.s24,
                    borderRadius: AppPadding.p24),
              ],
            ),
            Space.h20,
            Row(
              children: [
                _box(
                    width: AppSize.s54,
                    height: AppSize.s54,
                    borderRadius: AppPadding.p10),
                Space.w12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _box(width: AppSize.s128, height: AppSize.s14),
                      Space.h8,
                      _box(width: AppSize.s110, height: AppSize.s14),
                    ],
                  ),
                ),
              ],
            ),
            Space.h20,

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _box(
                    width: AppSize.s54,
                    height: AppSize.s54,
                    borderRadius: AppPadding.p10),
                Space.w12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _box(width: AppSize.s128, height: AppSize.s14),
                      Space.h8,
                      _box(width: AppSize.s110, height: AppSize.s14),
                    ],
                  ),
                ),
                Space.w12,
                _box(
                    width: AppSize.s90,
                    height: AppSize.s24,
                    borderRadius: AppPadding.p24),
              ],
            ),
            Space.h20,

            // ---- Service Info Box ----
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              height: AppSize.s120,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(AppSize.s12),
              ),
            ),
            Space.h20,
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              height: AppSize.s48,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(AppSize.s12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _box(
      {required double width,
      required double height,
      double borderRadius = AppSize.s6}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
