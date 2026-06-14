import 'package:emdadgar_saipa/generated/l10n.dart';
import 'package:eks_sana_plus_org/src/config/themes/app_theme.dart';
import 'package:eks_sana_plus_org/src/core/presentation/pages/base_stateless_page.dart';
import 'package:eks_sana_plus_org/src/core/uikit/spacing.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_loading/ek_loading.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_textfield/ek_textfield.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/cubit/labors_and_parts_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/cubit/labors_and_parts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_and_registration_part_widget.dart';
class SearchPartHomeServicePage extends BaseStatelessPage {
  const SearchPartHomeServicePage({super.key, required this.serviceIndex, required this.laborIndex});
  final int laborIndex;
  final int serviceIndex;

  @override
  bool? showAppBarDetails(BuildContext context) {
    return true;
  }

  @override
  String? screenName(BuildContext context) {
    return 'جستجوی قطعه';
  }

  @override
  Widget body(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = getIt<LaborsAndPartsCubit>();
        bloc.initState();
        return bloc;
      },
      child: Builder(
        builder: (context) {
          return _build(context);
        }
      ),
    );
  }

  Widget _build(BuildContext context) {
    final cubit = context.read<LaborsAndPartsCubit>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<LaborsAndPartsCubit, LaborsAndPartsState>(
        builder: (BuildContext context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              EkTextField(
                autoFocus: true,
                suffixIcon: const Icon(Icons.search),
                height: 35,
                controller: context.read<LaborsAndPartsCubit>().searchPartController,
                title: 'قطعه',
                mandatory: true,
                onChanged: (value) {
                  if(value.length >= 3) {
                    cubit.getPart(value: value, laborIndex: laborIndex, serviceIndex: serviceIndex);
                  }
                },
              ),
              Space.h16,
              Expanded(
                flex: 5,
                child: BlocBuilder<LaborsAndPartsCubit, LaborsAndPartsState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                          success: () {
                            return StreamBuilder<List<PartResponseEntity?>> (
                              stream: cubit.partResponseListSubject,
                              builder: (BuildContext context, snapshot) {
                                if (snapshot.data?.isNotEmpty ?? false) {
                                  return ListView.builder(
                                    itemCount: snapshot.data?.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if (cubit.partResponseListSubject.valueOrNull?[index]?.serial != null) {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(builder: (_) => EditAndRegistrationPartWidget(
                                                    serviceIndex: serviceIndex,
                                                    laborIndex: laborIndex,
                                                    partIndex: index,
                                                    partResponseEntity: cubit.partResponseListSubject.valueOrNull?[index],
                                                  )),
                                                );
                                              }
                                            },
                                            child: SizedBox(
                                              width: double.maxFinite,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.fromLTRB(0, 12, 12, 12),
                                                child: Text(
                                                  snapshot.data?[index]?.name ?? '_',
                                                  style: Theme.of(context).textTheme.bodyMedium,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if(index != (snapshot.data?.length ?? 0) - 1)const Divider(
                                            thickness: 1,
                                            color: AppTheme.darkThemeBoxBackgroundDark,
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else if (cubit.searchPartController.text.length <3) {
                                  return const Center(
                                    child: Text(
                                        'جهت جستجو حداقل سه حرف وارد نمائید'),
                                  );
                                } else {
                                  return Center(
                                    child: Text(S.of(context).noItemToView),
                                  );
                                }
                              },
                            );
                      },
                      loading: () => const Center(child: EkLoading()),
                      orElse: () => const Center(child: Text('جهت جستجو حداقل سه حرف وارد نمائید')),
                      );
                    }),
              )
            ],
          );
        },
      ),
    );
  }
}

