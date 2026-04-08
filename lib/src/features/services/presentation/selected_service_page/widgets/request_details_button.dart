import 'package:flutter/material.dart';

class RequestDetailsButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RequestDetailsButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.arrow_back),
        label: const Text("جزئیات"),
      ),
    );
  }
}
