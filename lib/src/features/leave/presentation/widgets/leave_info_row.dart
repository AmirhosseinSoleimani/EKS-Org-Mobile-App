import 'package:flutter/material.dart';

class LeaveInfoRow extends StatelessWidget {
  const LeaveInfoRow({
    super.key,
    required this.icon,
    required this.label,
    this.value,
    this.ltr = false,
  });

  final IconData icon;
  final String label;
  final String? value;
  final bool ltr;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF666666)),
          const SizedBox(width: 8),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: '$label: ',
                style: textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF555555),
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: value?.trim().isNotEmpty == true ? value! : '---',
                    style: textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF333333),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              textDirection: ltr ? TextDirection.ltr : TextDirection.rtl,
              textAlign: ltr ? TextAlign.right : TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}

