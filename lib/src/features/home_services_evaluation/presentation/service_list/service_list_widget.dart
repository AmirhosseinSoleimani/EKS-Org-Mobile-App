import 'package:emdadgar_saipa/generated/l10n.dart';
import 'package:eks_sana_plus_org/src/config/themes/app_theme.dart';
import 'package:eks_sana_plus_org/src/core/presentation/pages/base_stateless_page.dart';
import 'package:eks_sana_plus_org/src/core/uikit/dialog/dialog_widgets.dart';
import 'package:eks_sana_plus_org/src/core/uikit/spacing.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_loading/ek_loading.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_textfield/ek_textfield.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_response_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/service_list_cubit.dart';
import 'cubit/service_list_state.dart';


class ServiceListWidget extends BaseStatelessPage {
  const ServiceListWidget({super.key});

  @override
  bool? showAppBarDetails(BuildContext context) {
    return true;
  }

  @override
  String? screenName(BuildContext context) {
    return 'افزودن سرویس';
  }

  @override
  Widget body(BuildContext context) {
    return BlocProvider(
      create: (_) {
        var bloc = getIt<ServiceListCubit>();
        bloc.initState();
        return bloc;
      },
      child: _build(context),
    );
  }

  Widget _build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocConsumer<ServiceListCubit, ServiceListState>(
        listener: (context, state) => state.whenOrNull(
          error: (dialogDataModel) {
            return showDialog(
              context: context,
              builder: (BuildContext context) {
                return MessageDialogWidget(
                  dismissible: false,
                  title: dialogDataModel.title,
                  body: dialogDataModel.description,
                  positiveTxt: S.of(context).ok,
                  positiveFunc: () {
                    Navigator.of(context).pop();
                  },
                );
              },
            );
          },
          selectServiceSuccess: () => Navigator.pop(context),
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
                controller:
                context.read<ServiceListCubit>().searchLaborController,
                title: 'جستجو',
                onChanged: (value) {
                  if(value.length >= 3) {
                    context.read<ServiceListCubit>().getAllServices(value);
                  }
                },
              ),
              Space.h16,
              BlocBuilder<ServiceListCubit, ServiceListState>(
                builder: (BuildContext context, ServiceListState state) {
                  final cubit = context.read<ServiceListCubit>();
                  return state.maybeWhen(
                      getServiceLoading: () => const EkLoading(),
                      orElse: () => StreamBuilder<List<EmdadServiceResultEntity>?>(
                        stream: cubit.serviceResponseSubject,
                        builder: (BuildContext context, snapshot) {
                          if(snapshot.data?.isNotEmpty ?? false) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: InkWell(
                                          onTap: () {
                                            cubit.selectService(index: index);
                                          },
                                          child: SizedBox(
                                            width: double.maxFinite,
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional.only(start: 12.0),
                                              child: Text(
                                                snapshot.data?[index].serviceTitle ?? '',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if ((snapshot.data?.isNotEmpty ?? false) && index != snapshot.data!.length - 1) const Divider(thickness: 1, color: AppTheme.colorHoloGreyPrimaryLow,),
                                    ],
                                  ),
                                );
                              },
                            );
                          }else {
                            return const Center(
                              child: Text(
                                  'جهت جستجو حداقل سه حرف وارد نمائید'),
                            );
                          }
                        },
                      ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
