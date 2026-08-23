import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/search_input_field.dart';
import 'package:flutter/material.dart';

class SearchWithRefreshSection extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onRefreshTap;

  const SearchWithRefreshSection({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.onRefreshTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchInputField(
            controller: controller,
            hintText: hintText,
            onChanged: onChanged,
          ),
        ),

        const SizedBox(width: 8),

        SquareIconButton(
          icon: Icons.refresh,
          onTap: onRefreshTap,
        ),
      ],
    );
  }
}

class SquareIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final double iconSize;
  final Color? backgroundColor;
  final Color? iconColor;

  const SquareIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.size = 48,
    this.iconSize = 22,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            color: backgroundColor ?? colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1.5, color: colorScheme.onInverseSurface)
        ),
        child: Icon(
          icon,
          color: iconColor ?? colorScheme.onTertiaryFixed,
          size: iconSize,
        ),
      ),
    );
  }
}