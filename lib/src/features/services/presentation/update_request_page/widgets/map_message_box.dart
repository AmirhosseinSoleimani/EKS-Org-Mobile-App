import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class MapMessageBox extends StatelessWidget {
  final String message;

  const MapMessageBox({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    if (message.isEmpty) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(AppSize.s12),
      decoration: BoxDecoration(
        color: Colors.red.withAlpha(180),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("•", style: TextStyle(color: Colors.red)),
          const SizedBox(width: 6),
          Expanded(
            child: BodySmallText(text: message, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
