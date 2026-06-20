import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/common/utils/extensions/string_ext.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/cost_center_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_labor_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/labor_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/cubit/home_service_evaluation_second_step_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/cubit/labors_and_parts_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/cubit/labors_and_parts_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/ek_choose_car_problem_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/ek_input_decorator_text_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaborRegistrationPage extends StatelessWidget {
  const LaborRegistrationPage({
    super.key,
    required this.serviceIndex,
    this.entity,
  });

  final LaborResponseEntity? entity;
  final int serviceIndex;



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        var bloc = getIt<LaborsAndPartsCubit>();
        bloc.selectLabor(entity: entity);
        return bloc;
      },
      child: _build(context),
    );
  }

  Widget _build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: 'ثبت اجرت'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<LaborsAndPartsCubit, LaborsAndPartsState>(
          builder: (BuildContext context, state) {
            final cubit = context.read<LaborsAndPartsCubit>();
            final laborItem = cubit.selectLaborResponseEntity;
            final costCenterList = laborItem?.allowableCostCenterList ?? [];
            final hasCostCenters = costCenterList.isNotEmpty;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                EkChooseCarProblemButton(
                  title: cubit.selectLaborResponseEntity?.name ?? '-',
                  label: 'نام اجرت',
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  height: 67,
                ),
                Space.h16,
                if (hasCostCenters)
                  EkDropDown(
                    costCenterList.map((e) => e.name ?? '').toList(),
                    borderColor: Colors.grey,
                    prefixIcon: const SizedBox(),
                    postfixIcon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.grey,
                      size: 24,
                    ),
                    selectedItem:
                        cubit.selectLaborCostCenterEntity?.name ??
                        'لطفا یک گزینه را انتخاب کنید',
                    label:
                        'مرکز هزینه'
                        ' *',
                    onItemValue: (value) {
                      _onCostCenterSelected(value, context);
                    },
                  ),
                if (hasCostCenters) Space.h16,
                StreamBuilder<String?>(
                  stream: cubit.priceLaborSubject,
                  builder: (context, snapshot) {
                    if (snapshot.data?.isNotEmpty ?? false) {
                      return EkInputDecoratorTextBox(
                        label: 'قیمت',
                        text: snapshot.data
                            .toString()
                            .splitPriceByComma()
                            .addPriceTag()
                            .convertNumberWithLanguage(),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                Space.h16,
                InkwellButtonWidget(
                  title: 'تائید',
                  backgroundColor: ServiceType.homeService.serviceColor,
                  onTap: () {
                    _onConfirmButtonPressed(context, serviceIndex);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onCostCenterSelected(String value, BuildContext context) {
    final cubit = context.read<LaborsAndPartsCubit>();
    final costCenterList =
        cubit.selectLaborResponseEntity?.allowableCostCenterList ?? [];
    final costCenter = costCenterList.firstWhere(
      (i) => i.name == value,
      orElse: () => CostCenterEntity().toModel(),
    );
    cubit.selectLaborCostCenterEntity = costCenter;
    cubit.selectLaborCostCenterEntity?.id == 0
        ? cubit.priceLaborSubject.add(
            cubit.selectLaborResponseEntity?.customerPrice ?? '0',
          )
        : cubit.priceLaborSubject.add(
            cubit.selectLaborResponseEntity?.companyPrice ?? '0',
          );
  }

  void _onConfirmButtonPressed(BuildContext context, int serviceIndex) {
    final cubit = context.read<LaborsAndPartsCubit>();
    final selectedLabor = cubit.selectLaborResponseEntity;
    final overlapCodes = cubit.overlapCodes;
    if (HomeServiceEvaluationSecondStepCubit
            .selectedServiceList?[serviceIndex]
            .evaluationLabors ==
        null) {
      HomeServiceEvaluationSecondStepCubit
              .selectedServiceList?[serviceIndex]
              .evaluationLabors =
          [];
    }
    final laborsList =
        HomeServiceEvaluationSecondStepCubit
            .selectedServiceList?[serviceIndex]
            .evaluationLabors ??
        [];

    if (_hasOverlap(selectedLabor?.overlapCodes, overlapCodes)) {
      _showBottomSheet(
        context,
        'خطا',
        'امکان افزودن اجرت به علت هم‌پوشانی وجود ندارد',
      );
      return;
    }

    if (_isLaborUnique(selectedLabor?.id, laborsList) &&
        selectedLabor != null &&
        selectedLabor.name != null) {
      final evaluationLaborResponseEntity = EvaluationLaborResponseEntity(
        laborGroupId: selectedLabor.laborGroupId,
        laborId: selectedLabor.id,
        laborName: selectedLabor.name,
        laborCode: selectedLabor.code,
        laborPrice: int.tryParse(cubit.priceLaborSubject.valueOrNull ?? '0'),
        // laborGroupDesc: selectedLabor.d,
        standardTime: selectedLabor.standardTime,
        parts: [],
        overlapCodes: selectedLabor.overlapCodes,
        costCenterObject: cubit.selectLaborCostCenterEntity,
        needImage: selectedLabor.needImage,
      );
      laborsList.add(evaluationLaborResponseEntity);
      overlapCodes.addAll(selectedLabor.overlapCodes?.split(',') ?? []);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } else {
      _showBottomSheet(context, '', 'لطفا موارد ستاره دار را تکمیل نمائید');
    }
  }

  bool _hasOverlap(String? overlapCodes, List<String> existingCodes) {
    final selectedCodes = overlapCodes?.split(',');
    return selectedCodes?.any(existingCodes.contains) ?? false;
  }

  bool _isLaborUnique(int? id, List<EvaluationLaborResponseEntity> laborsList) {
    return !laborsList.any((labor) => labor.laborId == id);
  }

  void _showBottomSheet(BuildContext context, String title, String body) {
    BottomSheetMessage.showNotice(
      buttonColor: ServiceType.homeService.serviceColor,
      context: context,
      data: BottomSheetMessageModel(title: title, message: body),
      isDismissible: true,
      enableDrag: true,
    );
  }
}
