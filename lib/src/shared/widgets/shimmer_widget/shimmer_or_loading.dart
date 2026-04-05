import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/ek_loading.dart';
import 'package:flutter/material.dart';

class ShimmerOrLoading extends StatelessWidget {
  const ShimmerOrLoading({super.key, required this.shimmer});
  final Widget shimmer;

  @override
  Widget build(BuildContext context) {
    return AppConstants.isIOS ? const Center(child: EkLoading()) : shimmer;
  }
}
