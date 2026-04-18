import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/address_to_location_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/cubit/map_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/cubit/map_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/main_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchAddressPage extends StatelessWidget {
  const SearchAddressPage({super.key});


  @override
  Widget build(BuildContext context) {
    return _build(context);
  }

  Widget _build(BuildContext context) {
    final cubit = context.read<MapCubit>();
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: const MainAppBar(
        title: 'جستجوی آدرس',
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormFieldWidget(
              contentPadding: const EdgeInsets.symmetric(horizontal: AppPadding.p12, vertical: AppPadding.p2),
              controller: cubit.searchController,
              autofocus: true,
              hintText: 'جستجوی آدرس ...',
              labelText: 'جستجوی آدرس ...',
              labelStyle: textTheme.displayMedium?.copyWith(
                fontSize: AppSize.s14,
                color: colorScheme.onTertiary,
              ),
              hintStyle: textTheme.displayMedium?.copyWith(
                fontSize: AppSize.s14,
                color: colorScheme.onTertiary,
              ),
              textStyle: textTheme.displayMedium?.copyWith(
                fontSize: AppSize.s14,
                color: colorScheme.onTertiary,
              ),
              suffixIcon: Icon(
                IconManager.search,
                size: AppSize.s24,
                color: colorScheme.onTertiary,
              ),
              onChanged: (value) => cubit.fetchAddressToLocation(),
            ),
            Space.h16,
            Text(
                'نتایج جستجو',
              style: textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: AppSize.s16
              ),
            ),
            Space.h16,
            Expanded(
              child: BlocBuilder<MapCubit, MapState>(builder: (context, state) {
                final cubit = context.read<MapCubit>();
                return state.maybeWhen(
                    searchLoading: () => const Center(child: LoadingWidget()),
                    searchSuccess: () => (cubit.addressToLocationResponseEntity.results?.isNotEmpty ?? false)
                        ? ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: cubit.addressToLocationResponseEntity.results?.length ?? 0,
                            separatorBuilder: (_, index) => Padding(
                              padding: const EdgeInsets.all(AppPadding.p4),
                              child: Divider(
                                thickness: AppSize.s1,
                                color: colorScheme.tertiary,
                              ),
                            ),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: AppPadding.p8),
                                child: AddressContainer(
                                  entity: cubit.addressToLocationResponseEntity.results?[index].geoLocation,
                                  description: cubit.addressToLocationResponseEntity.results?[index].description,
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              'جهت جستجوی آدرس حداقل سه حرف وارد کنید',
                              style: textTheme.displayMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: AppSize.s16,
                              ),
                            ),
                          ),
                    orElse: () => Center(
                          child: Text(
                            'جهت جستجوی حداقل سه حرف وارد کنید',
                            style: textTheme.displayMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: AppSize.s16,
                            ),
                          ),
                        ));
              }),
            )
          ],
        ),
      ),
    );
  }
}

class AddressContainer extends StatelessWidget {
  const AddressContainer({super.key, this.entity, this.description});

  final GeoLocationEntity? entity;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<MapCubit>().selectedAddressLocation(entity);
        Navigator.of(context).pop();
      },
      child: SizedBox(
        height: AppSize.s60,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p4, horizontal: AppPadding.p12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                IconManager.location,
                color: Theme.of(context).colorScheme.onSurface,
                size: AppSize.s28,
              ),
              Space.w8,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        entity?.title ?? '',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontSize: AppSize.s16,
                          fontWeight: FontWeight.w600,
                        ),
                    ),
                    Space.h4,
                    Expanded(
                        child: Text(
                          description ?? '',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontSize: AppSize.s16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.tertiary,
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
}
