import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';

enum Gender {
  female(0, 'خانم', SvgManager.female),
  male(1, 'آقا', SvgManager.male);

  final int value;
  final String label;
  final String icon;

  const Gender(this.value, this.label, this.icon);
}
