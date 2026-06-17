import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_package_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_service_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/cubit/home_service_evaluation_packages_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/cubit/home_service_evaluation_packages_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
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

    return Padding(
      padding: const EdgeInsets.all(16),
      child: BlocConsumer<HomeServiceEvaluationPackagesCubit, HomeServiceEvaluationPackagesState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (message) {
              BottomSheetMessage.showError(
                isDismissible: true,
                context: context,
                data: BottomSheetMessageModel(title: '', message: message),
              );
            },
            notice: (message) {
              BottomSheetMessage.showNotice(
                isDismissible: true,
                context: context,
                data: BottomSheetMessageModel(title: '', message: message),
                buttonColor: ServiceType.homeService.serviceColor,
              );
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            servicePackageLoading: () => Material(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(
                        Icons.close,
                        size: 24,
                        color: Colors.black,
                      ),
                    ),
                  ),
                   Expanded(
                    child: Center(child: CircularProgressIndicator(color: ServiceType.homeService.serviceColor)),
                  ),
                ],
              ),
            ),
            orElse: () => RefreshIndicator(
              color: ServiceType.homeService.serviceColor,
              onRefresh: () => cubit.fetchHomeServicePackage(entity: entity),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        cubit.closePackageService(
                          categoryId: categoryId ?? 0,
                          serviceId: serviceId ?? 0,
                        );
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close, color: Colors.black),
                    ),
                  ),
                  Space.h8,
                  Expanded(
                    child: StreamBuilder<List<InsertHomeServicePackageResponseEntity?>>(
                      stream: cubit.homeServicePackageListStream,
                      builder: (context, snapshot) {
                        final items = snapshot.data;

                        if (items?.isNotEmpty ?? false) {
                          return ValueListenableBuilder<int?>(
                            valueListenable: cubit.packageExpandedIdNotifier,
                            builder: (context, packageExpandedId, _) {
                              return ListView.builder(
                                itemCount: items!.length,
                                itemBuilder: (context, index) {
                                  final item = items[index];
                                  final isExpandable =
                                      item?.partGroups?.isNotEmpty ?? false;
                                  final isExpanded =
                                      packageExpandedId == item?.id;

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Card(
                                      color: colorScheme.surface,
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ExpansionTile(
                                        key: ValueKey(
                                          isExpanded ? item?.id : UniqueKey(),
                                        ),
                                        initiallyExpanded: isExpanded,
                                        onExpansionChanged: (expanded) {
                                          cubit
                                              .packageExpandedIdNotifier
                                              .value = expanded
                                              ? item?.id
                                              : null;
                                        },
                                        tilePadding: const EdgeInsets.all(16),
                                        iconColor: Colors.black,

                                        // ================= TITLE =================
                                        title: isExpandable
                                            ? Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.car_repair,
                                                        color: ServiceType
                                                            .homeService
                                                            .serviceColor,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Expanded(
                                                        child: Text(
                                                          '${item?.laborTitle}',
                                                          style:
                                                              const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : Row(
                                                children: [
                                                  Checkbox(
                                                    activeColor: ServiceType
                                                        .homeService
                                                        .serviceColor,
                                                    value:
                                                        item?.isSelected ??
                                                        false,
                                                    onChanged: (_) {
                                                      cubit.toggleLaborCheckBox(
                                                        laborId: item?.id ?? 0,
                                                      );
                                                    },
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      '${item?.laborTitle}',
                                                    ),
                                                  ),
                                                ],
                                              ),

                                        // ================= CHILDREN =================
                                        children: isExpandable
                                            ? [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                    16,
                                                  ),
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount:
                                                        item
                                                            ?.partGroups
                                                            ?.length ??
                                                        0,
                                                    itemBuilder: (context, index) {
                                                      final group = item
                                                          ?.partGroups?[index];

                                                      return Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                            color: colorScheme
                                                                .outline,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                8,
                                                              ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                8,
                                                              ),
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                group?.partGroupTitle ??
                                                                    '-',
                                                                style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ]
                                            : [],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        }

                        return const Center(
                          child: Text('موردی جهت نمایش وجود ندارد'),
                        );
                      },
                    ),
                  ),
                  Space.h16,

                  /// BUTTON
                  InkwellButtonWidget(
                    backgroundColor: ServiceType.homeService.serviceColor,
                    onTap: () async {
                      cubit.addSelectedPackagesToHomeServices(
                        categoryId: categoryId ?? 0,
                        serviceId: serviceId ?? 0,
                      );
                      Navigator.of(context).pop();
                    },
                    title: 'افزودن',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
