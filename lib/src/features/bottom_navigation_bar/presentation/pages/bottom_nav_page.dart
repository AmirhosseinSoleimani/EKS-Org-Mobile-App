import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BottomNavPage({
    super.key,
    required this.navigationShell,
  });

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final selectedColor = colorScheme.primary;
    final unselectedColor = colorScheme.secondaryFixed;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _onTap,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: selectedColor,
        unselectedItemColor: unselectedColor,
        elevation: 16,

        selectedLabelStyle: const TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w500,
        ),
        items: [
          BottomNavigationBarItem(
            icon: _BottomNavSvgIcon(src: SvgManager.homeIcon,
              color: colorScheme.onTertiaryFixed,), 
            label: "داشبورد",
            activeIcon: _BottomNavSvgIcon(
              src: SvgManager.homeIcon,
              color: colorScheme.primary,
            ),
          ),
          BottomNavigationBarItem(
            icon: _BottomNavSvgIcon(src: SvgManager.dashboardIconOutline,
              color: colorScheme.onTertiaryFixed,),
            activeIcon: _BottomNavSvgIcon(
              src: SvgManager.dashboardIcon,
              color: colorScheme.primary,
            ),
            label: "پیشخوان",
          ),
          BottomNavigationBarItem(
            icon: _BottomNavSvgIcon(src: SvgManager.assignmentIcon,
              color: colorScheme.onTertiaryFixed,),
            activeIcon: _BottomNavSvgIcon(
              src: SvgManager.assignmentIcon,
              color: colorScheme.primary,
            ),
            label: "گزارش ها",
          ),
        ],
      ),
    );
  }
}

class _BottomNavSvgIcon extends StatelessWidget {
  final String src;
  final Color color;

  const _BottomNavSvgIcon({
    required this.src,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8,top: 4),
      child: SvgWidget(
        src: SvgAsset(src),
        color: color,
      ),
    );
  }
}
