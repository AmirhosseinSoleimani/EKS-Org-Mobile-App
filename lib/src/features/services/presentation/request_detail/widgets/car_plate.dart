import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class CarPlate extends StatelessWidget {
  const CarPlate({
    super.key,
    this.firstCarTag,
    this.secondCarTag,
    this.thirdCarTag,
    this.fourthCarTag,
    this.textStyle,
  });

  final String? firstCarTag;
  final String? secondCarTag;
  final String? thirdCarTag;
  final String? fourthCarTag;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.colorScheme.onSurface;
    final plateTextStyle = textStyle ?? theme.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: AppSize.s14,
    );
    final plateNumber = [
      thirdCarTag,
      secondCarTag,
      firstCarTag,
    ].where((e) => e?.isNotEmpty ?? false).join(' ');
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(width: AppSize.s2, color: borderColor),
        borderRadius: BorderRadius.circular(AppSize.s4),
      ),
      child: LayoutBuilder(
        builder: (_, boxConstraints) {
          return Row(
            children: [
              SizedBox(
                width: boxConstraints.maxWidth / 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ایران',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: plateTextStyle,
                    ),
                    Text(
                      fourthCarTag ?? ' ',
                      style: plateTextStyle,
                    ),
                  ],
                ),
              ),
              VerticalDivider(
                width: AppSize.s2,
                color: Theme.of(context).colorScheme.onSurface,
                thickness: AppSize.s1,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    plateNumber,
                    maxLines: 1,
                    style: plateTextStyle,
                  ),
                ),
              ),
              DecoratedBox(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSize.s4),
                    bottomLeft: Radius.circular(AppSize.s4),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppSize.s4),
                      bottomLeft: Radius.circular(AppSize.s4)),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSize.s2),
                    child: Image.asset(
                      ImageManager.iranFlag,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
