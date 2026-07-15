import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_tool_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/tools/vehicle_tool_state_x.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class VehicleToolChip extends StatelessWidget {
  const VehicleToolChip({
    super.key,
    required this.tool,
    required this.onTap,
  });

  final VehicleToolEntity tool;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selected = tool.isSelectedForVehicle;
    final readOnly = tool.isReadOnlyForVehicle;
    final disabled = readOnly && !selected;
    final primaryColor = theme.colorScheme.primary;
    final borderColor = selected ? primaryColor : const Color(0xFFE1E1E1);
    final backgroundColor = disabled ? const Color(0xFFE8E8E8) : Colors.white;
    final foregroundColor = disabled
        ? const Color(0xFFA59A95)
        : selected
            ? primaryColor
            : const Color(0xFF222222);

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: readOnly ? null : onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          constraints: const BoxConstraints(minHeight: 44),
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p16,
            vertical: AppPadding.p10,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: disabled ? Colors.transparent : borderColor,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selected) ...[
                Icon(Icons.check_circle_outline_rounded, size: AppSize.s16, color: foregroundColor),
                const SizedBox(width: 6),
              ],
              Text(
                tool.emdadToolsTitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (disabled) ...[
                const SizedBox(width: 6),
                Icon(Icons.lock_outline_rounded, size: AppSize.s16, color: foregroundColor),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
