import 'package:flutter/material.dart';

class DispatchTimeDiffBox extends StatelessWidget {
  final Duration? timeDiff;

  const DispatchTimeDiffBox({super.key, required this.timeDiff});

  @override
  Widget build(BuildContext context) {
    if (timeDiff == null || timeDiff == Duration.zero) {
      return const SizedBox.shrink();
    }

    final hours = timeDiff!.inHours.toString().padLeft(2, '0');
    final minutes = (timeDiff!.inMinutes % 60).toString().padLeft(2, '0');
    final timeText = "$hours:$minutes";

    const blue = Color(0xFF1976D2);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: blue.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: blue),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.access_time_rounded, color: blue),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "اختلاف زمان با اعزام",
                style: TextStyle(color: blue, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                timeText,
                style: const TextStyle(
                  color: blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
