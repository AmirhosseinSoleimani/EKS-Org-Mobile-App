import 'package:emdadgar_saipa/generated/l10n.dart';
import 'package:eks_sana_plus_org/src/common/utils/extensions/string_ext.dart';
import 'package:eks_sana_plus_org/src/config/themes/app_theme.dart';
import 'package:eks_sana_plus_org/src/core/presentation/pages/base_stateless_page.dart';
import 'package:eks_sana_plus_org/src/core/uikit/dialog/dialog_widgets.dart';
import 'package:eks_sana_plus_org/src/core/uikit/spacing.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_button/ek_button.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_loading/ek_loading.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_textfield/ek_textfield.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/home_service_evaluation_second_step.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_kilometer_image/page/home_service_kilometer_image_page.dart';
import 'package:eks_sana_plus_org/src/features/request/domain/entity/get_request_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/home_service_evaluation_first_step_state.dart';
import 'cubit/home_service_evaluation_first_step_cubit.dart';

class HomeServiceEvaluationFirstStep extends BaseStatelessPage {
  final GetRequestEntity? entity;

  const HomeServiceEvaluationFirstStep({this.entity, Key? key}) : super(key: key);

  @override
  bool? showAppBarDetails(BuildContext context) {
    return true;
  }

  @override
  String? screenName(BuildContext context) {
    return 'ثبت ارزیابی';
  }


  @override
  Widget body(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        var bloc = getIt<HomeServiceEvaluationFirstStepCubit>();
        bloc.initState(requestEntity: entity);
        return bloc;
      },
      child: Builder(builder: (context) {
        return _buildBody(context);
      }),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<HomeServiceEvaluationFirstStepCubit, HomeServiceEvaluationFirstStepState>(
      listener: (context, state) {
        state.whenOrNull(
          submitSuccess: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeServiceEvaluationSecondStep()),
          ),
          submitError: (dialogDataModel) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return MessageDialogWidget(
                  color: AppTheme.blue,
                  dismissible: true,
                  title: '',
                  body: dialogDataModel.description,
                  positiveFunc: () {
                  },
                );
              },
            );
          },
          error: (dialogDataModel) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return MessageDialogWidget(
                  dismissible: false,
                  title: '',
                  body: dialogDataModel.description,
                  positiveFunc: () {
                    Navigator.of(context).pop();
                  },
                );
              },
            );
          },
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EkLoading(),
            ],
          ),
          success: () => bodyContainer(context: context),
          orElse: () => bodyContainer(context: context),
        );
      },
    );
  }

  Widget bodyContainer({required BuildContext context}) {
    final cubit = context.read<HomeServiceEvaluationFirstStepCubit>();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Space.h4,
          ///Customer Kilometer Controller
          StreamBuilder<bool?>(
            stream: cubit.kmReadOnly$,
            initialData: cubit.kilometerFieldReadOnly,
            builder: (context, snap) {
              final readOnly = snap.data ?? true;
              return EkTextField(
                height: Space.defaultTextFieldHeight,
                controller: cubit.customerCarKilometerController,
                readOnly: readOnly,
                isLtr: true,
                keyboardType: TextInputType.number,
                title: (cubit.activeServiceRequestStream.value?.saipaKilometer != null)
                    ? '${S.of(context).customerCarKilometer}(کیلومتر سایپایدک: ${(cubit.activeServiceRequestStream.value?.saipaKilometer).toString().convertNumberWithLanguage()})'
                    : S.of(context).customerCarKilometer,
                titleStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.colorBlack),
                mandatory: true,
                maxLength: 6,
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeServiceKilometerImagePage()),
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          color: AppTheme.blue,
                          shape: BoxShape.circle
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 24.0,
                        color: AppTheme.whiteColor,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Space.h16,
          Row(
            children: [
              Expanded(
                child: EkTextField(
                  height: Space.defaultTextFieldHeight,
                  controller: cubit.startTimeController,
                  enabled: false,
                  isLtr: true,
                  keyboardType: TextInputType.number,
                  title: S.of(context).dispatchTime,
                  mandatory: false,
                ),
              ),
              Space.w8,
              Expanded(
                child: EkTextField(
                  height: Space.defaultTextFieldHeight,
                  controller: cubit.arriveTimeController,
                  enabled: false,
                  isLtr: true,
                  keyboardType: TextInputType.number,
                  title: S.of(context).arriveTime,
                  mandatory: false,
                ),
              ),
            ],
          ),
          Space.h16,
          EkTextField(
            alignText: TextAlign.center,
            height: Space.defaultTextFieldHeight,
            controller: cubit.reliefDistanceController,
            enabled: false,
            isLtr: true,
            keyboardType: TextInputType.number,
            title: '${S.of(context).reliefDistance} (${cubit.assignTrackerNameController.text})',
            mandatory: true,
          ),
          Space.h16,
          EkTextField(
            height: Space.defaultTextFieldHeight,
            controller: cubit.addDescriptionController,
            maxLines: 5,
            title: S.of(context).description,
            maxLength: 500,
            mandatory: false,
          ),
          Space.h16,
          //submit and continue button
          BlocBuilder<HomeServiceEvaluationFirstStepCubit, HomeServiceEvaluationFirstStepState>(
            builder: (context, state) {
              return state.maybeWhen(
                submitLoading: () => EkButton(
                  backgroundColor: AppTheme.blue,
                  title: S.of(context).saveAndContinue,
                  onTap: () {},
                  showLoading: true,
                ),
                orElse: () => EkButton(
                    backgroundColor: AppTheme.blue,
                    title: S.of(context).saveAndContinue,
                    onTap: () {
                      cubit.submit();
                    }),
              );
            },
          ),
        ],
      ),
    );
  }
// void updateControllerText(TextEditingController controller) {
//   String currentText = controller.text;
//   String convertedText = currentText.convertNumberWithLanguage();
//   controller.value = TextEditingValue(
//     text: convertedText,
//     selection: TextSelection.collapsed(offset: convertedText.length),
//   );
// }
}
