import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/main_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/selected_service_cubit.dart';
import 'widgets/request_list_viewer.dart';
import 'widgets/services_filters_box.dart';

class SelectedServicesPage extends StatelessWidget {
  static const path = "/selected-services";
  static const name = "selected-services";

  final ServiceType serviceType;

  const SelectedServicesPage({super.key, required this.serviceType});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SelectedServiceCubit>()..init(),
      child: _SelectedServicesView(serviceType: serviceType),
    );
  }
}

class _SelectedServicesView extends StatelessWidget {
  final ServiceType serviceType;

  const _SelectedServicesView({required this.serviceType});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SelectedServiceCubit>();
    return BlocListener<SelectedServiceCubit, SelectedServiceState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            BottomSheetMessage.showErrorWithAction(
              context: context,
              data: message,
              onPositive: cubit.init,
            );
          },
          connectionError: () {
            BottomSheetMessage.showCustom(
              context: context,
              content: NoInternetBottomSheet(
                onRetry: cubit.init,
              ),
              actionWidget: const SizedBox.shrink(),
              isDismissible: false,
              enableDrag: false,
            );
          },
        );
      },
      child: Scaffold(
        appBar: MainAppBar(title: "درخواست های ${serviceType.label}"),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSize.s16),
            child: Column(
              children: [
                ServicesFiltersBox(cubit: cubit),
                const SizedBox(height: AppSize.s16),
                 Align(
                    alignment: AlignmentDirectional.topStart,
                    child: BodyMediumText(
                      text: '${cubit.requestCount} درخواست',
                    )),
                BlocBuilder<SelectedServiceCubit, SelectedServiceState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                        idle: () => const SizedBox.shrink(),
                        loading: () => const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: AppSize.s40),
                                child: CircularProgressIndicator(),
                              ),
                            ),
                        loaded: () =>  RequestListViewer(
                              items: cubit.buildFakeRequests(),
                            ),
                        orElse: SizedBox.shrink);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
