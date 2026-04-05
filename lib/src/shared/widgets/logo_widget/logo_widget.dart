import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/cupertino.dart';

class LogoWidget extends StatelessWidget{
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageManager.logo,
      fit: BoxFit.contain,
      height: AppSize.s64,
    );
  }

}