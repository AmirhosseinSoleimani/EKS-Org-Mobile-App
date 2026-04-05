import 'package:eks_sana_plus_org/src/shared/resources/color_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EkLoading extends StatelessWidget {
  const EkLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitCircle(
        size: AppSize.s28,
        duration: Duration(milliseconds: 750),
        color: ColorLightManager.outline,
      ),
    );
  }
}
