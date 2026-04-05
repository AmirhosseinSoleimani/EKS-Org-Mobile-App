import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key, this.height});

  final double? height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: DurationConstant.d1000,
      baseColor: Theme.of(context).colorScheme.onSecondary,
      highlightColor: Theme.of(context).colorScheme.surface,
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius:
            const BorderRadius.all(Radius.circular(AppPadding.p6)),
            border: Border.all(
                width: AppSize.s1,
                color: Theme.of(context).colorScheme.onSecondary),
            color: Theme.of(context).colorScheme.primaryContainer),
        child: SizedBox(
          height: height ?? AppSize.s150,
          width: double.infinity,
        ),
      ),
    );
  }
}
