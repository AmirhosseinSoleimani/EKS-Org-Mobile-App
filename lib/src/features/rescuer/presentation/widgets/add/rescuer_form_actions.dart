import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class RescuerFormActions extends StatelessWidget {
  final int step;
  final bool loading;
  final VoidCallback onNext, onPrevious;

  const RescuerFormActions({
    super.key,
    required this.step,
    required this.loading,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(30), blurRadius: 10),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: InkwellButtonWidget(
                title: step == 0 ? 'انصراف' : 'مرحله قبل',
                backgroundColor: Colors.white,
                titleColor: colorScheme.onPrimaryFixed,
                borderColor:colorScheme.onPrimaryFixed,
                onTap: loading ? null : onPrevious,
                prefixIcon: Icon(Icons.arrow_back_rounded, color: colorScheme.onPrimaryFixed,),
              ),
            ),

            const SizedBox(width: 12),
            Expanded(
              child: InkwellButtonWidget(
                title: step == 3 ? 'ثبت' : 'مرحله بعد',
                showLoading: loading,
                backgroundColor: Theme.of(context).colorScheme.primary,
                suffixIcon: Icon(Icons.arrow_forward_rounded, color: colorScheme.onPrimary,),
                onTap: loading ? null : onNext,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
