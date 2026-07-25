import 'package:dotted_border/dotted_border.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class DottedFilePickerBox extends StatelessWidget {
  const DottedFilePickerBox({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
    this.selected = false,
    this.height = 170,
    this.icon = Icons.upload_file_outlined,
    this.selectedIcon = Icons.check_circle,
  });

  final String title;
  final String description;
  final VoidCallback onTap;
  final bool selected;
  final double height;
  final IconData icon;
  final IconData selectedIcon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSize.s12),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: const Radius.circular(AppSize.s12),
          color: const Color(0xFFDEC1AF),
          strokeWidth: AppSize.s1,
          dashPattern: const [6, 3],
        ),
        child: Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(AppSize.s12),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: AppSize.s34,
                  backgroundColor: primary.withAlpha(25),
                  child: Icon(
                    selected ? selectedIcon : icon,
                    color: primary,
                    size: AppSize.s42,
                  ),
                ),
                Space.h16,
                BodyMediumText(
                  text: title,
                  color: primary,
                  fontWeight: FontWeight.w700,
                ),
                Space.h4,
                BodyMediumText(
                  text: description,
                  fontSize: AppSize.s12,
                  color: colorScheme.onTertiaryFixed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
