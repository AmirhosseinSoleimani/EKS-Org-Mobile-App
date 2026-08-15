import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/common/models/emdadgar_invoice_status_style.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/emdadgar_invoice_details/models/emdadgar_invoice_details_args.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/theme/app_semantic_colors.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:flutter/material.dart';

class EmdadgarInvoiceDetailsStatusRow extends StatelessWidget {
  const EmdadgarInvoiceDetailsStatusRow({
    super.key,
    required this.args,
  });

  final EmdadgarInvoiceDetailsArgs args;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final semanticColors = theme.extension<AppSemanticColors>()!;
    final state = args.item.state;
    final statusTitle = _statusTitle;
    final statusPalette = EmdadgarInvoiceStatusType.resolve(
      status: state?.invoiceStatus,
      title: statusTitle,
    ).palette(
      semanticColors: semanticColors,
      colorScheme: theme.colorScheme,
    );

    return Wrap(
      spacing: AppSize.s8,
      runSpacing: AppSize.s8,
      children: [
        StatusLabel(
          text: statusTitle,
          color: statusPalette.textColor,
          backgroundColor: statusPalette.backgroundColor,
        ),
        StatusLabel(
          text: state?.subscription == true ? 'مشترک' : 'غیر مشترک',
          color: state?.subscription == true
              ? semanticColors.confirmation
              : theme.colorScheme.onPrimaryFixed,
          backgroundColor: state?.subscription == true
              ? Color.lerp(
                  theme.colorScheme.onPrimary,
                  semanticColors.confirmation,
                  .14,
                )
              : theme.colorScheme.secondaryContainer,
        ),
        StatusLabel(
          text: state?.isGaranty == true ? 'دارای گارانتی' : 'بدون گارانتی',
          color: state?.isGaranty == true
              ? semanticColors.confirmation
              : theme.colorScheme.onPrimaryFixed,
          backgroundColor: state?.isGaranty == true
              ? Color.lerp(
                  theme.colorScheme.onPrimary,
                  semanticColors.confirmation,
                  .14,
                )
              : theme.colorScheme.secondaryContainer,
        ),
      ],
    );
  }

  String get _statusTitle {
    final value = args.item.state?.invoiceStatusTitle?.trim();
    return value == null || value.isEmpty ? args.stage.title : value;
  }
}
