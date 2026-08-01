import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:flutter/material.dart';

class MapPinMarker extends StatelessWidget {
  final String iconPath;

  final Color? color;

  const MapPinMarker({super.key, required this.iconPath,  this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if(color != null)...[
          //customer marker color is null and it don't need white background
          SvgWidget(
            src: SvgAsset(SvgManager.emptyMarker),
            color: Colors.white,
            width: AppSize.s48,
            height: AppSize.s48,
          ),
        ],

        SvgWidget(
          src: SvgAsset(iconPath),
          color: color,
          width: AppSize.s48,
          height: AppSize.s48,
        ),
      ],
    );
  }
}
