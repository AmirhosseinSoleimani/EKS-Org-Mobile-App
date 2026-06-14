import 'dart:io';
import 'package:emdadgar_saipa/generated/l10n.dart';
import 'package:eks_sana_plus_org/src/config/themes/app_theme.dart';
import 'package:eks_sana_plus_org/src/core/presentation/pages/base_stateless_page.dart';
import 'package:eks_sana_plus_org/src/core/uikit/dialog/dialog_widgets.dart';
import 'package:eks_sana_plus_org/src/core/uikit/spacing.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_button/ek_button.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_loading/ek_loading.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/add__home_service_image/cubit/add_photo_home_service_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/add__home_service_image/cubit/add_photo_home_service_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KilometerPhotoHomeServicePage extends BaseStatelessPage {
  const KilometerPhotoHomeServicePage({Key? key}): super(key: key);

  @override
  bool? showAppBarDetails(BuildContext context) {
    return true;
  }

  @override
  String? screenName(BuildContext context) {
    return 'افزودن تصویر';
  }

  @override
  Widget body(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        final bloc = getIt<AddPhotoHomeServiceCubit>();
        bloc.removeKilometerPhoto();
        return bloc;
      },
      child: Builder(
          builder: (context) {
            return const Padding(
              padding: EdgeInsets.all(Space.defaultPadding),
              child: _BuildBody(),
            );
          }
      ),
    );
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody();
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddPhotoHomeServiceCubit>();
    return  BlocConsumer<AddPhotoHomeServiceCubit, AddPhotoHomeServiceState>(
      listener: (context, state) {
        state.whenOrNull(
            error: (dialogDataModel) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MessageDialogWidget(
                    color: AppTheme.blue,
                    dismissible: false,
                    title: '',
                    body: dialogDataModel.description,
                    positiveFunc: () {
                    },
                  );
                },
              );
            }
        );
      },
      builder: (context, state) {
        return BlocBuilder<AddPhotoHomeServiceCubit, AddPhotoHomeServiceState>
          (builder: (BuildContext context, AddPhotoHomeServiceState state) {
            return state.maybeWhen(
              loading: () => const Center(
                child: EkLoading(),
              ),
              orElse: () => StreamBuilder<File?>(
              stream: cubit.kilometerPhotoStream,
              builder: (context, snapshot) {
                if ((snapshot.hasData) && (snapshot.data?.existsSync() ?? false)) {
                  final photo = snapshot.data;
                  return Column(
                    children: [
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline, size: 28.0, color: AppTheme.blue,),
                          Space.w4,
                          Expanded(
                            child: Text(
                              'جهت ثبت دقیق اطلاعات، لطفاً عکس واضحی از نمایشگر کیلومتر خودرو ارسال نمایید.',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: FontConstants.fontFamilyPersian
                              ),
                            ),
                          ),
                        ],
                      ),
                      Space.h16,
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'تصویر گرفته شده:',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0
                          ),
                        ),
                      ),
                      Space.h16,
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppTheme.darkThemeBoxBackgroundLight,
                              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                              border: Border.all(
                                  width: 2,
                                  color: AppTheme.darkThemeBoxBackgroundDark
                              )
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                  child: Image.file(photo ?? File(''), fit: BoxFit.cover, height: 250, width: MediaQuery.of(context).size.width,)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            color: AppTheme.whiteColor,
                                            shape: BoxShape.circle
                                        ),
                                        child: IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return MessageDialogWidget(
                                                      dismissible: true,
                                                      color: AppTheme.blue,
                                                      title: '',
                                                      body: 'آیا از حذف تصویر اطمینان دارید؟',
                                                      positiveFunc: () {
                                                        cubit.removeKilometerPhoto();
                                                      },
                                                    );
                                                  });
                                            },
                                            icon: const Icon(Icons.delete, color: Colors.red, size: 24.0,)),
                                      ),
                                      Space.w4,
                                      Container(
                                        decoration: const BoxDecoration(
                                            color: AppTheme.whiteColor,
                                            shape: BoxShape.circle
                                        ),
                                        child: IconButton(
                                            onPressed: () async{
                                              await cubit.submitKilometerPhoto();
                                            },
                                            icon: const Icon(Icons.edit, color: AppTheme.blue, size: 24.0,)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),


                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      _buildConfirmationButton(
                          context: context, showLoading: cubit.state.maybeWhen(
                          orElse: () => false,
                          submitLoading: () => true
                      )),
                    ],
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline, size: 28.0, color: AppTheme.blue,),
                        Space.w4,
                        Expanded(
                          child: Text(
                            'جهت ثبت دقیق اطلاعات، لطفاً عکس واضحی از نمایشگر کیلومتر خودرو ارسال نمایید.',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: FontConstants.fontFamilyPersian
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () async{
                        await cubit.submitKilometerPhoto();
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2,
                                color: AppTheme.green
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(12.0))
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, size: 28.0, color: AppTheme.green,),
                              Space.w4,
                              Text(
                                'افزودن تصویر',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    _buildConfirmationButton(context: context, showLoading: false)
                  ],
                );
              },
            ),
            );
        },
        );
      },
    );
  }

  Widget _buildConfirmationButton({required BuildContext context, bool? showLoading}) {
    final cubit = context.read<AddPhotoHomeServiceCubit>();
    return StreamBuilder<bool>(
        stream: cubit.validatorSubject,
        builder: (context, snapshot) {
          final isValid = snapshot.data ?? false;
          final backgroundColor = isValid
              ? AppTheme.blue
              : AppTheme.darkThemePrimaryLight;
          return Animate(
            effects: [
              FadeEffect(
                duration: 500.ms,
                curve: Curves.easeInOut,
              ),
            ],
            child: EkButton(
                showLoading: showLoading ?? false,
                title: S.of(context).confirmation,
                backgroundColor: backgroundColor,
                onTap: () async{
                  if(cubit.getKilometerPhotoList?.path.isNotEmpty ?? false) {
                    await cubit.extractKilometerFromImage();
                    await cubit.addImageKilometerToEvaluation();
                    Navigator.pop(context, true);
                    return ;
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const MessageDialogWidget(
                            color: AppTheme.blue,
                            dismissible: false,
                            title: '',
                            body: 'لطفاً تصویری واضح از صفحه کیلومتر خودرو ثبت و ارسال نمایید.',
                          );
                        });
                  }
                }
            ),
          );
        }
    );
  }
}
