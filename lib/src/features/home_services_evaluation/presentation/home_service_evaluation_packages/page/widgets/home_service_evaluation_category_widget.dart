import 'dart:convert';
import 'dart:typed_data';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_category_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/cubit/home_service_evaluation_packages_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/cubit/home_service_evaluation_packages_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/font_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_service_evaluation_service_widget.dart';

class HomeServiceEvaluationCategoryWidget extends StatelessWidget {
  const HomeServiceEvaluationCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeServiceEvaluationPackagesCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    return StreamBuilder<List<InsertHomeServiceCategoryResponseEntity?>>(
      stream: cubit.homeServiceCategoryListStream,
      builder: (context, snapshot) {
        final items = snapshot.data;

        if (items?.isNotEmpty ?? false) {
          return ValueListenableBuilder<int?>(
            valueListenable: cubit.expandedIdNotifier,
            builder: (context, expandedId, _) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items!.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final isExpanded =
                      expandedId == item?.categoryId;

                  return BlocBuilder<
                      HomeServiceEvaluationPackagesCubit,
                      HomeServiceEvaluationPackagesState>(
                    buildWhen: (prev, next) {
                      return next.maybeWhen(
                        servicesSuccess: (id) =>
                        id == item?.categoryId,
                        servicesLoading: (id) =>
                        id == item?.categoryId,
                        orElse: () => false,
                      );
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ExpansionTile(
                          key: ValueKey(
                            isExpanded ? item?.categoryId : UniqueKey(),
                          ),

                          initiallyExpanded: isExpanded,

                          onExpansionChanged: (expanded) {
                            if (expanded) {
                              cubit.expandedIdNotifier.value =
                                  item?.categoryId;

                              cubit.fetchHomeServiceServices(
                                id: item?.categoryId,
                              );
                            } else {
                              cubit.expandedIdNotifier.value = null;
                            }
                          },

                          // ================= COLORS FIX =================
                          collapsedBackgroundColor:
                          colorScheme.surfaceContainerHighest,
                          backgroundColor:
                          colorScheme.surfaceContainerHighest,

                          // ================= IMAGE =================
                          leading: SizedBox(
                            height: 60,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                ImageManager.primaryService,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          // ================= ICON =================
                          trailing: Icon(
                            IconManager.arrowDown,
                            size: 20,
                            color: colorScheme.onSurface,
                          ),

                          // ================= TITLE =================
                          title: Text(
                            item?.categoryTitle ?? '-',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),

                          // ================= CHILDREN =================
                          children: [
                            state.maybeWhen(
                              servicesLoading: (_) =>
                               Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: CircularProgressIndicator(color: ServiceType.homeService.serviceColor),
                                ),
                              ),

                              servicesSuccess: (_) =>
                              (item?.homeServices?.isNotEmpty ?? false)
                                  ? ListView.builder(
                                shrinkWrap: true,
                                physics:
                                const BouncingScrollPhysics(),
                                itemCount:
                                item!.homeServices!.length,
                                itemBuilder:
                                    (context, homeServiceIndex) {
                                  return HomeServiceEvaluationServiceWidget(
                                    entity: item.homeServices![
                                    homeServiceIndex],
                                  );
                                },
                              )
                                  : Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                    vertical: 16),
                                child: Text(
                                  'موردی جهت نمایش وجود ندارد',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium,
                                ),
                              ),

                              orElse: () => Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  'موردی جهت نمایش وجود ندارد',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        }

        return Center(
          child: Text(
            'موردی جهت نمایش وجود ندارد',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      },
    );
  }

  Widget homeServicesImage({
    required String base64StringWithPrefix,
  }) {
    final base64String = base64StringWithPrefix.split(',').last;
    final bytes = base64Decode(base64String);

    return Image.memory(
      bytes,
      fit: BoxFit.cover,
    );
  }
}