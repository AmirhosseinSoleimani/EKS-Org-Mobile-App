import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/reusable_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_part/cubit/home_service_part_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_part/cubit/home_service_part_state.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/widgets/search_reusable_page.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/ek_choose_car_problem_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/formatter/thousands_separator_input_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeServicePartPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = getIt<HomeServicePartCubit>();
        bloc.selectPart(partResponseEntity: partResponseEntity);
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(alignment: AlignmentGeometry.topRight,
                  child: TitleLargeText(text: "قطعه", fontSize: 16)),
              Space.h16,
              Divider(thickness: 0.5, color: Colors.grey.withAlpha(150)),
              Space.h32,
              BlocConsumer<HomeServicePartCubit, HomeServicePartState>(
                listener: (context, state) {
                  state.whenOrNull(
                    error: (bottomSheetMessageModel) {
                      BottomSheetMessage.showError(
                        isDismissible: true,
                        context: context,
                        data: bottomSheetMessageModel,
                      );
                    },
                    notice: (bottomSheetMessageModel) {
                      BottomSheetMessage.showNotice(
                        isDismissible: true,
                        context: context,
                        data: bottomSheetMessageModel,
                        buttonColor: ServiceType.homeService.serviceColor,
                      );
                    },
                    submitEditPartMarkSuccess: () {
                      Navigator.of(context).pop();
                    },
                    submitAddPartMarkSuccess: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () =>
                        Center(
                            child: CircularProgressIndicator(color: ServiceType
                                .homeService.serviceColor)),
                    orElse: () => _successPartMarkWidget(context: context),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(16),
        child: InkwellButtonWidget(
          title: 'تائید',
          backgroundColor: ServiceType.homeService.serviceColor,
          onTap: () {
            final cubit = context.read<HomeServicePartCubit>();
            cubit.submitPart(
              laborIndex: laborIndex,
              serviceIndex: serviceIndex,
              partIndex: partIndex,
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

        BlocBuilder<HomeServicePartCubit, HomeServicePartState>(
          builder: (context, state) {
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
    final cubit = context.read<HomeServicePartCubit>();

    return Column(
      children: [
        StreamBuilder<ReusableEntity?>(
          stream: cubit.reusableSubject,
          builder: (context, snapshot) {
            if (snapshot.data?.hasReusable ?? false) {
              return Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: snapshot.data?.isActive ?? false,
                        onChanged: (value) {
                          final reusable = cubit.reusableSubject.valueOrNull;

                          cubit.reusableSubject.add(
                            reusable?.copyWith(isActive: value),
                          );
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
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: cubit,
                          child: SearchReusablePage(
                            laborIndex: laborIndex,
                            serviceIndex: serviceIndex,
                          ),
                        ),
                      ),
                    ),
                    labelText: (cubit.reusableTitleController.text.isNotEmpty)
                        ? 'نام قطعه داغی'
                        : 'انتخاب قطعه داغی',
                    readOnly: true,

                    mandatory: true,
                    controller: cubit.reusableTitleController,
                  ),

                  Space.h16,

                  if (cubit.reusableSubject.valueOrNull?.price != -1)
                    TextFormFieldWidget(
                      labelText: 'قیمت قطعه داغی',
                      readOnly: true,
                      mandatory: true,
                      controller: cubit.reusablePriceController,
                    ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _partMarkContainer({required BuildContext context}) {
    final cubit = context.read<HomeServicePartCubit>();
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        EkChooseCarProblemButton(
          title: cubit.selectPartResponseEntity?.name ?? '-',
          label: 'قطعه',
          onTap: () {},

        ),
        Space.h16,

        if (cubit
                .selectPartResponseEntity
                ?.allowableCostCenterList
                ?.isNotEmpty ??
            false)
          EkDropDown(
            cubit.selectPartResponseEntity?.allowableCostCenterList
                    ?.map((e) => e.name ?? '')
                    .toList() ??
                [],
            borderColor: Theme.of(context).colorScheme.outline,
            postfixIcon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: colorScheme.onSurface,
            ),
            selectedItem: cubit.selectPartCostCenterEntity?.name ?? 'انتخاب',
            label: 'مرکز هزینه *',
            onItemValue: (value) {
              final list =
                  cubit.selectPartResponseEntity?.allowableCostCenterList ?? [];

              cubit.selectPartCostCenterEntity = list.firstWhere(
                (i) => i.name == value,
              );
            },
          ),

        Space.h16,
        if (cubit.selectPartResponseEntity != null)
          EkDropDown(
            cubit.markList.map((e) => e?.mark ?? '').toList(),
            borderColor: Theme
                .of(context)
                .colorScheme
                .outline,
            postfixIcon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: colorScheme.onSurface,
            ),
            selectedItem: cubit.selectPartResponseEntity?.mark ?? 'انتخاب',
            label: 'مارک‌ها *',
            onItemValue: (value) {
              cubit.selectPartResponseEntity?.mark = value;
              cubit.getPartPrice(mark: value);
            },
          ),

        Space.h16,

        Row(
          children: [
            Expanded(
              child: BlocBuilder<HomeServicePartCubit, HomeServicePartState>(
                builder: (context, state) {
                  final cubit = context.read<HomeServicePartCubit>();

                  final isLoading = state.maybeWhen(
                    partPriceLoading: () => true,
                    orElse: () => false,
                  );

                  return TextFormFieldWidget(
                    controller: cubit.priceController,
                    labelText: 'قیمت',
                    hintText: 'قیمت',
                    readOnly: cubit.selectPartResponseEntity?.mark ==
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
