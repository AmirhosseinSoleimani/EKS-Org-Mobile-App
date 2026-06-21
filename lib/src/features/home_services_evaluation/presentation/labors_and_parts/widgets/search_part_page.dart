import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/cubit/labors_and_parts_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/cubit/labors_and_parts_state.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/searchable_dropdown_selector.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_and_registration_part_widget.dart';

class SearchPartHomeServicePage extends StatelessWidget {
  const SearchPartHomeServicePage({
    super.key,
    required this.serviceIndex,
    required this.laborIndex,
  });

  final int laborIndex;
  final int serviceIndex;
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = getIt<LaborsAndPartsCubit>();
        bloc.initState();
        return bloc;
      },
      child: Builder(
        builder: (context) {
          return _build(context);
        },
      ),
    );
  }

  Widget _build(BuildContext context) {
    final cubit = context.read<LaborsAndPartsCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SimpleAppBar(title: 'جستجوی قطعه'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<LaborsAndPartsCubit, LaborsAndPartsState>(
          builder: (BuildContext context, state) {
            final isLoading = state.maybeWhen(
              partLoading: () => true,
              orElse: () => false,
            );
            return StreamBuilder<List<PartResponseEntity?>>(
              stream: cubit.partResponseListSubject.stream,
              builder: (context, snapshot) {
                final items = snapshot.data ?? [];
                return SearchableDropdownSelector<PartResponseEntity>(
                    label: 'قطعه',
                    hintText: 'حداقل ۳ کاراکتر وارد کنید',
                    controller: cubit.searchPartController,
                    selectedNotifier: cubit.selectPartResponseEntity,
                    items: items.whereType<PartResponseEntity>().toList(),
                    isLoading: isLoading,
                    itemTitleBuilder: (item) => item.name ?? '',
                    onSearchChanged: (value) {
                    if (value.length >= 3) {
                      cubit.getPart(
                        value: value,
                        laborIndex: laborIndex,
                        serviceIndex: serviceIndex,
                      );
                    }
                  },
                    onSelect: (item) {
                      if (item.serial !=
                          null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) {
                                final list = cubit.partResponseListSubject
                                    .valueOrNull ?? [];

                                final index = list.indexWhere((e) =>
                                e?.serial == item.serial);
                                return EditAndRegistrationPartWidget(
                                  serviceIndex:
                                  serviceIndex,
                                  laborIndex: laborIndex,
                                  partIndex: index,
                                  partResponseEntity: item,
                                );
                              }

                          ),
                        );
                      }
                    }
                );
              },
            );
          },
        ),
      ),
    );
  }
}
