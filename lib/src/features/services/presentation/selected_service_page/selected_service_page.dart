import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/main_app_bar.dart';
import 'package:flutter/material.dart';

class SelectedServicesPage extends StatelessWidget {
  static const path = "/selected-services";
  static const name = "selected-services";

  final ServiceType serviceType;

  const SelectedServicesPage({super.key, required this.serviceType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "درخواست های ${serviceType.label}"),
      body: const Center(),
    );
  }
}
