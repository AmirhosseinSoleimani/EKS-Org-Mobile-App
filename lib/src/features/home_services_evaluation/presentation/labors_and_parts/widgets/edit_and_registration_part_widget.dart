import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/cost_center_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_mark_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/reusable_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/cubit/labors_and_parts_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/cubit/labors_and_parts_state.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/widgets/search_reusable_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/dropdown_selector.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/searchable_dropdown_selector.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/formatter/thousands_separator_input_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
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
    return Scaffold(
      appBar: SimpleAppBar(title: 'ثبت قطعه'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormSectionContainer(
          hasBorder: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(alignment: AlignmentGeometry.topRight,
                  child: TitleLargeText(text: "قطعه", fontSize: 16,)),
              Space.h16,
              Divider(thickness: 0.5,color: Colors.grey.withAlpha(150)),
              Space.h32,
              BlocConsumer<LaborsAndPartsCubit, LaborsAndPartsState>(
                listener: (BuildContext context, LaborsAndPartsState state) {
                  state.whenOrNull(
                    error: (bottomSheetMessage) {
                      return BottomSheetMessage.showError(
                        context: context,
                        data: bottomSheetMessage,
                        isDismissible: true,
                        enableDrag: true,
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
                    submitEditPartMarkSuccess: () =>
                        Navigator.of(context).pop(),
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
                    loading: () =>
                        Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              color: ServiceType.homeService.serviceColor,
                            ),
                          ),
                        ),
                    orElse: () => _successPartMarkWidget(context: context),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: InkwellButtonWidget(
          title: 'تائید',
          backgroundColor: ServiceType.homeService.serviceColor,
          onTap: () {
            final cubit = context.read<LaborsAndPartsCubit>();
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
      ),
    );
  }

  Widget _successPartMarkWidget({required BuildContext context}) {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: [
        _partMarkContainer(context: context),
        BlocBuilder<LaborsAndPartsCubit, LaborsAndPartsState>(
          builder: (BuildContext context, LaborsAndPartsState state) {
            return state.maybeWhen(
              partPriceSuccess: () => _successPartPriceWidget(context: context),
              reusablePriceSuccess: () =>
                  _successPartPriceWidget(context: context),
              orElse: () => const SizedBox(),
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
        BlocBuilder<LaborsAndPartsCubit, LaborsAndPartsState>(
          builder: (context, state) {
            final isLoading = state.maybeWhen(
              partLoading: () => true,
              orElse: () => false,
            );

            return StreamBuilder<List<PartResponseEntity?>>(
              stream: cubit.partResponseListSubject.stream,
              builder: (context, snapshot) {
                final items = snapshot.data ?? [];
                cubit.searchPartController.text =
                    cubit.selectPartResponseEntity.value?.name ?? '-';
                return SearchableDropdownSelector<PartResponseEntity>(
                  label: 'نام قطعه',
                  hintText: 'حداقل ۳ کاراکتر وارد کنید',
                  controller: cubit.searchPartController,
                  selectedNotifier: cubit.selectPartResponseEntity,
                  items: items.whereType<PartResponseEntity>().toList(),
                  isLoading: isLoading,
                  itemTitleBuilder: (item) => item.name ?? '',
                  onSearchChanged: (query) {
                    if (query.length >= 3) {
                      cubit.getCustomerPart(
                        value: query,
                        laborIndex: laborIndex,
                        serviceIndex: serviceIndex,
                      );
                    }
                  },
                  onSelect: (item) =>
                      cubit.selectPart(partResponseEntity: item),
                );
              },
            );
          },
        ),
        Space.h16,
        if (cubit
            .selectPartResponseEntity
            .value
            ?.allowableCostCenterList
            ?.isNotEmpty ??
            false) ...[
          ValueListenableBuilder<PartResponseEntity?>(
            valueListenable: cubit.selectPartResponseEntity,
            builder: (context, part, _) {
              final items = part?.allowableCostCenterList ?? [];

              return DropdownSelector<CostCenterEntity>(
                label: 'مرکز هزینه',
                placeholder: 'انتخاب مرکز هزینه',
                selectedNotifier: cubit.selectPartCostCenterEntity,
                items: items,
                enabled: items.isNotEmpty,
                itemTitleBuilder: (item) => item.name ?? '',
                onSelect: (value) {
                  final costCenterList =
                      cubit
                          .selectPartResponseEntity
                          .value
                          ?.allowableCostCenterList ??
                          [];
                  cubit.selectPartCostCenterEntity.value = costCenterList
                      .firstWhere(
                        (i) => i.id == value.id,
                    orElse: () => CostCenterEntity().toModel(),
                  );
                },
              );
            },
          ),
          Space.h16,
        ],

        if (cubit.selectPartResponseEntity.value != null)
          BlocBuilder<LaborsAndPartsCubit, LaborsAndPartsState>(
            builder: (context, state) {
              final cubit = context.read<LaborsAndPartsCubit>();

              final isLoading = state.maybeWhen(
                markLoading: () => true,
                orElse: () => false,
              );

              return ValueListenableBuilder<List<PartMarkResponseEntity>>(
                valueListenable: cubit.markList,
                builder: (context, items, _) {
                  return DropdownSelector<PartMarkResponseEntity>(
                    label: 'مارک ها',
                    placeholder: isLoading
                        ? 'در حال بارگذاری...'
                        : 'انتخاب مارک',
                    selectedNotifier: cubit.selectedMark,
                    items: items,
                    isLoading: isLoading,
                    enabled: items.isNotEmpty && !isLoading,
                    itemTitleBuilder: (item) => item.mark ?? '',
                    onSelect: (value) {
                      cubit.selectPartResponseEntity.value?.mark = value.mark;
                      cubit.getPartPrice(mark: value.mark);
                      cubit.selectedMark.value = value;
                    },
                  );
                },
              );
            },
          ),

        Space.h16,
        Row(
          children: [
            Expanded(
              child: BlocBuilder<LaborsAndPartsCubit, LaborsAndPartsState>(
                builder: (context, state) {
                  final cubit = context.read<LaborsAndPartsCubit>();

                  final isLoading = state.maybeWhen(
                    partPriceLoading: () => true,
                    orElse: () => false,
                  );

                  return TextFormFieldWidget(
                    controller: cubit.priceController,
                    labelText: 'قیمت',
                    hintText: 'قیمت',
                    readOnly: cubit.selectPartResponseEntity.value?.mark ==
                        '500'
                        ? false
                        : true,
                    maxLength: 8,
                    textInputType: TextInputType.number,
                    textInputFormatter: const [
                      ThousandsSeparatorInputFormatter(),
                    ],
                    suffixIcon: isLoading
                        ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                        : null,
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormFieldWidget(
                controller: cubit.countController,
                textDirection: TextDirection.ltr,
                labelText: 'تعداد',
                hintText: 'تعداد',
                maxLength: 3,
                mandatory: true,
                textInputType: TextInputType.number,
              ),
            ),
          ],
        ),
        Space.h16,
      ],
    );
  }
}
