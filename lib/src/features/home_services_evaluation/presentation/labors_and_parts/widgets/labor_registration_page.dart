import 'package:eks_sana_plus_org/src/common/utils/extensions/string_ext.dart';
import 'package:eks_sana_plus_org/src/config/themes/app_theme.dart';
import 'package:eks_sana_plus_org/src/core/presentation/pages/base_stateless_page.dart';
import 'package:eks_sana_plus_org/src/core/uikit/dialog/dialog_widgets.dart';
import 'package:eks_sana_plus_org/src/core/uikit/spacing.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_button/ek_button.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_choose_car_button/ek_choose_car_problem_button.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_dropdown/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_input_decorator_text_box.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/cost_center_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_labor_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/labor_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/cubit/home_service_evaluation_second_step_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/cubit/labors_and_parts_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/cubit/labors_and_parts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaborRegistrationPage extends BaseStatelessPage {
  const LaborRegistrationPage({super.key,required this.serviceIndex, this.entity});
  final LaborResponseEntity? entity;
  final int serviceIndex;

  @override
  bool? showAppBarDetails(BuildContext context) {
    return true;
  }

  @override
  String? screenName(BuildContext context) {
    return 'ثبت اجرت';
  }

  @override
  Widget body(BuildContext context) {
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
    return Padding(
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
              if (hasCostCenters)EkDropDown(
                costCenterList.map((e) => e.name ?? '').toList(),
                borderColor: AppTheme.darkThemePrimaryLight,
                prefixIcon: const SizedBox(),
                postfixIcon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppTheme.darkThemePrimaryLight,
                  size: 24,
                ),
                selectedItem: cubit.selectLaborCostCenterEntity?.name ?? 'لطفا یک گزینه را انتخاب کنید',
                label: 'مرکز هزینه' ' *',
                onItemValue: (value) {
                  _onCostCenterSelected(value, context);
                },
              ),
              if (hasCostCenters) Space.h16,
                StreamBuilder<String?>(
                  stream: cubit.priceLaborSubject,
                  builder: (context, snapshot) {
                    if(snapshot.data?.isNotEmpty ?? false) {
                      return EkInputDecoratorTextBox(
                          label: 'قیمت',
                          text: snapshot.data.toString().splitPriceByComma().addPriceTag().convertNumberWithLanguage());
                    } else {
                      return const SizedBox();
                    }

                  },

              ),
              Space.h16,
              EkButton(
                title: 'تائید',
                backgroundColor: AppTheme.blue,
                onTap: () {
                  _onConfirmButtonPressed(context, serviceIndex);
                },
              )
            ],
          );
        },
      ),
    );
  }

  void _onCostCenterSelected(String value, BuildContext context) {
    final cubit = context.read<LaborsAndPartsCubit>();
    final costCenterList = cubit.selectLaborResponseEntity?.allowableCostCenterList ?? [];
    final costCenter = costCenterList.firstWhere((i) => i.name == value, orElse: () => CostCenterEntity().toModel(),);
    cubit.selectLaborCostCenterEntity = costCenter;
    cubit.selectLaborCostCenterEntity ?.id == 0 ?
          cubit.priceLaborSubject.add(cubit.selectLaborResponseEntity?.customerPrice ?? '0') :
          cubit.priceLaborSubject.add(cubit.selectLaborResponseEntity?.companyPrice ?? '0');
  }

  void _onConfirmButtonPressed(BuildContext context, int serviceIndex) {
    final cubit = context.read<LaborsAndPartsCubit>();
    final selectedLabor = cubit.selectLaborResponseEntity;
    final overlapCodes = cubit.overlapCodes;
    if(HomeServiceEvaluationSecondStepCubit.selectedServiceList?[serviceIndex].evaluationLabors == null) {
      HomeServiceEvaluationSecondStepCubit.selectedServiceList?[serviceIndex].evaluationLabors = [];
    }
    final laborsList = HomeServiceEvaluationSecondStepCubit.selectedServiceList?[serviceIndex].evaluationLabors ?? [];

    if (_hasOverlap(selectedLabor?.overlapCodes, overlapCodes)) {
      _showDialog(context, 'خطا', 'امکان افزودن اجرت به علت هم‌پوشانی وجود ندارد');
      return;
    }

    if (_isLaborUnique(selectedLabor?.id, laborsList) && selectedLabor != null && selectedLabor.name != null) {

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
      _showDialog(context, '', 'لطفا موارد ستاره دار را تکمیل نمائید');
    }
  }

  bool _hasOverlap(String? overlapCodes, List<String> existingCodes) {
    final selectedCodes = overlapCodes?.split(',');
    return selectedCodes?.any(existingCodes.contains) ?? false;
  }

  bool _isLaborUnique(int? id, List<EvaluationLaborResponseEntity> laborsList) {
    return !laborsList.any((labor) => labor.laborId == id);
  }

  void _showDialog(BuildContext context, String title, String body) {
    showDialog(
      context: context,
      builder: (context) => MessageDialogWidget(
        dismissible: true,
        title: title,
        body: body,
      ),
    );
  }
}
