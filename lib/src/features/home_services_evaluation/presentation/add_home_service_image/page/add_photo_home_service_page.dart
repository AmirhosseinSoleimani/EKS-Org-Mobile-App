import 'dart:io';
import 'package:emdadgar_saipa/generated/l10n.dart';
import 'package:eks_sana_plus_org/src/config/themes/app_theme.dart';
import 'package:eks_sana_plus_org/src/core/presentation/pages/base_stateless_page.dart';
import 'package:eks_sana_plus_org/src/core/uikit/dialog/dialog_widgets.dart';
import 'package:eks_sana_plus_org/src/core/uikit/spacing.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_button/ek_button.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/finalize_invoice/presentation/bloc/finalize_invoice_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/active_service_request_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/last_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/add__home_service_image/cubit/add_photo_home_service_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/add__home_service_image/cubit/add_photo_home_service_state.dart';
import 'package:eks_sana_plus_org/src/features/invoice/domain/entity/invoice_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice/presentation/pre_invoice/pages/invoice_page.dart';
import 'package:eks_sana_plus_org/src/features/request/domain/entity/get_request_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AddPhotoHomeServicePage extends BaseStatelessPage {
  const AddPhotoHomeServicePage({Key? key, this.lastEvaluationEntity, this.activeServiceRequestResponseEntity, this.emdadgarEvaluationId}): super(key: key);
  final LastEvaluationEntity? lastEvaluationEntity;
  final int? emdadgarEvaluationId;
  final ActiveServiceRequestResponseEntity? activeServiceRequestResponseEntity;


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
        bloc.clearPhoto();
        return bloc;
      },
      child: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(Space.defaultPadding),
              child: _BuildBody(
                lastEvaluationEntity: lastEvaluationEntity,
                activeServiceRequestResponseEntity: activeServiceRequestResponseEntity,
                emdadgarEvaluationId: emdadgarEvaluationId,
              ),
            );
          }
      ),
    );
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody({this.lastEvaluationEntity, this.activeServiceRequestResponseEntity, this.emdadgarEvaluationId});
  final LastEvaluationEntity? lastEvaluationEntity;
  final int? emdadgarEvaluationId;
  final ActiveServiceRequestResponseEntity? activeServiceRequestResponseEntity;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddPhotoHomeServiceCubit>();
    return  BlocConsumer<AddPhotoHomeServiceCubit, AddPhotoHomeServiceState>(
      listener: (context, state) {
        state.whenOrNull(
            submitSuccess: () => Navigator.push(context, MaterialPageRoute(builder: (_) => InvoicePage(
              preInvoiceRequestEntity: InvoiceRequestEntity(
                serviceType: 2,
                serviceRequestId: activeServiceRequestResponseEntity?.id ?? 0,
                emdadgarEvaluationId: cubit.emdadgarEvaluationPostResultId,
              ),
              /// TODO Improved GetRequestEntity
              requestEntity: GetRequestEntity(
                firstName: activeServiceRequestResponseEntity?.firstName,
                lastName: activeServiceRequestResponseEntity?.lastName,
                defectTitle: activeServiceRequestResponseEntity?.defectTitle,
                defectId: activeServiceRequestResponseEntity?.defectId,
                serviceType: activeServiceRequestResponseEntity?.serviceType,
                serviceTitles: activeServiceRequestResponseEntity?.serviceTitles,
                carName: activeServiceRequestResponseEntity?.carName,
                chassisNumber: activeServiceRequestResponseEntity?.chassisNumber,
                trackCode: activeServiceRequestResponseEntity?.trackCode,
                id: activeServiceRequestResponseEntity?.id,
                serviceCategoryTitle: activeServiceRequestResponseEntity?.serviceCategoryTitle,
                subscription: activeServiceRequestResponseEntity?.subscription,
                garanty_IsGaranty: activeServiceRequestResponseEntity?.guaranty,
              ),
            ),)),
            evaluation: (dialogDataModel) {
              showDialog(
                context: context,
                builder: (BuildContext _) {
                  return AlertDialog(
                    content: Text(
                      dialogDataModel.description,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                    WidgetStateProperty.all<Color>(
                                        AppTheme.blue)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  context
                                      .read<FinalizeInvoiceCubit>()
                                      .onOfflineLaborSubmit(
                                      confirmValidation: true);
                                },
                                child: Text(
                                  'تائید',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: AppTheme.whiteColor),
                                )),
                          ),
                          Space.w16,
                          Expanded(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                    WidgetStateProperty.all<Color>(
                                        Colors.red)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'لغو',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: AppTheme.whiteColor),
                                )),
                          ),

                        ],
                      )
                    ],
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
                    },
                  );
                },
              );
            }
        );
      },
      builder: (context, state) {
        return StreamBuilder<List<File?>>(
          stream: cubit.photosStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async{
                      await cubit.addPhoto();
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
                        child: Center(
                          child: Text('افزودن تصویر',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.green,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Space.h24,
                  const Text('هیچ تصویری وجود ندارد.', style: TextStyle(fontSize: 18.0)),
                  Space.h16,
                  const Spacer(),
                  _buildConfirmationButton(
                      context: context, showLoading: cubit.state.maybeWhen(
                      orElse: () => false,
                      submitLoading: () => true
                  )),
                ],
              );
            }
            final photos = snapshot.data!;
            return ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                if(photos.length <= 4)InkWell(
                  onTap: () async{
                    await cubit.addPhoto();
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
                      child: Center(
                        child: Text('افزودن تصویر',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.green,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Space.h24,
                const Text(
                  'تصویرهای گرفته شده:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0
                  ),
                ),
                Space.h16,
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    final photo = photos[index];
                    return Padding(
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
                                child: Container(
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
                                                title: '',
                                                body: 'آیا از حذف تصویر اطمینان دارید؟',
                                                positiveFunc: () {
                                                  cubit.removePhoto(photo ?? File(''));
                                                },
                                              );
                                            });
                                      },
                                      icon: const Icon(Icons.delete, color: Colors.red, size: 28.0,)),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                ),
                Space.h16,
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.warning_amber_sharp, size: 24.0, color: AppTheme.darkThemeSecondary,),
                    Space.w8,
                    Expanded(
                      child: Text(
                        'افزودن حداقل 3 تصویر و حداکثر 5 تصویر الزامی می باشد',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0
                        ),
                      ),
                    ),
                  ],
                ),
                Space.h16,
                _buildConfirmationButton(
                    context: context, showLoading: cubit.state.maybeWhen(
                    orElse: () => false,
                    submitLoading: () => true
                )),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildConfirmationButton({required BuildContext context, bool? showLoading}) {
    final isImageMandatory = lastEvaluationEntity?.servicesAndLaborsAndPartsEvaluationPayloadEntity?.evaluationServiceEntity?[0].isImageMandatory ?? false;
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
                onTap: () {
                  if(cubit.getPhotoList().length >= 3) {
                    cubit.callEmdadgarEvaluation(lastEvaluationEntity: lastEvaluationEntity);
                    return ;
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const MessageDialogWidget(
                            color: AppTheme.blue,
                            dismissible: false,
                            title: '',
                            body: 'افزودن حداقل 3 تصویر الزامی می باشد',
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
