import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_part/cubit/home_service_part_cubit.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_part/cubit/home_service_part_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_part/cubit/home_service_part_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
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

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<HomeServicePartCubit, HomeServicePartState>(
        builder: (context, state) {
          return Column(
            children: [
              TextFormFieldWidget(
                suffixIcon: const Icon(Icons.search),
                controller: cubit.searchPartController,
                labelText: 'قطعه',
                mandatory: true,
                onChanged: cubit.onSearchPartChanged,
              ),

              Space.h16,

              // ================= LIST =================
              Expanded(
                child: BlocBuilder<
                    HomeServicePartCubit,
                    HomeServicePartState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      loading: () =>  CircularProgressIndicator(color: ServiceType.homeService.serviceColor),
                      success: () {
                        return StreamBuilder<List<PartResponseEntity?>>(
                          stream: cubit.partResponseListSubject,
                          builder: (context, snapshot) {
                            final items = snapshot.data;

                            if (items?.isNotEmpty ?? false) {
                              return ListView.builder(
                                itemCount: items!.length,
                                itemBuilder: (context, index) {
                                  final item = items[index];

                                  return Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (item?.serial != null) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    HomeServicePartPage(
                                                      serviceIndex:
                                                      serviceIndex,
                                                      laborIndex: laborIndex,
                                                      partIndex: index,
                                                      partResponseEntity: item,
                                                    ),
                                              ),
                                            );
                                          }
                                        },
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                0, 12, 12, 12),
                                            child: Text(
                                              item?.name ?? '_',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ),
                                        ),
                                      ),

                                      if (index != items.length - 1)
                                        Divider(
                                          thickness: 1,
                                          color: colorScheme.outline,
                                        ),
                                    ],
                                  );
                                },
                              );
                            }

                            // ================= EMPTY STATES =================
                            if (cubit.searchPartController.text.length <
                                3) {
                              return const Center(
                                child: Text(
                                  'جهت جستجو حداقل سه حرف وارد نمائید',
                                ),
                              );
                            }

                            return Center(
                              child: Text(
                                'موردی جهت نمایش وجود ندارد',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium,
                              ),
                            );
                          },
                        );
                      },

                      orElse: () => const Center(
                        child: Text(
                          'جهت جستجو حداقل سه حرف وارد نمائید',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

