import 'package:emdadgar_saipa/generated/l10n.dart';
import 'package:eks_sana_plus_org/src/config/themes/app_theme.dart';
import 'package:eks_sana_plus_org/src/core/presentation/pages/base_stateless_page.dart';
import 'package:eks_sana_plus_org/src/core/uikit/spacing.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_loading/ek_loading.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_textfield/ek_textfield.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/cubit/labors_and_parts_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/cubit/labors_and_parts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SearchReusablePage extends BaseStatelessPage {
  final int laborIndex;
  final int serviceIndex;
  const SearchReusablePage({super.key, required this.laborIndex, required this.serviceIndex});

  @override
  bool? showAppBarDetails(BuildContext context) {
    return true;
  }

  @override
  String? screenName(BuildContext context) {
    return 'جستجوی داغی';
  }

  @override
  Widget body(BuildContext context) {
    return _build(context);
  }

  Widget _build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocConsumer<LaborsAndPartsCubit, LaborsAndPartsState>(
        listener: (context, state) {
          state.whenOrNull(
              reusablePriceSuccess: () => Navigator.of(context).pop(),
          );
        },
        builder: (BuildContext context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              EkTextField(
                autoFocus: true,
                suffixIcon: const Icon(Icons.search),
                height: 35,
                controller: context
                    .read<LaborsAndPartsCubit>().searchReusablePartController,
                title: 'داغی',
                mandatory: true,
                onChanged: (value) {
                  if(value.length >= 3) {
                    context.read<LaborsAndPartsCubit>().getPart(
                        value: value,
                        laborIndex: laborIndex,
                        serviceIndex: serviceIndex,
                    );
                  }
                },
              ),
              Space.h16,
              Expanded(
                flex: 5,
                child: BlocBuilder<LaborsAndPartsCubit, LaborsAndPartsState>(
                    builder: (context, state) {
                      final cubit = context.read<LaborsAndPartsCubit>();
                      return state.maybeWhen(
                        success: () {
                          return StreamBuilder<List<PartResponseEntity?>>(
                            stream: cubit.partResponseListSubject,
                            builder: (context, snapshot) {
                              return (snapshot.data?.isNotEmpty ?? false) ?
                              ListView.builder(
                                itemCount: snapshot.data?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (snapshot.data?[index]?.serial != null) {
                                            cubit.getReusablePrice(
                                              serial: snapshot.data?[index]?.serial ?? '',
                                              name: snapshot.data?[index]?.name,
                                            );
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        child: SizedBox(
                                          width: double.maxFinite,
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                0, 12, 12, 12),
                                            child: Text(
                                              snapshot.data?[index]?.name ?? '_',
                                              style: Theme.of(context).textTheme.bodyMedium,
                                            ),
                                          ),
                                        ),
                                      ),
                                      if(index != (snapshot.data?.length ?? 0) - 1)const Divider(
                                        thickness: 1,
                                        color: AppTheme.darkThemeBoxBackgroundDark,)
                                    ],
                                  );
                                },
                              ) :
                              Center(
                                  child: Text(S.of(context).noItemToView));
                            }
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

