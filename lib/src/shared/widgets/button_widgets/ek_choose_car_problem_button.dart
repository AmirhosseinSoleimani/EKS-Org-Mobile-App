
import 'package:flutter/material.dart';

import '../../resources/value_manager.dart';

class EkChooseCarProblemButton extends StatelessWidget {
  const EkChooseCarProblemButton({
    super.key,
    required this.title,
    this.onTap,
    this.label,
    this.height,
    this.width,
    this.borderRadius = 8,
    this.backgroundColor,
    this.titleColor,
    this.showLoading,
  });

  final VoidCallback? onTap;
  final String? title;
  final String? label;
  final double? height;
  final double? width;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? titleColor;
  final bool? showLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: height ?? 50,
        width: width ?? double.infinity,
        child: InputDecorator(
          isEmpty: title == null || title!.isEmpty,

          decoration: InputDecoration(
            labelText: "$label *",

            labelStyle: theme.textTheme.bodyMedium,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: theme.colorScheme.inverseSurface,
              ),
            ),


            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 1.2,
              ),
            ),

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),

            suffixIcon: showLoading == true
                ? const Padding(
              padding: EdgeInsets.all(12),
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
                : const Icon(Icons.keyboard_arrow_down_rounded),
          ),

          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              title?.isNotEmpty == true ? title! : 'انتخاب کنید',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: title == null || title!.isEmpty
                    ? Colors.grey
                    : theme.colorScheme.onSurface,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
