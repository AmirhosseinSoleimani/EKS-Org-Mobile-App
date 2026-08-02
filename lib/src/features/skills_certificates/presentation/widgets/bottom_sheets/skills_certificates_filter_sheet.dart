import 'package:eks_sana_plus_org/src/features/skills_certificates/presentation/cubit/skills_certificates_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SkillsCertificatesFilterSheet extends StatefulWidget {
  const SkillsCertificatesFilterSheet({super.key});

  @override
  State<SkillsCertificatesFilterSheet> createState() =>
      _SkillsCertificatesFilterSheetState();
}

class _SkillsCertificatesFilterSheetState
    extends State<SkillsCertificatesFilterSheet> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height -
        mediaQuery.viewInsets.bottom -
        mediaQuery.padding.top;

    return SizedBox(
      height: availableHeight * 0.28,
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
              child: Text(
                'فیلتر گواهینامه مهارت',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Space.h16,
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p8,
                ),
                child: Column(
                  children: [
                    TextFormFieldWidget(
                      controller: context
                          .read<SkillsCertificatesCubit>()
                          .titleFilterController,
                      labelText: 'عنوان',
                      maxLength: 20,
                      textInputAction: TextInputAction.next,
                    ),
                  ],
                ),
              ),
            ),
            _BottomActions(
              onApply: _apply,
              onClear: _clear,
            ),
          ],
        ),
      ),
    );
  }

  void _apply() {
    FocusScope.of(context).unfocus();
    context.read<SkillsCertificatesCubit>().submitFilters();
    Navigator.of(context).pop();
  }

  void _clear() {
    FocusScope.of(context).unfocus();
    context.read<SkillsCertificatesCubit>().clearFilters();
    Navigator.of(context).pop();
  }

}

class _BottomActions extends StatelessWidget {
  const _BottomActions({
    required this.onApply,
    required this.onClear,
  });

  final VoidCallback onApply;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: InkwellButtonWidget(
            title: 'اعمال فیلتر',
            onTap: onApply,
          ),
        ),
        Space.w16,
        Expanded(
          child: InkwellButtonWidget(
            title: 'پاک کردن',
            backgroundColor: theme.colorScheme.onPrimary,
            borderColor: theme.colorScheme.outline.withOpacity(0.65),
            titleColor: theme.colorScheme.onSurface,
            onTap: onClear,
          ),
        ),
      ],
    );
  }
}
