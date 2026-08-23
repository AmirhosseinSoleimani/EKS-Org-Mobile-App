import 'package:eks_sana_plus_org/src/features/skills_certificates/presentation/cubit/skills_certificates_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SkillsCertificatesFilterSheet extends StatelessWidget {
  const SkillsCertificatesFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return FilterBottomSheetScaffold(
      title: 'فیلترها',
      onApply: () => _apply(context),
      onClear: () => _clear(context),
      child: TextFormFieldWidget(
        controller: context.read<SkillsCertificatesCubit>().titleFilterController,
        labelText: 'عنوان',
        maxLength: 20,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  void _apply(BuildContext context) {
    FocusScope.of(context).unfocus();
    context.read<SkillsCertificatesCubit>().submitFilters();
    Navigator.of(context).pop();
  }

  void _clear(BuildContext context) {
    FocusScope.of(context).unfocus();
    context.read<SkillsCertificatesCubit>().clearFilters();
    Navigator.of(context).pop();
  }
}
