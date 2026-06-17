import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/cubit/home_service_evaluation_packages_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/cubit/home_service_evaluation_packages_state.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/page/widgets/home_service_evaluation_category_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InsertHomeServiceServiceInfoPage extends StatelessWidget {
  const InsertHomeServiceServiceInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeServiceEvaluationPackagesCubit>()..init(),
      child: const Scaffold(
        body: SafeArea(
          child: _InsertHomeServiceServiceInfoView(),
        ),
      ),
    );
  }
}

class _InsertHomeServiceServiceInfoView extends StatelessWidget {
  const _InsertHomeServiceServiceInfoView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocConsumer<
      HomeServiceEvaluationPackagesCubit,
      HomeServiceEvaluationPackagesState
    >(
      listener: (context, state) {
        if (state is HomeServiceEvaluationPackagesErrorState) {
          BottomSheetMessage.showError(
            isDismissible: true,
            context: context,
            data: BottomSheetMessageModel(title: '', message: state.message),
          );
        }

        if (state is HomeServiceEvaluationPackagesNoticeState) {
          BottomSheetMessage.showNotice(
            isDismissible: false,
            context: context,
            data: BottomSheetMessageModel(title: '', message: state.message),
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
          loading: () => Center(
            child: CircularProgressIndicator(
              color: ServiceType.homeService.serviceColor,
            ),
          ),
          orElse: () => Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'سرویس مورد نیاز خود را انتخاب کنید:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),

                Space.h8,

                const HomeServiceEvaluationCategoryWidget(),

                Space.h16,

                BlocBuilder<
                  HomeServiceEvaluationPackagesCubit,
                  HomeServiceEvaluationPackagesState
                >(
                  builder: (context, state) {
                    return state.maybeWhen(
                      validateServicesLoading: () {
                        return InkwellButtonWidget(
                          title: 'تائید',
                          showLoading: true,
                          backgroundColor: ServiceType.homeService.serviceColor,
                          onTap: () {},
                        );
                      },
                      orElse: () {
                        return InkwellButtonWidget(
                          title: 'تائید',
                          backgroundColor: ServiceType.homeService.serviceColor,
                          onTap: () {
                            context
                                .read<HomeServiceEvaluationPackagesCubit>()
                                .validateServices();
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ================= BottomSheet =================

  void _showErrorBottomSheet(
    BuildContext context, {
    required String title,
    required String message,
    required bool dismissible,
  }) {
    showModalBottomSheet(
      context: context,
      isDismissible: dismissible,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),

              Space.h12,

              Text(message, style: Theme.of(context).textTheme.bodyMedium),

              Space.h20,

              InkwellButtonWidget(
                title: 'باشه',
                backgroundColor: ServiceType.homeService.serviceColor,
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
