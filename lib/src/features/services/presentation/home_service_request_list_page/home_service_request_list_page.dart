import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/request_list_viewer.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/main_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/home_service_request_list_cubit.dart';
import 'widgets/filters_box.dart';

class HomeServiceRequestListPage extends StatelessWidget {
  static const path = "/home-service-page";
  static const name = "home-service-page";

  const HomeServiceRequestListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeServiceRequestListCubit>()..fetchRequestList(),
      child: const SizedBox(),
    );
  }
}

/*class _SelectedServicesView extends StatelessWidget {
  const _SelectedServicesView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeServiceRequestListCubit>();
    return BlocListener<HomeServiceRequestListCubit,
        HomeServiceRequestListState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            BottomSheetMessage.showErrorWithAction(
              context: context,
              data: message,
              onPositive: cubit.fetchRequestList,
            );
          },
          connectionError: () {
            BottomSheetMessage.showCustom(
              context: context,
              content: NoInternetBottomSheet(
                onRetry: cubit.fetchRequestList,
              ),
              actionWidget: const SizedBox.shrink(),
              isDismissible: false,
              enableDrag: false,
            );
          },
        );
      },
      child: Scaffold(
        appBar: const SimpleAppBar(title: 'درخواست های خدمت در محل'),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: FiltersBox(cubit: cubit)),
              Expanded(
                child: BlocBuilder<HomeServiceRequestListCubit,
                    HomeServiceRequestListState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      idle: () => const SizedBox.shrink(),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      loaded: () => SingleChildScrollView(
                        padding: const EdgeInsets.all(AppSize.s16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BodyMediumText(text: '${cubit.requestList.length} درخواست'),
                            RequestListViewer(items: cubit.requestList,onSelected: cubit.cacheSelectedRequest),
                          ],
                        ),
                      ),
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
