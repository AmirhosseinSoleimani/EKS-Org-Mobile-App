import 'dart:convert';
import 'dart:typed_data';
import 'package:eks_sana_plus_org/src/config/themes/app_theme.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_loading/ek_loading.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/cubit/home_service_evaluation_packages_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/cubit/home_service_evaluation_packages_state.dart';
import 'package:eks_sana_plus_org/src/features/insert_home_service/domain/entity/insert_home_service_category_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/insert_home_service/domain/entity/insert_home_service_service_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/font_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_service_evaluation_service_widget.dart';


class HomeServiceEvaluationCategoryWidget extends StatelessWidget {
  const HomeServiceEvaluationCategoryWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeServiceEvaluationPackagesCubit>();
    return StreamBuilder<List<InsertHomeServiceCategoryResponseEntity?>>(
        stream: cubit.homeServiceCategoryListStream,
        builder: (context, snapshot) {
          final items = snapshot.data;
          if(items?.isNotEmpty ?? false) {
            return ValueListenableBuilder<int?>(
              valueListenable: cubit.expandedIdNotifier,
              builder: (context, expandedId, _) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items?.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = items?[index];
                    final isExpanded = cubit.expandedIdNotifier.value == item?.categoryId;
                    return BlocBuilder<HomeServiceEvaluationPackagesCubit, HomeServiceEvaluationPackagesState>(
                      buildWhen: (prev, next) {
                        return next.maybeWhen(
                          servicesSuccess: (id) => id == item?.categoryId,
                          servicesLoading: (id) => id == item?.categoryId,
                          orElse: () => false,
                        );
                      },
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
                          child: ExpansionTile(
                            key: ValueKey(isExpanded ? item?.categoryId : UniqueKey()),
                            initiallyExpanded: isExpanded,
                            onExpansionChanged: (expanded) {
                              if (expanded) {
                                cubit.expandedIdNotifier.value = items?[index]?.categoryId;
                                cubit.fetchHomeServiceServices(id: items?[index]?.categoryId);
                              } else {
                                cubit.expandedIdNotifier.value = null;
                              }
                            },
                            collapsedBackgroundColor: AppTheme.darkThemeBoxBackgroundDark,
                            leading: SizedBox(
                              height: AppSize.s60,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(AppSize.s12)),
                                child: Image.asset(
                                  ImageManager.primaryService,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            trailing: Icon(
                              IconManager.arrowDown,
                              size: AppSize.s20,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            title :Text(
                              items?[index]?.categoryTitle ?? '-',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            children: [
                              state.maybeWhen(
                                  servicesLoading: (id) => const Padding(
                                    padding: EdgeInsets.symmetric(vertical: AppPadding.p16),
                                    child: Center(
                                      child: SizedBox(
                                        width: AppSize.s48,
                                        height: AppSize.s48,
                                        child: EkLoading(),
                                      ),
                                    ),
                                  ),
                                  servicesSuccess: (id) => (items?[index]?.homeServices?.isNotEmpty ?? false) ? ListView.builder(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: items?[index]?.homeServices?.length ?? 0,
                                    itemBuilder: (BuildContext context, int homeServiceIndex) {
                                      return HomeServiceEvaluationServiceWidget(
                                        entity: items?[index]?.homeServices?[homeServiceIndex] ?? const InsertHomeServiceServiceItemResponseEntity(),
                                      );
                                    },
                                  ) : const Padding(
                                    padding: EdgeInsets.symmetric(vertical: AppPadding.p16),
                                    child: Text(
                                      'موردی جهت نمایش وجود ندارد',
                                      style: TextStyle(
                                          fontSize: AppSize.s16,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: FontConstants.fontFamilyPersian
                                      ),
                                    ),
                                  ),
                                  orElse: () => const Padding(
                                    padding: EdgeInsets.symmetric(vertical: AppPadding.p16),
                                    child: Text(
                                      'موردی جهت نمایش وجود ندارد',
                                      style: TextStyle(
                                          fontSize: AppSize.s16,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: FontConstants.fontFamilyPersian
                                      ),
                                    ),
                                  )
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
          } else {
            return const Center(
              child: Text(
                'موردی جهت نمایش وجود ندارد',
                style: TextStyle(
                    fontSize: AppSize.s16,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontConstants.fontFamilyPersian
                ),
              ),
            );
          }
        }
    );
  }

  Widget homeServicesImage({required String base64StringWithPrefix }) {
    String base64String = base64StringWithPrefix
        .split(',')
        .last;
    Uint8List bytes = base64Decode(base64String);
    return Image.memory(
      bytes,
      fit: BoxFit.cover,
    );
  }
}
