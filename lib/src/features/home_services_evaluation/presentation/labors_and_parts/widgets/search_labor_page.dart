import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/cubit/labors_and_parts_cubit.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/labor_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/cubit/labors_and_parts_cubit.dart';

import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/cubit/labors_and_parts_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'labor_registration_page.dart';

class SearchLaborHomeServicePage extends StatelessWidget {
  const SearchLaborHomeServicePage({super.key, required this.serviceIndex});
  final int serviceIndex;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = getIt<LaborsAndPartsCubit>();
        bloc.initState();
        return bloc;
      },
      child: Builder(
        builder: (context) {
          return _build(context);
        }
      ),
    );
  }

  Widget _build(BuildContext context) {
    final cubit = context.read<LaborsAndPartsCubit>();
    return Scaffold(
      appBar: SimpleAppBar(title: 'افزودن سایر خدمات'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<LaborsAndPartsCubit, LaborsAndPartsState>(
          listener: (context, state) => state.whenOrNull(
            error: (bottomSheetMessage) {
              return BottomSheetMessage.showError(
                context: context,
                data: bottomSheetMessage,
                isDismissible: true,
                enableDrag: true,
              );
            },
          ),
          builder: (BuildContext context, state) {
            return ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                TextFormFieldWidget(

                  hintText: 'جستجو...',
                  hintStyle: TextStyle(color: Colors.grey[700]),
                  borderRadius: 16,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.start,

                  suffixIcon: const Icon(Icons.search),
                  controller: cubit.searchLaborController,
                  labelText: 'جستجو',
                  mandatory: true,
                  onChanged: (value) {
                    if(value.length >= 3) {
                      cubit.getLabors(value: value, serviceIndex: serviceIndex);
                    }
                  },
                ),
                Space.h16,
                BlocBuilder<LaborsAndPartsCubit, LaborsAndPartsState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                          success: () {
                            return StreamBuilder<List<LaborResponseEntity?>>(
                              stream: cubit.laborResponseListSubject,
                              builder: (BuildContext context, snapshot) {
                                if (snapshot.data?.isNotEmpty ?? false) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data?.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(MaterialPageRoute(builder: (_) => LaborRegistrationPage(
                                                  serviceIndex: serviceIndex,
                                                  entity: snapshot.data?[index],
                                                ),
                                                ));
                                              },
                                              child: SizedBox(
                                                width: double.maxFinite,
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
                                                  child: Text(
                                                    snapshot.data?[index]?.name ?? '',
                                                    style: Theme.of(context).textTheme.bodyMedium,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (index != (snapshot.data?.length ?? 0) - 1)
                                               Divider(
                                                thickness: 1,
                                                color:
                                                Colors.grey.withAlpha(150),
                                              )
                                          ],
                                        );
                                      });
                                } else if (cubit.searchLaborController.text.length < 3) {
                                  return const Center(
                                    child: Text(
                                        'جهت جستجو حداقل سه حرف وارد نمائید'),
                                  );
                                } else {
                                  return Center(child: Text("موردی جهت نمایش وجود ندارد"));
                                }
                              },
                            );
                      },
                          loading: () =>  Center(child: CircularProgressIndicator(color: ServiceType.homeService.serviceColor)),
                          orElse: () =>  const Center(child: Text('جهت جستجو حداقل سه حرف وارد نمائید'))
                      );
                    })
              ],
            );
          },
        ),
      ),
    );
  }
}
