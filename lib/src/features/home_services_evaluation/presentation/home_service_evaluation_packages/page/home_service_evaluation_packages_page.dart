import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/cubit/home_service_evaluation_packages_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/cubit/home_service_evaluation_packages_state.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/page/widgets/home_service_evaluation_category_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class InsertHomeServiceServiceInfoPage extends StatelessWidget {
  const InsertHomeServiceServiceInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeServiceEvaluationPackagesCubit>()..init(),
      child:  Scaffold(body: _InsertHomeServiceServiceInfoView())
    );
  }
}

class _InsertHomeServiceServiceInfoView extends StatelessWidget {
  const _InsertHomeServiceServiceInfoView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .onPrimary,
      appBar: SimpleAppBar(title: 'افزودن سرویس'),
      body: SafeArea(
        child: BlocConsumer<
            HomeServiceEvaluationPackagesCubit,
            HomeServiceEvaluationPackagesState
        >(
          listener: (context, state) {
            if (state is HomeServiceEvaluationPackagesErrorState) {
              BottomSheetMessage.showError(
                isDismissible: true,
                context: context,
                data: BottomSheetMessageModel(
                  title: '',
                  message: state.message,
                ),
                onButtonTap: () => context.pop(),
              );
            }

            if (state is HomeServiceEvaluationPackagesNoticeState) {
              BottomSheetMessage.showNotice(
                isDismissible: false,
                context: context,
                data: BottomSheetMessageModel(
                    title: '', message: state.message),
                buttonColor: ServiceType.homeService.serviceColor,
              );
            }

            if (state
            is HomeServiceEvaluationPackagesValidateServicesSuccessState) {
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            return state.maybeWhen(
              loading: () =>
                  Center(
                    child: CircularProgressIndicator(
                      color: ServiceType.homeService.serviceColor,
                    ),
                  ),
              orElse: () =>
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child:    const HomeServiceEvaluationCategoryWidget(),
                    ),
                  ),
            );
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<
          HomeServiceEvaluationPackagesCubit,
          HomeServiceEvaluationPackagesState
      >(
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            validateServicesLoading: () => true,
            orElse: () => false,
          );
          final cubit =  context
              .read<HomeServiceEvaluationPackagesCubit>();
          return Padding(
            padding: const EdgeInsets.all(16),
            child: InkwellButtonWidget(
              title: 'تائید',
              showLoading: isLoading,
              backgroundColor: ServiceType.homeService.serviceColor,
              onTap: () {
                if (isLoading) return;
                cubit.validateServices();
              },
            ),
          );
        },
      ),
    );
  }
}
