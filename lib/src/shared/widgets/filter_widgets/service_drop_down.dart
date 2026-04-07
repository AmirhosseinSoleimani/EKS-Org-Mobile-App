import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class ServiceDropdown extends StatelessWidget {
  final Offset position;
  final double width;
  final VoidCallback onDismiss;
  final ValueChanged<ServiceType> onSelect;

  const ServiceDropdown({
    super.key,
    required this.position,
    required this.width,
    required this.onDismiss,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onDismiss,
          behavior: HitTestBehavior.translucent,
          child: const SizedBox.expand(),
        ),
        Positioned(
          top: position.dy + AppSize.s40,
          left: position.dx,
          width: width,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(AppSize.s8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: ServiceType.values
                  .map((type) => InkWell(
                        onTap: () => onSelect(type),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p12,
                            vertical: AppPadding.p10,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: AppSize.s10,
                                height: AppSize.s10,
                                decoration: BoxDecoration(
                                  color: type.serviceColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Space.w8,
                              Text(type.label),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
