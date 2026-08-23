import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/agency_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgencyInfoSelector extends StatelessWidget {
  const AgencyInfoSelector({
    super.key,
    required this.onSelected,
    this.title = 'انتخاب نمایندگی',
  });

  final ValueChanged<AgencyInfoEntity> onSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AgencyInfoCubit>(),
      child: _AgencyInfoSelectorView(onSelected: onSelected, title: title),
    );
  }
}

class _AgencyInfoSelectorView extends StatelessWidget {
  const _AgencyInfoSelectorView({
    required this.onSelected,
    required this.title,
  });

  final ValueChanged<AgencyInfoEntity> onSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AgencyInfoCubit>();

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: AppPadding.p16,
          right: AppPadding.p16,
          top: AppPadding.p16,
          bottom: MediaQuery.of(context).viewInsets.bottom + AppPadding.p16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
            Space.h16,
            TextFormFieldWidget(
              controller: cubit.selectorSearchController,
              labelText: 'جستجوی نام نمایندگی',
              prefixIcon: const Icon(Icons.search_rounded),
              onChanged: cubit.searchForSelector,
            ),
            Space.h12,
            Flexible(
              child: BlocBuilder<AgencyInfoCubit, AgencyInfoState>(
                builder: (context, state) {
                  final data = state.data;
                  if (data.isSelectorLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (data.selectorItems.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(AppPadding.p16),
                      child: Center(child: Text('برای جستجو حداقل دو حرف وارد کنید.')),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: data.selectorItems.length,
                    separatorBuilder: (_, __) => Space.h12,
                    itemBuilder: (context, index) {
                      final item = data.selectorItems[index];
                      return AgencyInfoSummaryCard(
                        item: item,
                        onTap: () {
                          onSelected(item);
                          Navigator.of(context).pop();
                        },
                        trailing: const Icon(Icons.check_circle_outline_rounded),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
