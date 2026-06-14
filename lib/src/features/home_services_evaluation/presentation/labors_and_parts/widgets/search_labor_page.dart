import 'package:emdadgar_saipa/generated/l10n.dart';
import 'package:eks_sana_plus_org/src/config/themes/app_theme.dart';
import 'package:eks_sana_plus_org/src/core/presentation/pages/base_stateless_page.dart';
import 'package:eks_sana_plus_org/src/core/uikit/dialog/dialog_widgets.dart';
import 'package:eks_sana_plus_org/src/core/uikit/spacing.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_loading/ek_loading.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_textfield/ek_textfield.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/labor_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/cubit/labors_and_parts_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/cubit/labors_and_parts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'labor_registration_page.dart';

class SearchLaborHomeServicePage extends BaseStatelessPage {
  const SearchLaborHomeServicePage({super.key, required this.serviceIndex});
  final int serviceIndex;

  @override
  bool? showAppBarDetails(BuildContext context) {
    return true;
  }

  @override
  String? screenName(BuildContext context) {
    return 'جستجوی اجرت';
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
      child: BlocConsumer<LaborsAndPartsCubit, LaborsAndPartsState>(
        listener: (context, state) => state.whenOrNull(
          error: (dialogDataModel) {
            return showDialog(
              context: context,
              builder: (BuildContext context) {
                return MessageDialogWidget(
                  color: AppTheme.blue,
                  dismissible: true,
                  title: dialogDataModel.title,
                  body: dialogDataModel.description,
                  positiveTxt: S.of(context).ok,
                );
              },
            );
          },
        ),
        builder: (BuildContext context, state) {
          return ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              EkTextField(
                paddingStart: 10,
                hintText: 'جستجو...',
                hintStyle: TextStyle(color: Colors.grey[700]),
                radius: 16,
                textDirection: TextDirection.rtl,
                alignText: TextAlign.start,
                height: 35,
                suffixIcon: const Icon(Icons.search),
                autoFocus: true,
                controller: cubit.searchLaborController,
                title: 'جستجو',
                mandatory: true,
                onChanged: (value) {
                  if(value.length >= 3) {
                    cubit.getLabors(value: value, serviceIndex: serviceIndex);
                  }
                },
              ),
              Space.h16,
              BlocBuilder<LaborsAndPartsCubit, LaborsAndPartsState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                        success: () {
                          return StreamBuilder<List<LaborResponseEntity?>>(
                            stream: cubit.laborResponseListSubject,
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.data?.isNotEmpty ?? false) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data?.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(MaterialPageRoute(builder: (_) => LaborRegistrationPage(
                                                serviceIndex: serviceIndex,
                                                entity: snapshot.data?[index],
                                              ),
                                              ));
                                            },
                                            child: SizedBox(
                                              width: double.maxFinite,
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
                                                child: Text(
                                                  snapshot.data?[index]?.name ?? '',
                                                  style: Theme.of(context).textTheme.bodyMedium,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (index != (snapshot.data?.length ?? 0) - 1)
                                            const Divider(
                                              thickness: 1,
                                              color:
                                              AppTheme.darkThemeBoxBackgroundDark,
                                            )
                                        ],
                                      );
                                    });
                              } else if (cubit.searchLaborController.text.length < 3) {
                                return const Center(
                                  child: Text(
                                      'جهت جستجو حداقل سه حرف وارد نمائید'),
                                );
                              } else {
                                return Center(child: Text(S.of(context).noItemToView));
                              }
                            },
                          );
                    },
                        loading: () => const Center(child: EkLoading()),
                        orElse: () =>  const Center(child: Text('جهت جستجو حداقل سه حرف وارد نمائید'))
                    );
                  })
            ],
          );
        },
      ),
    );
  }
}
