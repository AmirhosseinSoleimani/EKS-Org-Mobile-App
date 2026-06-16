import 'dart:convert';
import 'dart:typed_data';

import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/common/utils/extensions/string_ext.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_service_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/cubit/home_service_evaluation_packages_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/font_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_service_evaluation_package_widget.dart';

class HomeServiceEvaluationServiceWidget extends StatelessWidget {
  const HomeServiceEvaluationServiceWidget({super.key, this.entity});

  final InsertHomeServiceServiceItemResponseEntity? entity;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeServiceEvaluationPackagesCubit>();
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: AppSize.s1, color: colorScheme.onPrimary),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s12)),
          color: colorScheme.onPrimary,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p2),
          child: Column(
            children: [
              ListTile(
                leading: SizedBox(
                  width: AppSize.s60,
                  child: Transform.scale(
                    scale: 1.4,
                    child: Checkbox(
                      activeColor: ServiceType.homeService.serviceColor,
                      checkColor: Colors.white,
                      onChanged: (value) {
                        cubit.toggleServiceCheckBox(
                          serviceId: entity?.id ?? 0,
                          categoryId: entity?.categoryId ?? 0,
                        );
                        if (value ?? false) {
                          _selectHomeServicePackage(
                            context: context,
                            entity: entity,
                          );
                        }
                      },
                      value: entity?.isSelected ?? false,
                    ),
                  ),
                ),
                title: Text(
                  entity?.title ?? '-',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: AppSize.s14,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: AppSize.s60,
                      width: AppSize.s60,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(AppSize.s4),
                        ),
                        child: (entity?.imageGuid != null)
                            ? homeServicesImage(
                                base64StringWithPrefix: entity?.imageGuid ?? '',
                              )
                            : Icon(
                                IconManager.errorImage,
                                size: AppSize.s42,
                                color: colorScheme.inverseSurface,
                              ),
                      ),
                    ),
                    Space.w4,
                    if (entity?.hasSubscription == true)
                      SizedBox(
                        child: Image.asset(
                          ImageManager.activeIcon,
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
              ),
              if (entity?.labors?.isNotEmpty ?? false)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: Column(
                    children: [
                      Space.h16,
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: entity?.labors?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppPadding.p4,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(AppSize.s8),
                                ),
                                border: Border.all(
                                  width: AppSize.s1,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSecondary,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(AppPadding.p8),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          IconManager.carRepair,
                                          color: ServiceType
                                              .homeService
                                              .serviceColor,
                                          size: AppSize.s24,
                                        ),
                                        Space.w4,
                                        Expanded(
                                          child: Text(
                                            '${entity?.labors?[index].laborDesc}'
                                                .splitPriceByComma(),
                                            style: const TextStyle(
                                              fontFamily: FontConstants
                                                  .fontFamilyPersian,
                                              fontSize: AppSize.s16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Space.w4,
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                backgroundColor: Colors.white,
                                                contentPadding: EdgeInsets.zero,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        AppSize.s16,
                                                      ),
                                                ),
                                                actions: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal:
                                                              AppPadding.p12,
                                                        ),
                                                    child: InkwellButtonWidget(
                                                      onTap: () async {
                                                        cubit.removedLaborFromService(
                                                          categoryId:
                                                              entity
                                                                  ?.categoryId ??
                                                              0,
                                                          serviceId:
                                                              entity
                                                                  ?.labors?[index]
                                                                  .serviceId ??
                                                              0,
                                                          laborId:
                                                              entity
                                                                  ?.labors?[index]
                                                                  .laborId ??
                                                              0,
                                                        );
                                                        Navigator.of(
                                                          context,
                                                        ).pop();
                                                      },
                                                      backgroundColor:
                                                          colorScheme.surface,
                                                      title: 'حذف',
                                                    ),
                                                  ),
                                                ],
                                                content: SizedBox(
                                                  width: double.infinity,
                                                  child: SingleChildScrollView(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            AppPadding.p12,
                                                          ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                  AppPadding.p8,
                                                                ),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                    context,
                                                                  );
                                                                },
                                                                child: const Icon(
                                                                  IconManager
                                                                      .close,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Space.h16,
                                                          Column(
                                                            children: [
                                                              Text(
                                                                'آیا از حذف این دستمزد و قطعه اطمینان دارید؟',
                                                                style: Theme.of(context)
                                                                    .textTheme
                                                                    .bodyMedium
                                                                    ?.copyWith(
                                                                      fontSize:
                                                                          AppSize
                                                                              .s16,
                                                                    ),
                                                              ),
                                                              if (entity
                                                                      ?.labors?[index]
                                                                      .isMandatory ??
                                                                  false) ...[
                                                                Space.h8,
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets.all(
                                                                        AppPadding
                                                                            .p8,
                                                                      ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Icon(
                                                                        IconManager
                                                                            .warning,
                                                                        size: AppSize
                                                                            .s24,
                                                                        color: colorScheme
                                                                            .error,
                                                                      ),
                                                                      Space.w8,
                                                                      Expanded(
                                                                        child: Text(
                                                                          'این دستمزد و قطعه برای سرویس انتخاب شده اجباری می باشد در صورت حذف امکان ثبت درخواست وجود نخواهد داشت',
                                                                          style:
                                                                              Theme.of(
                                                                                context,
                                                                              ).textTheme.bodyMedium?.copyWith(
                                                                                fontSize: AppSize.s14,
                                                                                color: colorScheme.error,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ],
                                                          ),
                                                          Space.h24,
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                width: AppSize.s1,
                                                color: colorScheme.onPrimary,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                AppPadding.p2,
                                              ),
                                              child: Icon(
                                                IconManager.delete,
                                                color: colorScheme.error,
                                                size: AppSize.s20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Space.h8,
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          IconManager.localOffer,
                                          color: ServiceType
                                              .homeService
                                              .serviceColor,
                                          size: AppSize.s24,
                                        ),
                                        Space.w4,
                                        Expanded(
                                          child: Text(
                                            '${entity?.labors?[index].laborPrice} ریال'
                                                .splitPriceByComma(),
                                            style: const TextStyle(
                                              fontFamily: FontConstants
                                                  .fontFamilyPersian,
                                              fontSize: AppSize.s16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${entity?.labors?[index].costCenter?.name}'
                                            .splitPriceByComma(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontSize: AppSize.s14,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.onPrimary,
                                            ),
                                      ),
                                    ),
                                    Space.h8,
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          entity
                                              ?.labors?[index]
                                              .parts
                                              ?.length ??
                                          0,
                                      itemBuilder: (BuildContext context, int partIndex) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: AppPadding.p4,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: colorScheme.onPrimary,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                    Radius.circular(AppSize.s8),
                                                  ),
                                              border: Border.all(
                                                width: AppSize.s1,
                                                color: colorScheme.onPrimary,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                AppPadding.p8,
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Icon(
                                                        IconManager
                                                            .settingSuggest,
                                                        color: ServiceType
                                                            .homeService
                                                            .serviceColor,
                                                        size: AppSize.s18,
                                                      ),
                                                      Space.w4,
                                                      Expanded(
                                                        child: Text(
                                                          '${entity?.labors?[index].parts?[partIndex].partTitle} ریال'
                                                              .splitPriceByComma(),
                                                          style: const TextStyle(
                                                            fontFamily:
                                                                FontConstants
                                                                    .fontFamilyPersian,
                                                            fontSize:
                                                                AppSize.s14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Space.h8,
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Icon(
                                                        IconManager.localOffer,
                                                        color: ServiceType
                                                            .homeService
                                                            .serviceColor,
                                                        size: AppSize.s18,
                                                      ),
                                                      Space.w4,
                                                      Expanded(
                                                        child: RichText(
                                                          text: TextSpan(
                                                            text: 'قیمت : ',
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .titleMedium
                                                                ?.copyWith(
                                                                  fontSize:
                                                                      AppSize
                                                                          .s14,
                                                                ),
                                                            children: [
                                                              TextSpan(
                                                                text: '${entity?.labors?[index].parts?[partIndex].partPrice} ریال'
                                                                    .splitPriceByComma(),
                                                                style: const TextStyle(
                                                                  fontFamily:
                                                                      FontConstants
                                                                          .fontFamilyPersian,
                                                                  fontSize:
                                                                      AppSize
                                                                          .s14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  if (entity
                                                          ?.labors?[index]
                                                          .parts?[partIndex]
                                                          .hasReusable ??
                                                      false) ...[
                                                    Space.h8,
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          IconManager
                                                              .localOffer,
                                                          color: ServiceType
                                                              .homeService
                                                              .serviceColor,
                                                          size: AppSize.s18,
                                                        ),
                                                        Space.w4,
                                                        Expanded(
                                                          child: RichText(
                                                            text: TextSpan(
                                                              text:
                                                                  'قیمت (با احتساب داغی) : ',
                                                              style: const TextStyle(
                                                                fontFamily:
                                                                    FontConstants
                                                                        .fontFamilyPersian,
                                                                fontSize:
                                                                    AppSize.s14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text: '${(entity?.labors?[index].parts?[partIndex].partPrice ?? 0) - (entity?.labors?[index].parts?[partIndex].reusablePrice ?? 0)} ریال'
                                                                      .splitPriceByComma(),
                                                                  style: const TextStyle(
                                                                    fontFamily:
                                                                        FontConstants
                                                                            .fontFamilyPersian,
                                                                    fontSize:
                                                                        AppSize
                                                                            .s14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      '${entity?.labors?[index].parts?[partIndex].partCostCenterTitle}'
                                                          .splitPriceByComma(),
                                                      style: TextStyle(
                                                        fontFamily: FontConstants
                                                            .fontFamilyPersian,
                                                        fontSize: AppSize.s14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: ServiceType
                                                            .homeService
                                                            .serviceColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Space.h16,
                      InkWell(
                        onTap: () {
                          _selectHomeServicePackage(
                            context: context,
                            entity: entity,
                          );
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: AppSize.s1,
                              color: ServiceType.homeService.serviceColor,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(AppSize.s8),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(AppPadding.p8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  IconManager.edit,
                                  size: AppSize.s24,
                                  color: ServiceType.homeService.serviceColor,
                                ),
                                Space.w4,
                                Text(
                                  'ویرایش',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                        fontSize: AppSize.s14,
                                        color: ServiceType
                                            .homeService
                                            .serviceColor,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget homeServicesImage({required String base64StringWithPrefix}) {
    String base64String = base64StringWithPrefix.split(',').last;
    Uint8List bytes = base64Decode(base64String);
    return Image.memory(bytes, fit: BoxFit.cover);
  }

  void _selectHomeServicePackage({
    required BuildContext context,
    InsertHomeServiceServiceItemResponseEntity? entity,
  }) {
    final cubit = context.read<HomeServiceEvaluationPackagesCubit>();
    cubit.fetchHomeServicePackage(entity: entity);
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return BlocProvider.value(
            value: cubit,
            child: Animate(
              effects: [
                SlideEffect(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                  curve: Curves.easeInOut,
                  duration: 500.ms,
                ),
                FadeEffect(curve: Curves.easeIn, duration: 500.ms),
              ],
              child: HomeServiceEvaluationPackageWidget(
                serviceId: entity?.id,
                categoryId: entity?.categoryId,
                entity: entity,
              ),
            ),
          );
        },
        transitionDuration: 500.ms,
      ),
    );
  }
}
