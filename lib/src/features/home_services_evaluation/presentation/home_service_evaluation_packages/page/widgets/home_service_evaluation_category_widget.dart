import 'dart:convert';

import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_category_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_service_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/cubit/home_service_evaluation_packages_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/cubit/home_service_evaluation_packages_state.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/page/widgets/home_service_evaluation_package_widget.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/dropdown_selector.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeServiceEvaluationCategoryWidget extends StatelessWidget {
  const HomeServiceEvaluationCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(

        children: [

          FormSectionContainer(hasBorder: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleLargeText(
                  textAlign: TextAlign.start,
                  text: 'جزئیات سرویس',
                  fontSize: 16,
                ),

                Space.h32,
                _buildCategoryDropdown(context),
                Space.h16,
                _buildServiceDropdown(context),

              ],),),
          Space.h16,


          _buildServiceItemsList(context),
        ]);
  }

  Widget _buildCategoryDropdown(BuildContext context) {
    final cubit = context.read<HomeServiceEvaluationPackagesCubit>();

    return StreamBuilder<List<InsertHomeServiceCategoryResponseEntity?>>(
      stream: cubit.homeServiceCategoryListStream,
      builder: (context, snapshot) {
        final items = snapshot.data ?? [];

        return DropdownSelector<InsertHomeServiceCategoryResponseEntity>(
          label: 'دسته‌بندی سرویس',
          placeholder: 'انتخاب دسته‌بندی',
          items: items
              .whereType<InsertHomeServiceCategoryResponseEntity>()
              .toList(),
          selectedNotifier: cubit.selectedCategoryNotifier,
          itemTitleBuilder: (item) => item.categoryTitle ?? '-',
          onSelect: (category) {
            cubit.expandedIdNotifier.value = category.categoryId;
            cubit.fetchHomeServiceServices(id: category.categoryId);
            cubit.setSelectedCategory(category);
          },
        );
      },
    );
  }

  Widget _buildServiceDropdown(BuildContext context) {
    final cubit = context.read<HomeServiceEvaluationPackagesCubit>();

    return BlocBuilder<HomeServiceEvaluationPackagesCubit,
        HomeServiceEvaluationPackagesState>(
      buildWhen: (prev, next) {
        return next.maybeWhen(
          servicesLoading: (_) => true,
          servicesSuccess: (_) => true,
          orElse: () => false,
        );
      },
      builder: (context, state) {
        return StreamBuilder<List<InsertHomeServiceCategoryResponseEntity?>>(
          stream: cubit.homeServiceCategoryListStream,
          builder: (context, snapshot) {
            final categories = snapshot.data ?? [];

            final selectedCategoryId = cubit.expandedIdNotifier.value;

            final selectedCategory = categories.firstWhere(
                  (e) => e?.categoryId == selectedCategoryId,
              orElse: () => null,
            );

            final services = selectedCategory?.homeServices ?? [];

            final isLoading = state.maybeWhen(
              servicesLoading: (_) => true,
              orElse: () => false,
            );

            return DropdownSelector<InsertHomeServiceServiceItemResponseEntity>(
              label: 'سرویس',
              placeholder: 'انتخاب سرویس',
              isLoading: isLoading,
              items: services,
              enabled: true,
              itemTitleBuilder: (item) => item.title ?? '-',
              selectedNotifier: cubit.selectedServiceNotifier,

              onSelect: (service) {
                cubit.fetchHomeServicePackage(entity: service);
                cubit.setSelectedService(service);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildServiceItemsList(BuildContext context) {
    final cubit = context.read<HomeServiceEvaluationPackagesCubit>();

    return BlocBuilder<
        HomeServiceEvaluationPackagesCubit,
        HomeServiceEvaluationPackagesState>(
      buildWhen: (prev, next) {
        return next.maybeWhen(
          servicePackageLoading: () => true,
          servicePackageSuccess: () => true,
          error: (_) => true,
          orElse: () => false,
        );
      },
      builder: (context, state) {
        final pageHeight = MediaQuery.of(context).size.height;
        return state.maybeWhen(
          servicePackageLoading: () =>  SizedBox(
            height: pageHeight * 0.4,
            child: Center(
              child: CircularProgressIndicator(
                color: ServiceType.homeService.serviceColor,
              ),
            ),
          ),
        orElse: () => StreamBuilder<List<InsertHomeServiceCategoryResponseEntity?>>(
          stream: cubit.homeServiceCategoryListStream,
          builder: (context, snapshot) {
            final categories = snapshot.data ?? [];

            final selectedCategoryId = cubit.expandedIdNotifier.value;

            final category = categories.firstWhere(
                  (e) => e?.categoryId == selectedCategoryId,
              orElse: () => null,
            );

            final services = category?.homeServices ?? [];

            final shouldShow =
            state.maybeWhen(
              servicePackageSuccess: () => true,
              orElse: () => false,
            );

            if (!shouldShow) {
              return const SizedBox.shrink();
            }

            if (services.isEmpty) {
              return const SizedBox.shrink();
            }

            return FormSectionContainer(
              hasBorder: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleLargeText(
                    text: 'لیست اجرت و قطعه',
                    fontSize: 16,
                  ),

                  Space.h16,

                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: HomeServiceEvaluationPackageWidget(),
                  )
                ],
              ),
            );
          },
        ),);
      },
    );
  }

  Widget homeServicesImage({
    required String base64StringWithPrefix,
  }) {
    final base64String = base64StringWithPrefix
        .split(',')
        .last;
    final bytes = base64Decode(base64String);

    return Image.memory(
      bytes,
      fit: BoxFit.cover,
    );
  }
}
