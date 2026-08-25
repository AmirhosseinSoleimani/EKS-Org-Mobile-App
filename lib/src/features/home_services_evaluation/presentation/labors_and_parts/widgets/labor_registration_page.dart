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
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/ek_choose_car_problem_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaborRegistrationPage extends StatelessWidget {
  const LaborRegistrationPage({
    super.key,
    required this.serviceIndex,
    this.entity,
    this.evaluationLaborEntity,
    this.laborIndex,
  });

  final LaborResponseEntity? entity;
  final EvaluationLaborResponseEntity? evaluationLaborEntity;
  final int? laborIndex;
  final int serviceIndex;

  bool get isEditing => evaluationLaborEntity != null && laborIndex != null;

  @override
  Widget build(BuildContext context) {
    final laborEntity = entity ?? _mapEvaluationLaborToResponse();

    return BlocProvider(
      create: (_) {
        final bloc = getIt<LaborsAndPartsCubit>();
        bloc.selectLabor(entity: laborEntity);

        if (isEditing) {
          bloc.priceLaborSubject.add(
            evaluationLaborEntity?.laborPrice?.toString() ?? '0',
          );
          bloc.selectLaborCostCenterEntity =
              evaluationLaborEntity?.costCenterObject;
        }

        return bloc;
      },
      child: LaborRegistrationPageBody(
        entity: laborEntity,
        serviceIndex: serviceIndex,
        evaluationLaborEntity: evaluationLaborEntity,
        laborIndex: laborIndex,
      ),
    );
  }

  LaborResponseEntity? _mapEvaluationLaborToResponse() {
    final labor = evaluationLaborEntity;
    if (labor == null) return null;

    final costCenters = labor.costCenterList?.isNotEmpty == true
        ? labor.costCenterList
        : labor.costCenterObject != null
        ? [labor.costCenterObject!]
        : <CostCenterEntity>[];
    final price = labor.laborPrice?.toString() ?? '0';

    return LaborResponseEntity(
      laborGroupId: labor.laborGroupId,
      name: labor.laborName,
      standardTime: labor.standardTime,
      id: labor.laborId,
      companyPrice: price,
      customerPrice: price,
      code: labor.laborCode,
      allowableCostCenterList: costCenters,
      overlapCodes: labor.overlapCodes,
      needImage: labor.needImage,
      isImageMandatory: labor.isImageMandatory,
      laborGroupTitle: labor.laborGroupDesc,
    );
  }
}

class LaborRegistrationPageBody extends StatelessWidget {
  final LaborResponseEntity? entity;
  final EvaluationLaborResponseEntity? evaluationLaborEntity;
  final int? laborIndex;
  final int serviceIndex;

  const LaborRegistrationPageBody({
    super.key,
    required this.entity,
    required this.serviceIndex,
    this.evaluationLaborEntity,
    this.laborIndex,
  });

