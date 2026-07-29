import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/movable_map_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class DeploymentLocationMapSelector extends StatelessWidget {
  const DeploymentLocationMapSelector({
    super.key,
    required this.onTap,
    this.latitude,
    this.longitude,
    this.hasSelectedLocation = false,
  });

  final VoidCallback onTap;
  final double? latitude;
  final double? longitude;
  final bool hasSelectedLocation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveLatitude = latitude ?? AppConstants.defaultLatitude;
    final effectiveLongitude = longitude ?? AppConstants.defaultLongitude;

    return SizedBox(
      height: 270,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSize.s8),
        child: Stack(
          children: [
            Positioned.fill(
              child: AbsorbPointer(
                child: MovableMapWidget(
                  latitude: effectiveLatitude,
                  longitude: effectiveLongitude,
                  zoom: 15,
                ),
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(onTap: onTap),
              ),
            ),
            PositionedDirectional(
              start: AppPadding.p12,
              end: AppPadding.p12,
              bottom: AppPadding.p12,
              child: IgnorePointer(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p12,
                    vertical: AppPadding.p8,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onPrimary.withOpacity(0.92),
                    borderRadius: BorderRadius.circular(AppSize.s8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        hasSelectedLocation
                            ? Icons.check_circle_outline
                            : Icons.touch_app_outlined,
                        color: hasSelectedLocation
                            ? theme.colorScheme.onError
                            : theme.colorScheme.primary,
                        size: AppSize.s20,
                      ),
                      Space.w8,
                      Flexible(
                        child: BodyMediumText(
                          text: hasSelectedLocation
                              ? 'موقعیت انتخاب شده است؛ برای تغییر بزنید.'
                              : 'برای انتخاب موقعیت روی نقشه بزنید.',
                          color: theme.colorScheme.onSurface,
                          fontSize: AppSize.s14,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
