import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/car_image_widget/asset_helper_car_face.dart';
import 'package:flutter/material.dart';

class CarImageWidget extends StatelessWidget {
  const CarImageWidget({super.key, required this.carModelId, this.width, this.height});
  final double? width;
  final double? height;
  final int carModelId;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      AssetHelperCarFace.getImagePathByCarModelId(
          carModelId,
      ),
      width: width ?? AppSize.s150,
      height: height ?? AppSize.s150,
      fit: BoxFit.contain,
      errorBuilder: (context, _, __) {
        return const Center(
          child: Icon(
            Icons.image_not_supported,
            size: AppSize.s80,
          ),
        );
      },
    );
  }
}
