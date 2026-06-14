import 'package:emdadgar_saipa/generated/l10n.dart';
import 'package:eks_sana_plus_org/src/common/utils/digit_to_word.dart';
import 'package:eks_sana_plus_org/src/config/themes/app_theme.dart';
import 'package:eks_sana_plus_org/src/core/presentation/pages/base_stateless_page.dart';
import 'package:eks_sana_plus_org/src/core/uikit/dialog/dialog_widgets.dart';
import 'package:eks_sana_plus_org/src/core/uikit/spacing.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_button/ek_button.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_choose_car_button/ek_choose_car_problem_button.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_dropdown/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_loading/ek_loading.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_textfield/ek_textfield.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/cost_center_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/reusable_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_part/cubit/home_service_part_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_part/cubit/home_service_part_state.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/widgets/search_customer_part_page.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/widgets/search_reusable_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeServicePartPage extends BaseStatelessPage {
  const HomeServicePartPage({
    super.key,
    this.partResponseEntity,
    required this.serviceIndex,
    required this.laborIndex,
    required this.partIndex,
  });
  final int laborIndex;
  final int serviceIndex;
  final int partIndex;
  final PartResponseEntity? partResponseEntity;


  @override
  bool? showAppBarDetails(BuildContext context) {
    return true;
  }

  @override
  String? screenName(BuildContext context) {
    return 'ثبت قطعه';
  }

  @override
  Widget body(BuildContext context) {
    return BlocProvider(
      create: (_) {
        var bloc = getIt<HomeServicePartCubit>();
        bloc.selectPart(partResponseEntity: partResponseEntity);
        return bloc;
      },
      child: Builder(builder: (context) {
        return _build(context);
      }),
    );
  }

  Widget _build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocConsumer<HomeServicePartCubit, HomeServicePartState>(
        listener: (BuildContext context, state) {
          state.whenOrNull(
            error: (dialogDataModel) {
              return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MessageDialogWidget(
                    color: AppTheme.blue,
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
            notice: (dialogDataModel) {
              return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MessageDialogWidget(
                    color: AppTheme.blue,
                    dismissible: true,
                    title: dialogDataModel.title,
                    body: dialogDataModel.description,
                    positiveTxt: S.of(context).ok,
                  );
                },
              );
            },
            submitEditPartMarkSuccess: () => Navigator.of(context).pop(),
            submitAddPartMarkSuccess: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          );
        },
        builder: (BuildContext context, state) {
          return state.maybeWhen(
            loading: () => const EkLoading(),
            orElse: () => _successPartMarkWidget(context: context),
          );
        },
      ),
    );
  }

  Widget _successPartMarkWidget({required BuildContext context}) {
    final cubit = context.read<HomeServicePartCubit>();
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: [
        _partMarkContainer(context: context),
        BlocBuilder<HomeServicePartCubit, HomeServicePartState>(
          builder: (BuildContext context, state) {
            return state.maybeWhen(
              partPriceLoading: () => const Center(
                child: SizedBox(
                  height: 60.0,
                  child: EkLoading(),
                ),
              ),
              partPriceSuccess: () => _successPartPriceWidget(context: context),
              reusablePriceSuccess: () => _successPartPriceWidget(context: context),
              orElse: () => const SizedBox(),
            );
          },
        ),
        Space.h16,
        EkButton(
          title: 'تائید',
          backgroundColor: AppTheme.blue,
          onTap: () {
            cubit.submitPart(laborIndex: laborIndex, serviceIndex: serviceIndex, partIndex: partIndex);
          },
        )
      ],
    );
  }

  Widget _successPartPriceWidget({required BuildContext context}) {
    final cubit = context.read<HomeServicePartCubit>();
    return Column(
      children: [
        EkTextField(
          height: Space.defaultTextFieldHeight,
          controller: cubit.priceController,
          isLtr: true,
          title: 'مبلغ قطعه',
          mandatory: true,
          keyboardType:
          TextInputType.number,
          readOnly: cubit.selectPartResponseEntity?.mark == '500' ? false : true,
          maxLength: 8,
          onChanged: (value) {
            cubit.pricePartSubject.add(value);
          },
        ),
        Space.h8,
        StreamBuilder<String?>(
            stream: cubit.pricePartSubject,
            builder: (context, snapshot) {
              return (snapshot.data?.isNotEmpty ?? false) ? Align(
                alignment: Alignment.centerRight,
                child: Text('${DigitToWord.toWord(snapshot.data, StrType.NumWord,)} ریال',
                  style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ) : const SizedBox();
            }
        ),
        StreamBuilder<ReusableEntity?>(
          stream: cubit.reusableSubject,
          builder: (context, snapshot) {
            if (snapshot.data?.hasReusable ?? false) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: snapshot.data?.isActive ?? false,
                        onChanged: (value) {
                          final reusable = cubit.reusableSubject.valueOrNull;
                          final updateReusable = reusable?.copyWith(isActive: value);
                          cubit.reusableSubject.add(updateReusable);
                        },
                      ),
                      Text(
                        'داغی دارد',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium,
                      )
                    ],
                  ),
                  Space.h12,
                  EkTextField(
                    onTap: () => Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => BlocProvider.value(
                          value: cubit,
                          child: SearchReusablePage(
                            laborIndex: laborIndex,
                            serviceIndex: serviceIndex,
                          ),
                        ),
                        transitionDuration: const Duration(milliseconds: 500),
                        reverseTransitionDuration: const Duration(milliseconds: 500),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          final slideUpAnimation = Tween<Offset>(
                            begin: const Offset(0, 1),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOut,
                            reverseCurve: Curves.easeIn,
                          ));
                          return SlideTransition(
                            position: slideUpAnimation,
                            child: child,
                          );
                        },
                      ),
                    ),
                    title: (cubit.reusableTitleController.text.isNotEmpty) ?'نام قطعه داغی' : 'انتخاب قطعه داغی',
                    readOnly: true,
                    height: 35.0,
                    mandatory: true,
                    controller: cubit.reusableTitleController,
                  ),
                  Space.h16,
                  if(cubit.reusableSubject.valueOrNull?.price != -1)
                    EkTextField(
                      title: 'قیمت قطعه داغی',
                      readOnly: true,
                      mandatory: true,
                      height: 35.0,
                      controller: cubit.reusablePriceController,
                    )
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }

  Widget _partMarkContainer({required BuildContext context}) {
    final cubit = context.read<HomeServicePartCubit>();
    return Column(
      children: [
        EkChooseCarProblemButton(
          title: cubit.selectPartResponseEntity?.name ?? '-',
          label: 'قطعه',
          onTap: () {
            // if(isEditablePart ?? false) {
            //   Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchCustomerPartPage(
            //     serviceIndex: serviceIndex,
            //     laborIndex: laborIndex,
            //     customerPartIndex: partCustomerIndex ?? 0,
            //   )));
            // }
          },
          height: 67,
        ),
        Space.h16,
        if(cubit.selectPartResponseEntity != null)EkDropDown(
          cubit.markList.map((e) => e?.mark ?? '').toList(),
          borderColor: AppTheme.darkThemePrimaryLight,
          postfixIcon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppTheme.darkThemePrimaryLight,
            size: 24,
          ),
          selectedItem: cubit.selectPartResponseEntity?.mark ?? S.of(context).selectOneItem,
          label: 'مارک‌ها' ' *',
          onItemValue: (value) {
            cubit.selectPartResponseEntity?.mark = value;
            cubit.getPartPrice(mark: value);
          },
        ),
        Space.h16,
        if (cubit.selectPartResponseEntity?.allowableCostCenterList?.isNotEmpty ?? false)...[
          EkDropDown(
            fillColor: AppTheme.whiteColor,
            cubit.selectPartResponseEntity?.allowableCostCenterList?.map((e) => e.name ?? '').toList() ?? [],
            borderColor: AppTheme.darkThemePrimaryLight,
            prefixIcon: const SizedBox(),
            postfixIcon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppTheme.darkThemePrimaryLight,
              size: 24,
            ),
            selectedItem: cubit.selectPartCostCenterEntity?.name ?? 'لطفا یک گزینه را انتخاب کنید',
            label: 'مرکز هزینه' ' *',
            onItemValue: (value) {
              final costCenterList = cubit.selectPartResponseEntity?.allowableCostCenterList ?? [];
              cubit.selectPartCostCenterEntity = costCenterList.firstWhere((i) => i.name == value,
                orElse: () => CostCenterEntity().toModel(),
              );
            },
          ),
          Space.h16,
        ],
        EkTextField(
          height: Space.defaultTextFieldHeight,
          controller: cubit.countController,
          isLtr: true,
          keyboardType: TextInputType.number,
          title: 'تعداد',
          mandatory: true,
          maxLength: 3,
        ),
        Space.h16,
      ],
    );
  }
}
