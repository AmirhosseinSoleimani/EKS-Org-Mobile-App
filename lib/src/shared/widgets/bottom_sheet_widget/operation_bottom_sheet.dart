import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class OperationBottomSheetEntry {
  const OperationBottomSheetEntry({
    required this.child,
    this.dividerAfter,
  });

  final Widget child;
  final Widget? dividerAfter;
}

class OperationBottomSheet extends StatelessWidget {
  const OperationBottomSheet({
    super.key,
    required this.entries,
  });

  static const double itemSpacing = AppSize.s8;

  final List<OperationBottomSheetEntry> entries;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) return const SizedBox.shrink();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var index = 0; index < entries.length; index++) ...[
            entries[index].child,
            if (index < entries.length - 1)
              _OperationItemSpacing(
                divider: entries[index].dividerAfter,
              ),
          ],
        ],
      ),
    );
  }
}

class _OperationItemSpacing extends StatelessWidget {
  const _OperationItemSpacing({this.divider});

  final Widget? divider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: OperationBottomSheet.itemSpacing,
      width: double.infinity,
      child: divider == null
          ? null
          : Center(
              child: SizedBox(
                width: double.infinity,
                child: divider,
              ),
            ),
    );
  }
}
