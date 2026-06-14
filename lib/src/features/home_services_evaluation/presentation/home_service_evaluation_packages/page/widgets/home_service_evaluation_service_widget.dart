import 'dart:convert';
import 'dart:typed_data';
import 'package:eks_sana_plus_org/src/common/utils/extensions/string_ext.dart';
import 'package:eks_sana_plus_org/src/config/themes/app_theme.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_button/ek_button.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/cubit/home_service_evaluation_packages_cubit.dart';
import 'package:eks_sana_plus_org/src/features/insert_home_service/domain/entity/insert_home_service_service_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/font_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_service_evaluation_package_widget.dart';


class HomeServiceEvaluationServiceWidget extends StatelessWidget {
  const HomeServiceEvaluationServiceWidget({super.key, this.entity,});
  final InsertHomeServiceServiceItemResponseEntity? entity;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeServiceEvaluationPackagesCubit>();
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                width: AppSize.s1,
                color: AppTheme.darkThemeBoxBackgroundLight
            ),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s12)),
            color: AppTheme.darkThemeBoxBackgroundLight
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
                      activeColor: AppTheme.blue,
                      checkColor: AppTheme.darkThemeWhite,
                      onChanged: (value) {
                        cubit.toggleServiceCheckBox(serviceId: entity?.id ?? 0, categoryId: entity?.categoryId ?? 0);
                        if(value ?? false) {
                          _selectHomeServicePackage(context: context, entity: entity);
                        }
                      },
                      value: entity?.isSelected ?? false,
                    ),
                  ),
                ),
                title: Text(
                  entity?.title ?? '-',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: AppSize.s14),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: AppSize.s60,
                      width: AppSize.s60,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s4)),
                          child: (entity?.imageGuid != null)
                              ? homeServicesImage(base64StringWithPrefix: entity?.imageGuid ?? '')
                              : const Icon(
                            IconManager.errorImage,
                            size: AppSize.s42,
                            color: AppTheme.colorHoloGreyPrimary,
                          )),
                    ),
                    Space.w4,
                    if(entity?.hasSubscription==true)SizedBox(child: Image.asset(ImageManager.activeIcon,fit: BoxFit.cover)),
                  ],
                ),
              ),
              if(entity?.labors?.isNotEmpty ?? false)
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
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Icon(IconManager.carRepair, color: AppTheme.blue, size: AppSize.s24),
                                        Space.w4,
                                        Expanded(
                                          child: Text(
                                            '${entity?.labors?[index].laborDesc}'.splitPriceByComma(),
                                            style: const TextStyle(
                                                fontFamily: FontConstants.fontFamilyPersian,
                                                fontSize: AppSize.s16,
                                                fontWeight: FontWeight.w500,
                                                color: AppTheme.colorBlack
                                            ),
                                          ),
                                        ),
                                        Space.w4,
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                backgroundColor: AppTheme.whiteColor,
                                                contentPadding: EdgeInsets.zero,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(AppSize.s16),
                                                ),
                                                actions: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                                                    child: EkButton(
                                                      onTap: () async{
                                                        cubit.removedLaborFromService(
                                                          categoryId: entity?.categoryId ?? 0,
                                                          serviceId: entity?.labors?[index].serviceId ?? 0,
                                                          laborId: entity?.labors?[index].laborId ?? 0,
                                                        );
                                                        Navigator.of(context).pop();
                                                      },
                                                      backgroundColor: AppTheme.redButton,
                                                      title: 'حذف',
                                                    ),
                                                  ),
                                                ],
                                                content: SizedBox(
                                                  width: double.infinity,
                                                  child: SingleChildScrollView(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(AppPadding.p12),
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(AppPadding.p8),
                                                            child: Align(
                                                              alignment: Alignment.topLeft,
                                                              child: GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pop(context);
                                                                },
                                                                child: const Icon(
                                                                  IconManager.close,
                                                                  color: AppTheme.colorBlack,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Space.h16,
                                                          Column(
                                                            children: [
                                                              Text(
                                                                'آیا از حذف این دستمزد و قطعه اطمینان دارید؟',
                                                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                                    fontSize: AppSize.s16
                                                                ),
                                                              ),
                                                              if(entity?.labors?[index].isMandatory ?? false) ...[
                                                                Space.h8,
                                                                Padding(
                                                                  padding: const EdgeInsets.all(AppPadding.p8),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      const Icon(
                                                                        IconManager.warning,
                                                                        size: AppSize.s24,
                                                                        color: AppTheme.redButton,
                                                                      ),
                                                                      Space.w8,
                                                                      Expanded(
                                                                        child: Text(
                                                                          'این دستمزد و قطعه برای سرویس انتخاب شده اجباری می باشد در صورت حذف امکان ثبت درخواست وجود نخواهد داشت',
                                                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                                              fontSize: AppSize.s14,
                                                                              color: AppTheme.redButton
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
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
                                                  color: AppTheme.darkThemeBoxBackgroundLight,
                                                )
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.all(AppPadding.p2),
                                              child: Icon(
                                                IconManager.delete,
                                                color: AppTheme.redButton,
                                                size: AppSize.s20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Space.h8,
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Icon(IconManager.localOffer, color: AppTheme.blue, size: AppSize.s24),
                                        Space.w4,
                                        Expanded(
                                          child: Text(
                                            '${entity?.labors?[index].laborPrice} ریال'.splitPriceByComma(),
                                            style: const TextStyle(
                                                fontFamily: FontConstants.fontFamilyPersian,
                                                fontSize: AppSize.s16,
                                                fontWeight: FontWeight.w500,
                                                color: AppTheme.colorBlack
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${entity?.labors?[index].costCenter?.name}'.splitPriceByComma(),
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontSize: AppSize.s14,
                                            color: Theme.of(context).colorScheme.onPrimary
                                        ),
                                      ),
                                    ),
                                    Space.h8,
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: entity?.labors?[index].parts?.length ?? 0,
                                      itemBuilder: (BuildContext context, int partIndex) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: AppPadding.p4),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppTheme.darkThemeBoxBackgroundLight,
                                                borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
                                                border: Border.all(
                                                    width: AppSize.s1,
                                                    color: AppTheme.darkThemeBoxBackgroundDark
                                                )
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(AppPadding.p8),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Icon(IconManager.settingSuggest, color: AppTheme.blue, size: AppSize.s18),
                                                      Space.w4,
                                                      Expanded(
                                                        child: Text(
                                                          '${entity?.labors?[index].parts?[partIndex].partTitle} ریال'.splitPriceByComma(),
                                                          style: const TextStyle(
                                                              fontFamily: FontConstants.fontFamilyPersian,
                                                              fontSize: AppSize.s14,
                                                              fontWeight: FontWeight.w500,
                                                              color: AppTheme.colorBlack
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Space.h8,
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Icon(IconManager.localOffer, color: AppTheme.blue, size: AppSize.s18),
                                                      Space.w4,
                                                      Expanded(
                                                        child: RichText(
                                                          text: TextSpan(
                                                            text: 'قیمت : ',
                                                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: AppSize.s14),
                                                            children: [
                                                              TextSpan(
                                                                text: '${entity?.labors?[index].parts?[partIndex].partPrice} ریال'.splitPriceByComma(),
                                                                style: const TextStyle(
                                                                    fontFamily: FontConstants.fontFamilyPersian,
                                                                    fontSize: AppSize.s14,
                                                                    fontWeight: FontWeight.w500,
                                                                    color: AppTheme.colorBlack
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  if(entity?.labors?[index].parts?[partIndex].hasReusable ?? false) ...[
                                                    Space.h8,
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const Icon(IconManager.localOffer, color: AppTheme.blue, size: AppSize.s18),
                                                        Space.w4,
                                                        Expanded(
                                                          child: RichText(
                                                            text: TextSpan(
                                                              text: 'قیمت (با احتساب داغی) : ',
                                                              style: const TextStyle(
                                                                  fontFamily: FontConstants.fontFamilyPersian,
                                                                  fontSize: AppSize.s14,
                                                                  fontWeight: FontWeight.w500,
                                                                  color: AppTheme.colorBlack
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text: '${(entity?.labors?[index].parts?[partIndex].partPrice ?? 0) - (entity?.labors?[index].parts?[partIndex].reusablePrice ?? 0)} ریال'.splitPriceByComma(),
                                                                  style: const TextStyle(
                                                                      fontFamily: FontConstants.fontFamilyPersian,
                                                                      fontSize: AppSize.s14,
                                                                      fontWeight: FontWeight.w500,
                                                                      color: AppTheme.colorBlack
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
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      '${entity?.labors?[index].parts?[partIndex].partCostCenterTitle}'.splitPriceByComma(),
                                                      style: const TextStyle(
                                                          fontFamily: FontConstants.fontFamilyPersian,
                                                          fontSize: AppSize.s14,
                                                          fontWeight: FontWeight.w500,
                                                          color: AppTheme.blue
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
                          _selectHomeServicePackage(context: context, entity: entity);
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: AppSize.s1,
                                color: AppTheme.blue,
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(AppPadding.p8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  IconManager.edit,
                                  size: AppSize.s24,
                                  color: AppTheme.blue,
                                ),
                                Space.w4,
                                Text(
                                  'ویرایش',
                                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                      fontSize: AppSize.s14,
                                      color: AppTheme.blue
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
  Widget homeServicesImage({required String base64StringWithPrefix }) {
    String base64String = base64StringWithPrefix.split(',').last;
    Uint8List bytes = base64Decode(base64String);
    return Image.memory(
      bytes,
      fit: BoxFit.cover,
    );
  }

  void _selectHomeServicePackage({required BuildContext context, InsertHomeServiceServiceItemResponseEntity? entity}) {
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
                FadeEffect(
                  curve: Curves.easeIn,
                  duration: 500.ms,
                ),
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
