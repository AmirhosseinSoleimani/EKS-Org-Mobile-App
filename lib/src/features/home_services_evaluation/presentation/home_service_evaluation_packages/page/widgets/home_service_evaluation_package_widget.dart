
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_package_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_service_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/cubit/home_service_evaluation_packages_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/cubit/home_service_evaluation_packages_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeServiceEvaluationPackageWidget extends StatelessWidget {
  const HomeServiceEvaluationPackageWidget({
    super.key,
    this.serviceId,
    this.categoryId,
    this.entity,
  });

  final int? categoryId;
  final int? serviceId;
  final InsertHomeServiceServiceItemResponseEntity? entity;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeServiceEvaluationPackagesCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<
        HomeServiceEvaluationPackagesCubit,
        HomeServiceEvaluationPackagesState
    >(
      builder: (context, state) {
        if (state.maybeWhen(
          servicePackageLoading: () => true,
          orElse: () => false,
        )) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: Colors.black),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: CircularProgressIndicator(
                  color: ServiceType.homeService.serviceColor,
                ),
              ),
            ],
          );
        }

        return StreamBuilder<List<InsertHomeServicePackageResponseEntity?>>(
          stream: cubit.homeServicePackageListStream,
          builder: (context, snapshot) {
            final items = snapshot.data ?? [];

            if (items.isEmpty) {
              return const EmptyListWidget();
            }
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final hasParts = item?.partGroups?.isNotEmpty ?? false;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ===================== HEADER =====================
                        buildPackageHeader(hasParts, item, cubit),
                        Space.h8,

                        // ===================== LABOR INFO =====================
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BodyMediumText(
                              text:
                              'دستمزد: ${_formatPrice(item?.laborPrice ?? 0)}',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onPrimaryFixed,
                            ),

                            Row(
                              children: [
                                BodyMediumText(
                                  text: 'به عهده: ',
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onPrimaryFixed,
                                ),
                                Space.w4,
                                StatusLabel(text: item?.laborCostCenterTitle
                                    ?.toString() ?? '',
                                  color: ServiceType.homeService.serviceColor,
                                  variant: StatusLabelVariant
                                      .filledWithoutBorder,
                                  fontSize: 13,
                                )
                              ],
                            ),
                          ],
                        ),

                        Space.h16,

                        // ===================== PARTS =====================
                        if (hasParts) ...[

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (final group in item!.partGroups!) ...[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BodyMediumText(text:
                                    group.partGroupTitle ?? '-',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    Divider(color: Colors.grey, thickness: 1,),


                                    /// ================= PARTS LIST =================
                                    for (int partIndex = 0;
                                    partIndex < (group.parts?.length ?? 0);
                                    partIndex++) ...[

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [

                                          /// ================= MAIN ROW =================
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center,
                                            children: [
                                              Transform.scale(
                                                scale: 1.2,
                                                child: Checkbox(
                                                  activeColor: ServiceType.homeService.serviceColor,

                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1,
                                                  ),

                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(4),
                                                  ),

                                                  fillColor: WidgetStateProperty.resolveWith((states) {
                                                    if (states.contains(WidgetState.selected)) {
                                                      return ServiceType.homeService.serviceColor;
                                                    }
                                                    return Colors.grey.shade200;
                                                  }),

                                                  value: group.parts?[partIndex].isSelected ?? false,

                                                  onChanged: (_) {
                                                    /// 1. فقط toggle state داخلی
                                                    cubit.togglePartCheckBox(
                                                      laborId: item.id ?? 0,
                                                      partGroupId: group.partGroupId ?? 0,
                                                      partIndex: partIndex,
                                                    );

                                                    /// 2. sync کل selection (architecture تو)
                                                    cubit.addSelectedPackagesToHomeServices(
                                                      categoryId: categoryId ??0,
                                                      serviceId: serviceId ??0,
                                                    );
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: BodyMediumText(text:
                                                group.parts?[partIndex]
                                                    .partTitle ?? '-',
                                                ),
                                              ),

                                            ],
                                          ),


                                          /// ================= MARK ROW =================
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8, right: 40),
                                            child: BodyMediumText(text:
                                            'مارک: ${group.parts?[partIndex]
                                                .mark ?? '-'}',
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey,
                                            ),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 8, right: 40),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    BodyMediumText(
                                                      text: 'به عهده: ',
                                                      fontSize: 13,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: colorScheme
                                                          .onPrimaryFixed,
                                                    ),
                                                    Space.w4,
                                                    StatusLabel(text: group
                                                        .parts?[partIndex]
                                                        .partCostCenter?.name ??
                                                        '',
                                                      color: ServiceType
                                                          .homeService
                                                          .serviceColor,
                                                      variant: StatusLabelVariant
                                                          .filledWithoutBorder,
                                                      fontSize: 13,
                                                    )
                                                  ],
                                                ),
                                                BodyMediumText(text:
                                                _formatPrice(
                                                  group.parts?[partIndex]
                                                      .partPrice ?? 0,
                                                ),
                                                  fontWeight: FontWeight.w600,

                                                ),
                                              ],
                                            ),
                                          ),

                                          /// ================= DIVIDER =================
                                          Divider(
                                            thickness: 0.3,
                                            color: Colors.grey.withAlpha(150),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                              ]
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Row buildPackageHeader(bool hasParts,
      InsertHomeServicePackageResponseEntity? item,
      HomeServiceEvaluationPackagesCubit cubit) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (!hasParts)
          Checkbox(
            activeColor:
            ServiceType.homeService.serviceColor,
            value: item?.isSelected ?? false,
            onChanged: (_) {
              cubit.toggleLaborCheckBox(
                laborId: item?.id ?? 0,
              );
              cubit.addSelectedPackagesToHomeServices(
                categoryId: categoryId ?? 0,
                serviceId: serviceId ?? 0,
              );
            },
          ),

        if (!hasParts) const SizedBox(width: 8),

        Expanded(
          child: Text(
            item?.laborTitle ?? '-',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  String _formatPrice(int price) {
    String value = price.toStringAsFixed(0);

    value = value.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => ',',
    );

    return '$value ریال';
  }
}

