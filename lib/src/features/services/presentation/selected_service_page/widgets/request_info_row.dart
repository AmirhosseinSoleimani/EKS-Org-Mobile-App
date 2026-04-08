import 'package:flutter/material.dart';

class RequestInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const RequestInfoRow({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.grey,
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Text(text),
        )
      ],
    );
  }
}
