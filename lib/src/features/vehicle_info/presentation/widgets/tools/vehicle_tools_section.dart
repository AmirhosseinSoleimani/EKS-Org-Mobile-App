import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_tool_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/tools/vehicle_tool_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selection_group_header.dart';
import 'package:flutter/material.dart';

class VehicleToolsSection extends StatelessWidget {
  const VehicleToolsSection({
    super.key,
    required this.tools,
    required this.onSelect,
  });

  final List<VehicleToolEntity> tools;
  final ValueChanged<int>? onSelect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SelectionGroupHeader(
            title: 'ابزارها',
            icon: Icons.build_outlined,
          ),
          Space.h12,
          ...tools.map(
            (tool) => Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p8),
              child: VehicleToolCard(
                tool: tool,
                onTap: onSelect == null
                    ? null
                    : () => onSelect!(tool.emdadToolsId),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