  bool get isEditing => evaluationLaborEntity != null && laborIndex != null;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LaborsAndPartsCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SimpleAppBar(title: isEditing ? 'ویرایش اجرت' : 'ثبت اجرت'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormSectionContainer(
          hasBorder: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: AlignmentGeometry.topRight,
                child: TitleLargeText(
                  text: isEditing ? 'ویرایش جزئیات اجرت' : 'جزئیات اجرت',
                  fontSize: 16,
                ),
              ),
              Space.h16,
              Divider(thickness: 0.5, color: Colors.grey.withAlpha(150)),
              Space.h32,
              BlocBuilder<LaborsAndPartsCubit, LaborsAndPartsState>(
                builder: (BuildContext context, state) {
                  final laborItem = cubit.selectLaborResponseEntity;
                  final costCenterList =
                      laborItem?.allowableCostCenterList ?? [];
                  final hasCostCenters = costCenterList.isNotEmpty;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      EkChooseCarProblemButton(
                        title: cubit.selectLaborResponseEntity?.name ?? '-',
                        label: 'نام اجرت',
                        onTap: isEditing
                            ? null
                            : () {
                                Navigator.of(context).pop();
                              },
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
                          label: 'مرکز هزینه *',
                          onItemValue: (value) {
                            _onCostCenterSelected(value, context);
                          },
                        ),
                      if (hasCostCenters) Space.h16,
                      StreamBuilder<String?>(
                        stream: cubit.priceLaborSubject,
                        builder: (context, snapshot) {
                          if (snapshot.data?.isNotEmpty ?? false) {
                            return TextFormFieldWidget(
                              labelText: 'قیمت',
                              controller: TextEditingController(
                                text: snapshot.data
                                    .toString()
                                    .splitPriceByComma()
                                    .addPriceTag()
                                    .convertNumberWithLanguage(),
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkwellButtonWidget(
          title: 'تائید',
          backgroundColor: ServiceType.homeService.serviceColor,
          onTap: () {
            _onConfirmButtonPressed(context, cubit, serviceIndex);
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

  void _onConfirmButtonPressed(
    BuildContext context,
    LaborsAndPartsCubit cubit,
    int serviceIndex,
  ) {
    final service = HomeServiceEvaluationSecondStepCubit
        .selectedServiceList?[serviceIndex];
    if (service == null) return;

    service.evaluationLabors ??= [];
    final laborsList = service.evaluationLabors!;
    final selectedLabor = cubit.selectLaborResponseEntity;

    if (selectedLabor == null || selectedLabor.name == null) {
      _showBottomSheet(context, '', 'لطفا موارد ستاره دار را تکمیل نمائید');
      return;
    }

    final currentLaborIndex = isEditing ? laborIndex : null;
    final existingOverlapCodes = _collectOverlapCodes(
      laborsList,
      excludedIndex: currentLaborIndex,
    );

    if (_hasOverlap(selectedLabor.overlapCodes, existingOverlapCodes)) {
      _showBottomSheet(
        context,
        'خطا',
        'امکان افزودن اجرت به علت هم‌پوشانی وجود ندارد',
      );
      return;
    }

    if (!_isLaborUnique(
      selectedLabor.id,
      laborsList,
      excludedIndex: currentLaborIndex,
    )) {
      _showBottomSheet(context, '', 'این اجرت قبلا انتخاب شده است');
      return;
    }

    final price = int.tryParse(cubit.priceLaborSubject.valueOrNull ?? '0');

    if (isEditing && currentLaborIndex != null) {
      if (currentLaborIndex < 0 || currentLaborIndex >= laborsList.length) {
        return;
      }

      final currentLabor = laborsList[currentLaborIndex];
      currentLabor.laborGroupId = selectedLabor.laborGroupId;
      currentLabor.laborGroupDesc = selectedLabor.laborGroupTitle;
      currentLabor.laborId = selectedLabor.id;
      currentLabor.laborName = selectedLabor.name;
      currentLabor.laborCode = selectedLabor.code;
      currentLabor.laborPrice = price;
      currentLabor.standardTime = selectedLabor.standardTime;
      currentLabor.overlapCodes = selectedLabor.overlapCodes;
      currentLabor.costCenterObject = cubit.selectLaborCostCenterEntity;
      currentLabor.costCenterList = selectedLabor.allowableCostCenterList;
      currentLabor.needImage = selectedLabor.needImage;
      currentLabor.isImageMandatory = selectedLabor.isImageMandatory;

      Navigator.of(context).pop();
      return;
    }

    laborsList.add(
      EvaluationLaborResponseEntity(
        laborGroupId: selectedLabor.laborGroupId,
        laborGroupDesc: selectedLabor.laborGroupTitle,
        laborId: selectedLabor.id,
        laborName: selectedLabor.name,
        laborCode: selectedLabor.code,
        laborPrice: price,
        standardTime: selectedLabor.standardTime,
        parts: [],
        overlapCodes: selectedLabor.overlapCodes,
        costCenterList: selectedLabor.allowableCostCenterList,
        costCenterObject: cubit.selectLaborCostCenterEntity,
        needImage: selectedLabor.needImage,
        isImageMandatory: selectedLabor.isImageMandatory,
      ),
    );

    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  List<String> _collectOverlapCodes(
    List<EvaluationLaborResponseEntity> laborsList, {
    int? excludedIndex,
  }) {
    return laborsList.asMap().entries
        .where((entry) => entry.key != excludedIndex)
        .expand<String>(
        (entry) =>
            entry.value.overlapCodes?.split(',') ?? const <String>[],
      )
        .map((code) => code.trim())
        .where((code) => code.isNotEmpty)
        .toList();
  }

  bool _hasOverlap(String? overlapCodes, List<String> existingCodes) {
    final selectedCodes = overlapCodes
        ?.split(',')
        .map((code) => code.trim())
        .where((code) => code.isNotEmpty);
    return selectedCodes?.any(existingCodes.contains) ?? false;
  }

  bool _isLaborUnique(
    int? id,
    List<EvaluationLaborResponseEntity> laborsList, {
    int? excludedIndex,
  }) {
    return !laborsList.asMap().entries.any(
      (entry) => entry.key != excludedIndex && entry.value.laborId == id,
    );
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
