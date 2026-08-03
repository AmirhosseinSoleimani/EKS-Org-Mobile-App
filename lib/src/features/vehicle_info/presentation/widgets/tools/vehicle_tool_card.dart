import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_tool_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selectable_list_item.dart';
import 'package:flutter/material.dart';

class VehicleToolCard extends StatelessWidget {
  const VehicleToolCard({
    super.key,
    required this.tool,
    this.onTap,
  });

  final VehicleToolEntity tool;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SelectableListItem(
      title: tool.emdadToolsTitle,
      selected: tool.isSelectable,
      onTap: onTap,
    );
  }
}
