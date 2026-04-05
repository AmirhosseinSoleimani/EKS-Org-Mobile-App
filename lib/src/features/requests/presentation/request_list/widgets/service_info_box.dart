import 'package:eks_sana_plus_org/src/features/requests/presentation/request_list/widgets/info_box_item.dart';
import 'package:eks_sana_plus_org/src/shared/extensions/string_extensions.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class ServiceInfoBox extends StatelessWidget {
  final String serviceTime;
  final String serviceDate;
  final String address;
  final Color themeColor;

  const ServiceInfoBox({
    super.key,
    required this.serviceTime,
    required this.serviceDate,
    required this.address,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: themeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppPadding.p8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:AppPadding.p20, horizontal:AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InfoBoxItem(
                  icon: Icons.access_time_outlined,
                  text: serviceTime.to12HourFormat(),
                  iconBackgroundColor: themeColor.withOpacity(0.8),
                ),
                const SizedBox(width: AppPadding.p16),
                InfoBoxItem(
                  icon: Icons.calendar_today_outlined,
                  text: serviceDate,
                  iconBackgroundColor: themeColor.withOpacity(0.8),
                ),
              ],
            ),
            Space.h24,
            InfoBoxItem(
              icon: Icons.location_on_outlined,
              text: address,
              iconBackgroundColor: themeColor.withOpacity(0.8),
            ),
          ],
        ),
      ),
    );
  }
}
