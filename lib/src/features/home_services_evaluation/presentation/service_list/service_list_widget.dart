import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'cubit/service_list_cubit.dart';
import 'cubit/service_list_state.dart';

class ServiceListWidget extends StatelessWidget {
  const ServiceListWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      appBar: SimpleAppBar(title: 'افزودن سرویس'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<ServiceListCubit, ServiceListState>(
          listener: (context, state) => state.whenOrNull(
            error: (bottomSheetMessage) {
              return BottomSheetMessage.showError(
                isDismissible: true,
                context: context,
                data: bottomSheetMessage,
                onButtonTap: () => context.pop(),
              );
            },
            selectServiceSuccess: () => Navigator.pop(context),
          ),
          builder: (BuildContext context, state) {
            final cubit = context.read<ServiceListCubit>();
            return RefreshIndicator(
              onRefresh: () async {
                final query = cubit.searchLaborController.text.trim();
                if (query.length < 3) return;
                await cubit.getAllServices(query);
              },
              child: ListView(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                TextFormFieldWidget(
                  hintText: 'جستجو...',
                  hintStyle: TextStyle(color: Colors.grey[700]),
                  borderRadius: 16,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.start,
                  suffixIcon: const Icon(Icons.search),
                  controller: context
                      .read<ServiceListCubit>()
                      .searchLaborController,
                  labelText: 'جستجو',
                  onChanged: (value) {
                    if (value.length >= 3) {
                      context.read<ServiceListCubit>().getAllServices(value);
                    }
                  },
                ),
                Space.h16,
                BlocBuilder<ServiceListCubit, ServiceListState>(
                  builder: (BuildContext context, ServiceListState state) {
                    final cubit = context.read<ServiceListCubit>();
                    return state.maybeWhen(
                      getServiceLoading: () => CircularProgressIndicator(
                        color: ServiceType.homeService.serviceColor,
                      ),
                      orElse: () => StreamBuilder<List<EmdadServiceResultEntity>?>(
                        stream: cubit.serviceResponseSubject,
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.data?.isNotEmpty ?? false) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            cubit.selectService(index: index);
                                          },
                                          child: SizedBox(
                                            width: double.maxFinite,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.only(
                                                    start: 12.0,
                                                  ),
                                              child: Text(
                                                snapshot
                                                        .data?[index]
                                                        .serviceTitle ??
                                                    '',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if ((snapshot.data?.isNotEmpty ?? false) &&
                                          index != snapshot.data!.length - 1)
                                        Divider(
                                          thickness: 1,
                                          color: Colors.grey.withAlpha(150),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: Text('جهت جستجو حداقل سه حرف وارد نمائید'),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
