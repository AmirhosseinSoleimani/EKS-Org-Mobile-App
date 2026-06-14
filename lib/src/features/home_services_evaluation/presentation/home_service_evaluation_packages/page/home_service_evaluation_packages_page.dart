import 'package:emdadgar_saipa/generated/l10n.dart';
import 'package:eks_sana_plus_org/src/config/themes/app_theme.dart';
import 'package:eks_sana_plus_org/src/core/presentation/pages/base_stateless_page.dart';
import 'package:eks_sana_plus_org/src/core/uikit/dialog/dialog_widgets.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_button/ek_button.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_loading/ek_loading.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/cubit/home_service_evaluation_packages_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/cubit/home_service_evaluation_packages_state.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/page/widgets/home_service_evaluation_category_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/font_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InsertHomeServiceServiceInfoPage extends BaseStatelessPage {
  const InsertHomeServiceServiceInfoPage({super.key,});

  @override
  bool showAppBarDetails(BuildContext context) {
    return true;
  }

  @override
  Widget body(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeServiceEvaluationPackagesCubit>()..init(),
      child: const _InsertHomeServiceServiceInfoView(),
    );
  }
}
class _InsertHomeServiceServiceInfoView extends StatelessWidget {
  const _InsertHomeServiceServiceInfoView();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeServiceEvaluationPackagesCubit, HomeServiceEvaluationPackagesState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (dialogDataModel) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return MessageDialogWidget(
                  dismissible: false,
                  title: dialogDataModel.title,
                  body: dialogDataModel.description,
                  positiveTxt: S.of(context).ok,
                );
              },
            );
          },
          notice: (dialogDataModel) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return MessageDialogWidget(
                  dismissible: true,
                  title: dialogDataModel.title,
                  body: dialogDataModel.description,
                  positiveTxt: S.of(context).ok,
                );
              },
            );
          },
          validateServicesSuccess: () {
            Navigator.of(context).pop();
          },
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const Center(child: EkLoading(),),
          orElse: () => Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'سرویس مورد نیاز خود را انتخاب کنید:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: AppSize.s16,
                        fontWeight: FontWeight.w400,
                        fontFamily: FontConstants.fontFamilyPersian
                    ),
                  ),
                ),
                Space.h8,
                BlocBuilder<HomeServiceEvaluationPackagesCubit, HomeServiceEvaluationPackagesState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      loading: () => const Center(
                        child: EkLoading(),
                      ),
                      orElse: () => const HomeServiceEvaluationCategoryWidget(),
                    );
                  },

                ),
                Space.h16,
                BlocBuilder<HomeServiceEvaluationPackagesCubit, HomeServiceEvaluationPackagesState>(
                  builder: (BuildContext context, state) {
                    return state.maybeWhen(
                      validateServicesLoading: () => EkButton(
                        title: 'تائید',
                        showLoading: true,
                        backgroundColor: AppTheme.blue,
                        onTap: () {
                        },
                      ),
                      orElse: () => EkButton(
                        title: 'تائید',
                        backgroundColor: AppTheme.blue,
                        onTap: () {
                          context.read<HomeServiceEvaluationPackagesCubit>().validateServices();
                        },
                      ),
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
}

