import 'package:emdadgar_saipa/generated/l10n.dart';
import 'package:eks_sana_plus_org/src/common/utils/extensions/string_ext.dart';
import 'package:eks_sana_plus_org/src/config/themes/app_theme.dart';
import 'package:eks_sana_plus_org/src/core/presentation/pages/base_stateless_page.dart';
import 'package:eks_sana_plus_org/src/core/uikit/dialog/dialog_widgets.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_button/ek_button.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_loading/ek_loading.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/cubit/home_service_evaluation_packages_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/cubit/home_service_evaluation_packages_state.dart';
import 'package:eks_sana_plus_org/src/features/insert_home_service/domain/entity/insert_home_service_package_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/insert_home_service/domain/entity/insert_home_service_service_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/font_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeServiceEvaluationPackageWidget extends BaseStatelessPage {
  const HomeServiceEvaluationPackageWidget({super.key,this.serviceId, this.categoryId, this.entity,});
  final int? categoryId;
  final int? serviceId;
  final InsertHomeServiceServiceItemResponseEntity? entity;

  @override
  bool showAppBarDetails(BuildContext context) {
    return true;
  }

  @override
  Widget body(BuildContext context) {
    final cubit = context.read<HomeServiceEvaluationPackagesCubit>();
    return  Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: BlocConsumer<HomeServiceEvaluationPackagesCubit, HomeServiceEvaluationPackagesState>(
        listener: (context, state) {
          state.whenOrNull(
              error: (dialogDataModel) => showDialog(
                context: context,
                builder: (ctx) => MessageDialogWidget(
                  dismissible: true,
                  color: AppTheme.blue,
                  title: dialogDataModel.title,
                  body: dialogDataModel.description,
                  positiveTxt: S.of(context).ok,
                  positiveFunc: () => Navigator.of(ctx).pop(),
                ),
              )
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            servicePackageLoading: () => Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      IconManager.close,
                      size: AppSize.s24,
                      color: AppTheme.colorBlack,
                    ),
                  ),
                ),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EkLoading(),
                    ],
                  ),
                ),
              ],
            ),
            orElse: () => RefreshIndicator(
              color: AppTheme.blue,
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
                      icon: const Icon(
                        IconManager.close,
                        size: AppSize.s24,
                        color: AppTheme.colorBlack,
                      ),
                    ),
                  ),
                  Space.h8,
                  Expanded(
                    child: StreamBuilder<List<InsertHomeServicePackageResponseEntity?>>(
                      stream: cubit.homeServicePackageListStream,
                      builder: (context, snapshot) {
                        final items = snapshot.data;
                        if(items?.isNotEmpty ?? false) {
                          return ValueListenableBuilder<int?>(
                            valueListenable: cubit.packageExpandedIdNotifier,
                            builder: (context, packageExpandedId, _) {
                              return ListView.builder(
                                itemCount: items!.length,
                                itemBuilder: (context, index) {
                                  final item = items[index];
                                  final isExpandable = item?.partGroups?.isNotEmpty ?? false;
                                  final isExpanded = packageExpandedId == item?.id;
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: AppSize.s12),
                                    child: Card(
                                      color: AppTheme.darkThemeBoxBackgroundLight,
                                      elevation: AppSize.s4,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(AppSize.s12),
                                      ),
                                      child: ExpansionTile(
                                        key: ValueKey(isExpanded ? item?.id : UniqueKey()),
                                        initiallyExpanded: isExpanded,
                                        onExpansionChanged: (expanded) {
                                          cubit.packageExpandedIdNotifier.value = expanded ? item?.id : null;
                                        },
                                        tilePadding: const EdgeInsets.all(AppPadding.p16),
                                        iconColor: AppTheme.colorBlack,
                                        title: isExpandable ? Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(IconManager.carRepair, color: AppTheme.blue, size: AppSize.s28),
                                                Space.w4,
                                                Expanded(
                                                  child: Text(
                                                    '${item?.laborTitle}',
                                                    style: const TextStyle(
                                                        fontSize: AppSize.s16,
                                                        fontWeight: FontWeight.w400,
                                                        color: AppTheme.colorBlack,
                                                        fontFamily: FontConstants.fontFamilyPersian
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Space.h4,
                                            Row(
                                              children: [
                                                const Icon(IconManager.localOffer, color: AppTheme.blue, size: AppSize.s28),
                                                Space.w4,
                                                Expanded(
                                                  child: RichText(
                                                    text: TextSpan(
                                                      text: 'دستمزد: ',
                                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: AppSize.s14),
                                                      children: [
                                                        TextSpan(
                                                          text: '${item?.laborPrice} ریال'.splitPriceByComma(),
                                                          style: const TextStyle(
                                                              fontSize: AppSize.s14,
                                                              fontWeight: FontWeight.w400,
                                                              color: AppTheme.colorBlack,
                                                              fontFamily: FontConstants.fontFamilyPersian
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Space.h4,
                                            Row(
                                              children: [
                                                const Icon(IconManager.payment, color: AppTheme.blue, size: AppSize.s28),
                                                Space.w4,
                                                Expanded(
                                                  child: RichText(
                                                    text: TextSpan(
                                                      text: 'به عهده: ',
                                                      style: const TextStyle(
                                                          fontSize: AppSize.s14,
                                                          fontWeight: FontWeight.w400,
                                                          color: AppTheme.colorBlack,
                                                          fontFamily: FontConstants.fontFamilyPersian
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text: '${item?.laborCostCenterTitle}'.splitPriceByComma(),
                                                          style: const TextStyle(
                                                              fontSize: AppSize.s14,
                                                              fontWeight: FontWeight.w400,
                                                              color: AppTheme.colorBlack,
                                                              fontFamily: FontConstants.fontFamilyPersian
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ) : Column(
                                          children: [
                                            Row(
                                              children: [
                                                Checkbox(
                                                  activeColor: AppTheme.blue,
                                                  checkColor: Theme.of(context).colorScheme.surface,
                                                  value: item?.isSelected ?? false,
                                                  onChanged: (_) {
                                                    cubit.toggleLaborCheckBox(laborId: item?.id ?? 0);
                                                  },
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '${item?.laborTitle}',
                                                    maxLines: 3,
                                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: AppSize.s14),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Space.h4,
                                            Row(
                                              children: [
                                                const Icon(IconManager.localOffer, color: AppTheme.blue, size: AppSize.s28),
                                                Space.w4,
                                                Expanded(
                                                  child: RichText(
                                                    text: TextSpan(
                                                      text: 'دستمزد: ',
                                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: AppSize.s14),
                                                      children: [
                                                        TextSpan(
                                                          text: '${item?.laborPrice} ریال'.splitPriceByComma(),
                                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: AppSize.s14),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Space.h4,
                                            Row(
                                              children: [
                                                const Icon(IconManager.payment, color: AppTheme.blue, size: AppSize.s28),
                                                Space.w4,
                                                Expanded(
                                                  child: RichText(
                                                    text: TextSpan(
                                                      text: 'به عهده: ',
                                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: AppSize.s14),
                                                      children: [
                                                        TextSpan(
                                                          text: '${item?.laborCostCenterTitle}'.splitPriceByComma(),
                                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: AppSize.s14),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        children: isExpandable ? [
                                          Padding(
                                            padding: const EdgeInsets.all(AppPadding.p16),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemCount: item?.partGroups?.length ?? 0,
                                              itemBuilder: (BuildContext context, int index) {
                                                return Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p4),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context).colorScheme.surface,
                                                        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
                                                        border: Border.all(
                                                            width: AppSize.s1,
                                                            color: Theme.of(context).colorScheme.onSecondary
                                                        )
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(AppPadding.p8),
                                                      child: Column(
                                                        children: [
                                                          Align(
                                                            alignment: Alignment.centerRight,
                                                            child: Text(
                                                              item?.partGroups?[index].partGroupTitle ?? '-',
                                                              style: const TextStyle(
                                                                  fontSize: AppSize.s16,
                                                                  fontWeight: FontWeight.w500,
                                                                  color: AppTheme.colorBlack,
                                                                  fontFamily: FontConstants.fontFamilyPersian
                                                              ),
                                                            ),
                                                          ),
                                                          Space.h8,
                                                          ListView.builder(
                                                            shrinkWrap: true,
                                                            physics: const NeverScrollableScrollPhysics(),
                                                            itemCount: item?.partGroups?[index].parts?.length ?? 0,
                                                            itemBuilder: (BuildContext context, int partIndex) {
                                                              final part = item?.partGroups?[index].parts?[partIndex];
                                                              return Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Checkbox(
                                                                        activeColor: AppTheme.blue,
                                                                        checkColor: AppTheme.whiteColor,
                                                                        value: part?.isSelected ?? false,
                                                                        onChanged: (_) {
                                                                          cubit.togglePartCheckBox(
                                                                            laborId: item?.laborId ?? 0,
                                                                            partGroupId: item?.partGroups?[index].partGroupId ?? 0,
                                                                            partIndex: partIndex,
                                                                          );
                                                                        },
                                                                      ),
                                                                      Expanded(
                                                                        child: Text(
                                                                          '${part?.partTitle}',
                                                                          maxLines: 3,
                                                                          style: const TextStyle(
                                                                              fontSize: AppSize.s14,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: AppTheme.colorBlack,
                                                                              fontFamily: FontConstants.fontFamilyPersian
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Space.h8,
                                                                  Row(
                                                                    children: [
                                                                      const Icon(IconManager.localOffer, color: AppTheme.blue, size: AppSize.s20),
                                                                      Space.w4,
                                                                      Expanded(
                                                                        child: RichText(
                                                                          text: TextSpan(
                                                                            text: 'قیمت: ',
                                                                            style: const TextStyle(
                                                                                fontSize: AppSize.s14,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: AppTheme.colorBlack,
                                                                                fontFamily: FontConstants.fontFamilyPersian
                                                                            ),
                                                                            children: [
                                                                              TextSpan(
                                                                                text: '${part?.partPrice} ریال'.splitPriceByComma(),
                                                                                style: const TextStyle(
                                                                                    fontSize: AppSize.s14,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    color: AppTheme.colorBlack,
                                                                                    fontFamily: FontConstants.fontFamilyPersian
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  if(part?.hasReusable ?? false) ...[
                                                                    Space.h8,
                                                                    Row(
                                                                      children: [
                                                                        const Icon(IconManager.localOffer, color: AppTheme.blue, size: AppSize.s20),
                                                                        Space.w4,
                                                                        Expanded(
                                                                          child: RichText(
                                                                            text: TextSpan(
                                                                              text: 'قیمت (با احتساب داغی) : ',
                                                                              style: const TextStyle(
                                                                                  fontSize: AppSize.s14,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  color: AppTheme.colorBlack,
                                                                                  fontFamily: FontConstants.fontFamilyPersian
                                                                              ),
                                                                              children: [
                                                                                TextSpan(
                                                                                  text: '${(part?.partPrice ?? 0) - (part?.reusablePrice ?? 0)} ریال'.splitPriceByComma(),
                                                                                  style: const TextStyle(
                                                                                      fontSize: AppSize.s14,
                                                                                      fontWeight: FontWeight.w500,
                                                                                      color: AppTheme.colorBlack,
                                                                                      fontFamily: FontConstants.fontFamilyPersian
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                  Space.h8,
                                                                  Row(
                                                                    children: [
                                                                      const Icon(IconManager.payment, color: AppTheme.blue, size: AppSize.s20),
                                                                      Space.w4,
                                                                      Expanded(
                                                                        child: RichText(
                                                                          text: TextSpan(
                                                                            text: 'به عهده: ',
                                                                            style: const TextStyle(
                                                                                fontSize: AppSize.s14,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: AppTheme.colorBlack,
                                                                                fontFamily: FontConstants.fontFamilyPersian
                                                                            ),
                                                                            children: [
                                                                              TextSpan(
                                                                                text: '${part?.partCostCenterTitle}'.splitPriceByComma(),
                                                                                style: const TextStyle(
                                                                                    fontSize: AppSize.s14,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    color: AppTheme.colorBlack,
                                                                                    fontFamily: FontConstants.fontFamilyPersian
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Space.h8,
                                                                  if(partIndex != ((item?.partGroups?[index].parts?.length ?? 0) - 1))const Divider(
                                                                    thickness: AppSize.s2,
                                                                    color: AppTheme.darkThemeBoxBackgroundDark,
                                                                  )
                                                                ],
                                                              );
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },

                                            ),
                                          ),
                                        ] : [],
                                      ),
                                    ),
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
                        }},
                    ),
                  ),
                  Space.h16,
                  EkButton(
                    backgroundColor: AppTheme.blue,
                    onTap: () async{
                      cubit.addSelectedPackagesToHomeServices(
                        categoryId: categoryId ?? 0,
                        serviceId: serviceId ?? 0,
                      );
                      Navigator.of(context).pop();
                    },
                    title: 'افزودن',
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
