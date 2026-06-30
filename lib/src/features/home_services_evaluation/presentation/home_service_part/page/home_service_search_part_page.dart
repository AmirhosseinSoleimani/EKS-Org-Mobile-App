
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_part/cubit/home_service_part_cubit.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_part/cubit/home_service_part_state.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/searchable_dropdown_selector.dart';

import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_service_part_page.dart';

class HomeServiceSearchPartPage extends StatelessWidget {
  const HomeServiceSearchPartPage({
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
        final bloc = getIt<HomeServicePartCubit>();
        bloc.initState(
          laborIndex: laborIndex,
          serviceIndex: serviceIndex,
        );
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
    final cubit = context.read<HomeServicePartCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.onPrimary,
      appBar: SimpleAppBar(title: 'جستجوی قطعه'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<HomeServicePartCubit, HomeServicePartState>(
          builder: (context, state) {
            return SearchableDropdownSelector<PartResponseEntity>(
              label: 'نام قطعه',
              hintText: 'حداقل ۳ کاراکتر وارد کنید',
              controller: cubit.searchPartController,
              selectedNotifier: ValueNotifier<PartResponseEntity?>(null),

              items: cubit.partResponseListSubject.valueOrNull
                  ?.whereType<PartResponseEntity>()
                  .toList() ??
                  [],

              isLoading: state.maybeWhen(
                loading: () => true,
                orElse: () => false,
              ),

              itemTitleBuilder: (item) => item.name ?? '',

              onSearchChanged: (value) {
                cubit.onSearchPartChanged(value);
              },

              onSelect: (item) {
                if (item.serial != null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => HomeServicePartPage(
                        serviceIndex: serviceIndex,
                        laborIndex: laborIndex,
                        partIndex: cubit.partResponseListSubject.valueOrNull
                            ?.indexOf(item) ??
                            0,
                        partResponseEntity: item,
                      ),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

