import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:flutter/material.dart';

class MapPinMarker extends StatelessWidget {
  final String iconPath;

  final Color color;

  const MapPinMarker({super.key, required this.iconPath, required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgWidget(
          src: SvgAsset(iconPath),
          width: AppSize.s48,
          height: AppSize.s48,
        ),
      ],
    );
  }
}
