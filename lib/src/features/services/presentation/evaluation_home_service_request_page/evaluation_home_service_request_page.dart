
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_home_service_request_page/cubit/evaluation_home_service_request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EvaluationHomeServiceRequestPage extends StatelessWidget {
  static const path = "/evaluation-home-service-request-page";
  static const name = "evaluation-home-service-request-page";

  const EvaluationHomeServiceRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EvaluationHomeServiceRequestCubit>()..init(),
      child: const SizedBox(),
    );
  }
}

/*

showAddPartBottomSheet: () {
cubit.markBottomSheetOpen();

showAddPartBottomSheet(context).whenComplete(() {
cubit.markBottomSheetClosed();
});
},

showAddLaborBottomSheet: () {
cubit.markBottomSheetOpen();

showAddLaborBottomSheet(context).whenComplete(() {
cubit.markBottomSheetClosed();
});
},

showAddServiceBottomSheet: () {
cubit.markBottomSheetOpen();

showEmdadgarInfoBottomSheet(context).whenComplete(() {
cubit.markBottomSheetClosed();
});
},*/
