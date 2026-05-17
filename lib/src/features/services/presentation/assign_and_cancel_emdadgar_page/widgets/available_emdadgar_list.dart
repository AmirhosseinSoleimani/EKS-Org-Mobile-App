import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_entity.dart';
import 'package:flutter/material.dart';

import 'emdadgar_item.dart';

class AvailableEmdadgarList extends StatelessWidget {
  final List<EmdadgarEntity> emdadgarList;

  const AvailableEmdadgarList({
    super.key,
    required this.emdadgarList,
  });

  @override
  Widget build(BuildContext context) {
    if (emdadgarList.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("امداد رسان های در دسترس"),
        const SizedBox(height: 12),
        Column(
          children: emdadgarList
              .map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: EmdadgarItem(entity: e),
          ))
              .toList(),
        ),
      ],
    );
  }
}
