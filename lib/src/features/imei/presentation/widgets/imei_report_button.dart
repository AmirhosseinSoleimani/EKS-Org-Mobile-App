import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:flutter/material.dart';

class ImeiReportButton extends StatelessWidget {
  const ImeiReportButton({
    super.key,
    required this.isLoading,
    required this.onTap,
  });

  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkwellButtonWidget(
      title: 'گزارش گیری',
      titleColor: colorScheme.onSurface,
      showLoading: isLoading,
      loadingColor: colorScheme.onSurface,
      prefixIcon: SvgWidget(src: SvgAsset(SvgManager.exportNotes)),
      backgroundColor: colorScheme.surface,
      borderColor: colorScheme.outline,
      onTap: onTap,
    );
  }
}
