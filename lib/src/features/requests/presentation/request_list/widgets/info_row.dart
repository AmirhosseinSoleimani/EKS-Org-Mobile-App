import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final Widget leading;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final Color? backgroundColor;
  final double borderRadius;

  const InfoRow({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.backgroundColor,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    final hasBackground = backgroundColor != null;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: hasBackground ? backgroundColor : null,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: leading,
        ),
        const SizedBox(width: 8),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 14)),
              const SizedBox(height: 6),
              Text(subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 12)),
            ],
          ),
        ),

        if (trailing != null) ...[
          const SizedBox(width: 8),
          trailing!,
        ],
      ],
    );
  }
}
