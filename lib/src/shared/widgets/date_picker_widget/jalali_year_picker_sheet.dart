import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';

class JalaliYearPickerSheet extends StatefulWidget {
  const JalaliYearPickerSheet({
    super.key,
    required this.firstYear,
    required this.lastYear,
    required this.selectedYear,
    required this.onYearChanged,
  });

  final int firstYear;
  final int lastYear;
  final int selectedYear;
  final ValueChanged<int> onYearChanged;

  @override
  State<JalaliYearPickerSheet> createState() => _JalaliYearPickerSheetState();
}

class _JalaliYearPickerSheetState extends State<JalaliYearPickerSheet> {
  late int _selectedYear;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _selectedYear = widget.selectedYear;
    final selectedIndex = widget.lastYear - widget.selectedYear;
    final row = selectedIndex ~/ 3;
    _scrollController = ScrollController(
      initialScrollOffset: (row * 58).toDouble(),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final years = List<int>.generate(
      widget.lastYear - widget.firstYear + 1,
      (index) => widget.lastYear - index,
      growable: false,
    );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TitleMediumText(
            text: 'انتخاب سال',
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSize.s16),
          SizedBox(
            height: 330,
            child: GridView.builder(
              controller: _scrollController,
              itemCount: years.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.8,
                mainAxisSpacing: AppSize.s8,
                crossAxisSpacing: AppSize.s8,
              ),
              itemBuilder: (context, index) {
                final year = years[index];
                return _YearItem(
                  year: year,
                  isSelected: year == _selectedYear,
                  onTap: () {
                    setState(() => _selectedYear = year);
                    widget.onYearChanged(year);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _YearItem extends StatelessWidget {
  const _YearItem({
    required this.year,
    required this.isSelected,
    required this.onTap,
  });

  final int year;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: isSelected
          ? theme.colorScheme.primaryContainer
          : theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(AppSize.s8),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSize.s8),
        onTap: onTap,
        child: Center(
          child: BodyMediumText(
            text: year.toString(),
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
