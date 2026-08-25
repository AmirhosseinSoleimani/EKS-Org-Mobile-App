import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_part/cubit/home_service_part_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_part/cubit/home_service_part_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeServiceSearchReusablePage extends StatelessWidget {
  const HomeServiceSearchReusablePage({
    super.key,
    required this.laborIndex,
    required this.serviceIndex,
  });

  final int laborIndex;
  final int serviceIndex;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeServicePartCubit>();

    return Scaffold(
      appBar: SimpleAppBar(title: 'انتخاب قطعه داغی'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.s16),
          child: BlocConsumer<HomeServicePartCubit, HomeServicePartState>(
            listener: (context, state) {
              state.whenOrNull(
                reusablePriceSuccess: () => Navigator.of(context).pop(),
              );
            },
            builder: (context, state) {
              final isLoading = state.maybeWhen(
                loading: () => true,
                reusablePriceLoading: () => true,
                orElse: () => false,
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormFieldWidget(
                    suffixIcon: const Icon(Icons.search),
                    controller: cubit.searchReusablePartController,
                    labelText: 'نام قطعه داغی',
                    hintText: 'حداقل ۳ کاراکتر وارد کنید',
                    mandatory: true,
                    onChanged: (value) {
                      final query = value.trim();
                      if (query.length >= 3) {
                        cubit.getCustomerPart(
                          value: query,
                          laborIndex: laborIndex,
                          serviceIndex: serviceIndex,
                        );
                      }
                    },
                  ),
                  Space.h16,
                  Expanded(
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: ServiceType.homeService.serviceColor,
                            ),
                          )
                        : StreamBuilder<List<PartResponseEntity?>>(
                            stream: cubit.partResponseListSubject,
                            builder: (context, snapshot) {
                              final items = snapshot.data
                                      ?.whereType<PartResponseEntity>()
                                      .toList() ??
                                  const <PartResponseEntity>[];

                              return RefreshIndicator(
                                onRefresh: () async {
                                  final query = cubit
                                      .searchReusablePartController.text
                                      .trim();
                                  if (query.length < 3) return;

                                  await cubit.getCustomerPart(
                                    value: query,
                                    laborIndex: laborIndex,
                                    serviceIndex: serviceIndex,
                                  );
                                },
                                child: items.isEmpty
                                    ? ListView(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        children: const [
                                          SizedBox(
                                            height: AppSize.s200,
                                            child: Center(
                                              child: Text(
                                                'برای جستجو حداقل سه حرف وارد کنید',
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : ListView.separated(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        itemCount: items.length,
                                        separatorBuilder: (_, __) =>
                                            const Divider(
                                          thickness: 1,
                                          color: Colors.grey,
                                        ),
                                        itemBuilder: (context, index) {
                                          final item = items[index];
                                          final name = _cleanText(item.name);
                                          final title = name ?? 'قطعه بدون عنوان';

                                          return InkWell(
                                            onTap: item.serial == null || name == null
                                                ? null
                                                : () => cubit.getReusablePrice(
                                                      serial: item.serial,
                                                      name: name,
                                                    ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: AppSize.s12,
                                                horizontal: AppSize.s12,
                                              ),
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Text(
                                                  title,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  String? _cleanText(String? value) {
    final text = value?.trim();
    if (text == null || text.isEmpty || text.toLowerCase() == 'null') {
      return null;
    }
    return text;
  }
}
