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
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _onTap,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "داشبورد",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: "خدمات",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "گزارش شاخص",
          ),
        ],
      ),
    );
  }
}
