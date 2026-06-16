import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/common/utils/digit_to_word.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/cost_center_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/reusable_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/cubit/labors_and_parts_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/cubit/labors_and_parts_state.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/widgets/search_customer_part_page.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/widgets/search_reusable_page.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/ek_choose_car_problem_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditAndRegistrationPartWidget extends StatelessWidget {
  const EditAndRegistrationPartWidget({
    super.key,
    this.partResponseEntity,
    this.isEditablePart,
    this.evaluationPartEntity,
    required this.serviceIndex,
    required this.laborIndex,
    required this.partIndex,
    this.changeCustomerPart,
    this.partCustomerIndex,
  });

  final int laborIndex;
  final int serviceIndex;
  final int partIndex;
  final bool? isEditablePart;
  final PartResponseEntity? partResponseEntity;
  final EvaluationPartResponseEntity? evaluationPartEntity;
  final bool? changeCustomerPart;
  final int? partCustomerIndex;

  @override
  String? screenName(BuildContext context) {
    return 'ثبت قطعه';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        var bloc = getIt<LaborsAndPartsCubit>();
        bloc.selectPart(
          partResponseEntity: partResponseEntity,
          evaluationPartEntity: evaluationPartEntity,
          isEditablePart: isEditablePart,
        );
        return bloc;
      },
      child: Builder(
        builder: (context) {
          return _build(context);
        },
      ),
    );
  }

  Widget _build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocConsumer<LaborsAndPartsCubit, LaborsAndPartsState>(
        listener: (BuildContext context, LaborsAndPartsState state) {
          state.whenOrNull(
            error: (bottomSheetMessage) {
              return BottomSheetMessage.showError(
                context: context,
                data: bottomSheetMessage,
                isDismissible: false,
                enableDrag: false,
              );
            },
            notice: (bottomSheetMessage) {
              return BottomSheetMessage.showNotice(
                buttonColor: ServiceType.homeService.serviceColor,
                context: context,
                data: bottomSheetMessage,
                isDismissible: true,
                enableDrag: true,
              );
            },
            submitEditPartMarkSuccess: () => Navigator.of(context).pop(),
            submitAddPartMarkSuccess: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              if (changeCustomerPart ?? false) {
                Navigator.of(context).pop();
              }
            },
          );
        },
        builder: (BuildContext context, state) {
          return state.maybeWhen(
            loading: () => CircularProgressIndicator(
              color: ServiceType.homeService.serviceColor,
            ),
            orElse: () => _successPartMarkWidget(context: context),
          );
        },
      ),
    );
  }

  Widget _successPartMarkWidget({required BuildContext context}) {
    final cubit = context.read<LaborsAndPartsCubit>();
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: [
        _partMarkContainer(context: context),
        BlocBuilder<LaborsAndPartsCubit, LaborsAndPartsState>(
          builder: (BuildContext context, LaborsAndPartsState state) {
            return state.maybeWhen(
              partPriceLoading: () => Center(
                child: SizedBox(
                  height: 60.0,
                  child: CircularProgressIndicator(
                    color: ServiceType.homeService.serviceColor,
                  ),
                ),
              ),
              partPriceSuccess: () => _successPartPriceWidget(context: context),
              reusablePriceSuccess: () =>
                  _successPartPriceWidget(context: context),
              orElse: () => const SizedBox(),
            );
          },
        ),
        Space.h16,
        InkwellButtonWidget(
          title: 'تائید',
          backgroundColor: ServiceType.homeService.serviceColor,
          onTap: () {
            if (changeCustomerPart ?? false) {
              cubit.submitCustomerPart(
                serviceIndex: serviceIndex,
                laborIndex: laborIndex,
                partIndex: partCustomerIndex ?? 0,
              );
              return;
            }
            cubit.submitPart(
              laborIndex: laborIndex,
              serviceIndex: serviceIndex,
              partIndex: partIndex,
              isEditablePart: isEditablePart,
            );
          },
        ),
      ],
    );
  }

  Widget _successPartPriceWidget({required BuildContext context}) {
    final cubit = context.read<LaborsAndPartsCubit>();
    return Column(
      children: [
        TextFormFieldWidget(
          controller: cubit.priceController,

          labelText: 'مبلغ قطعه',
          mandatory: true,
          textInputType: TextInputType.number,
          readOnly: cubit.selectPartResponseEntity?.mark == '500'
              ? false
              : true,
          maxLength: 8,
          onChanged: (value) {
            cubit.pricePartSubject.add(value);
          },
        ),
        Space.h8,
        StreamBuilder<String?>(
          stream: cubit.pricePartSubject,
          builder: (context, snapshot) {
            return (snapshot.data?.isNotEmpty ?? false)
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${DigitToWord.toWord(snapshot.data, StrType.numWord)} ریال',
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : const SizedBox();
          },
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
                          final updateReusable = reusable?.copyWith(
                            isActive: value,
                          );
                          cubit.reusableSubject.add(updateReusable);
                        },
                      ),
                      Text(
                        'داغی دارد',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  Space.h12,
                  TextFormFieldWidget(
                    onTap: () => Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            BlocProvider.value(
                              value: cubit,
                              child: SearchReusablePage(
                                laborIndex: laborIndex,
                                serviceIndex: serviceIndex,
                              ),
                            ),
                        transitionDuration: const Duration(milliseconds: 500),
                        reverseTransitionDuration: const Duration(
                          milliseconds: 500,
                        ),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              final slideUpAnimation =
                                  Tween<Offset>(
                                    begin: const Offset(0, 1),
                                    end: Offset.zero,
                                  ).animate(
                                    CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeOut,
                                      reverseCurve: Curves.easeIn,
                                    ),
                                  );
                              return SlideTransition(
                                position: slideUpAnimation,
                                child: child,
                              );
                            },
                      ),
                    ),
                    hintText: (cubit.reusableTitleController.text.isNotEmpty)
                        ? 'نام قطعه داغی'
                        : 'انتخاب قطعه داغی',
                    readOnly: true,
                    mandatory: true,
                    controller: cubit.reusableTitleController,
                  ),
                  Space.h16,
                  if (cubit.reusableSubject.valueOrNull?.price != -1)
                    TextFormFieldWidget(
                      hintText: 'قیمت قطعه داغی',
                      readOnly: true,
                      mandatory: true,
                      controller: cubit.reusablePriceController,
                    ),
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
    final cubit = context.read<LaborsAndPartsCubit>();
    return Column(
      children: [
        EkChooseCarProblemButton(
          title: cubit.selectPartResponseEntity?.name ?? '-',
          label: 'قطعه',
          onTap: () {
            if (isEditablePart ?? false) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SearchCustomerPartPage(
                    serviceIndex: serviceIndex,
                    laborIndex: laborIndex,
                    customerPartIndex: partCustomerIndex ?? 0,
                  ),
                ),
              );
            }
          },
          height: 67,
        ),
        Space.h16,
        if (cubit.selectPartResponseEntity != null)
          EkDropDown(
            cubit.markList.map((e) => e?.mark ?? '').toList(),
            borderColor: Colors.grey,
            postfixIcon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.grey,
              size: 24,
            ),
            selectedItem:
                cubit.selectPartResponseEntity?.mark ??
                "لطفا یک گزینه انتخاب کنید",
            label:
                'مارک‌ها'
                ' *',
            onItemValue: (value) {
              cubit.selectPartResponseEntity?.mark = value;
              cubit.getPartPrice(mark: value);
            },
          ),
        Space.h16,
        if (cubit
                .selectPartResponseEntity
                ?.allowableCostCenterList
                ?.isNotEmpty ??
            false) ...[
          EkDropDown(
            fillColor: Colors.white,
            cubit.selectPartResponseEntity?.allowableCostCenterList
                    ?.map((e) => e.name ?? '')
                    .toList() ??
                [],
            borderColor: Colors.grey,
            prefixIcon: const SizedBox(),
            postfixIcon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.grey,
              size: 24,
            ),
            selectedItem:
                cubit.selectPartCostCenterEntity?.name ??
                'لطفا یک گزینه را انتخاب کنید',
            label:
                'مرکز هزینه'
                ' *',
            onItemValue: (value) {
              final costCenterList =
                  cubit.selectPartResponseEntity?.allowableCostCenterList ?? [];
              cubit.selectPartCostCenterEntity = costCenterList.firstWhere(
                (i) => i.name == value,
                orElse: () => CostCenterEntity().toModel(),
              );
            },
          ),
          Space.h16,
        ],
        TextFormFieldWidget(
          controller: cubit.countController,
          textDirection: TextDirection.ltr,
          textInputType: TextInputType.number,
          labelText: 'تعداد',
          mandatory: true,
          maxLength: 3,
        ),
        Space.h16,
      ],
    );
  }
}
