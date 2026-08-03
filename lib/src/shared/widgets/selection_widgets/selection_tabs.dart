import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class SelectionTab<T> {
  const SelectionTab({required this.value, required this.title});

  final T value;
  final String title;
}

class SelectionTabs<T> extends StatelessWidget {
  const SelectionTabs({
    super.key,
    required this.tabs,
    required this.selectedValue,
    required this.onChanged,
  });

  final List<SelectionTab<T>> tabs;
  final T selectedValue;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    if (tabs.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Row(
      children: tabs.map((tab) {
        final selected = tab.value == selectedValue;

        return Expanded(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onChanged(tab.value),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: AppSize.s48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: selected ? primary : theme.dividerColor,
                      width: selected ? 3 : AppSize.s1,
                    ),
                  ),
                ),
                child: Text(
                  tab.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: selected ? primary : theme.colorScheme.onSurface,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(growable: false),
    );
  }
}
